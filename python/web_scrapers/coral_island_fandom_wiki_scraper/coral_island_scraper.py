import json
import re
from bs4 import BeautifulSoup
from urllib.parse import urljoin
import sys
import os

# Add the parent directory to the Python path
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from base_scraper import BaseScraper

class CoralIslandScraper(BaseScraper):
    def __init__(self, base_url, section_name):
        super().__init__(base_url)
        self.section_name = section_name
        
    def find_section_links(self, soup):
        """Find all item links in the section."""
        links = []
        
        # Print all h2 and h3 headers for debugging
        print("\nAvailable sections:")
        for header in soup.find_all(['h2', 'h3']):
            print(f"- {header.text.strip()}")
        
        # Find the section by looking for headers that contain our section name
        section = None
        for header in soup.find_all(['h2', 'h3']):
            if self.section_name.lower() in header.text.lower():
                section = header
                break
                
        if not section:
            print(f"\nSection '{self.section_name}' not found")
            return links
            
        print(f"\nFound section: {section.text.strip()}")
        
        # Print the HTML block for debugging
        print("\nSection HTML block:")
        print(section.prettify())
            
        # Find the next div with class columntemplate or any content div
        section_div = section.find_next('div', class_='columntemplate')
        if not section_div:
            section_div = section.find_next('div', class_='mw-parser-output')
            
        if not section_div:
            print("Section div not found")
            return links
            
        # Print the content div for debugging
        print("\nContent div HTML block:")
        print(section_div.prettify())
            
        # Find all links in the section
        for link in section_div.find_all('a'):
            href = link.get('href')
            if href and not href.startswith('#'):
                full_url = self.get_absolute_url(href)
                # Only include links that point to item pages and are not in the Uses section
                if '/wiki/' in full_url and not any(x in full_url for x in ['Category:', 'Special:', 'Help:', 'Template:', 'Quest', 'Uses']):
                    # Check if this is a vegetable item page
                    if not any(x in full_url for x in ['_group', 'Farming', 'Foraging']):
                        links.append(full_url)
                        print(f"Found item: {full_url}")
                
        return links

    def get_quality_name(self, th):
        """Extract quality name from table header."""
        # For Coral Island, qualities are in the data-source attribute
        quality = th.get('data-source', '')
        if quality == 'sell':
            return 'Base'
        return quality.capitalize()

    def extract_sell_prices(self, soup):
        """Extract sell prices from the infobox tables."""
        prices = {}
        
        # Find all price tables
        price_tables = soup.find_all('table', class_='pi-horizontal-group')
        
        for table in price_tables:
            caption = table.find('caption')
            if not caption:
                continue
                
            # Check if this is a price table
            if 'Sell prices' not in caption.text:
                continue
                
            # Get all quality levels from headers
            headers = table.find_all('th')
            for header in headers:
                quality = self.get_quality_name(header)
                if quality not in prices:
                    prices[quality] = None
                    
            # Get prices from the first row
            row = table.find('tr')
            if row:
                cells = row.find_all('td')
                for i, cell in enumerate(cells):
                    if i < len(headers):
                        quality = self.get_quality_name(headers[i])
                        try:
                            price = int(cell.text.strip())
                            prices[quality] = price
                        except ValueError:
                            continue
                            
        return prices

    def process_page(self, url):
        """Process a single item page."""
        soup = self.get_soup(url)
        if not soup:
            return None
            
        # Print only the body content for debugging (only for the first item)
        if not hasattr(self, '_debug_printed'):
            print("\nFirst item page body content:")
            body = soup.find('body')
            if body:
                print(body.prettify())
            self._debug_printed = True
            
        # Get item name from the title
        title = soup.find('h2', class_='pi-item pi-item-spacing pi-title')
        if not title:
            return None
            
        item_name = title.text.strip()
        
        # Get sell prices
        prices = self.extract_sell_prices(soup)
        
        # Only return if we found prices
        if prices:
            return {
                'name': item_name,
                'prices': prices
            }
        return None

    def scrape(self):
        """Main scraping function."""
        # Get the main page content
        soup = self.get_soup(self.base_url)
        if not soup:
            return
            
        # Find all item links in the section
        links = self.find_section_links(soup)
        
        # Remove duplicates while preserving order
        unique_links = []
        seen = set()
        for link in links:
            if link not in seen:
                seen.add(link)
                unique_links.append(link)
        
        print(f"\nFound {len(unique_links)} unique items to process")
        
        # Process each item
        for i, link in enumerate(unique_links, 1):
            print(f"Processing item {i}/{len(unique_links)}: {link}")
            result = self.process_page(link)
            if result:
                self.results.append(result)
                
        print(f"Successfully processed {len(self.results)} items")

    def save_results(self, filename):
        """Save the results to a JSON file."""
        with open(filename, 'w', encoding='utf-8') as f:
            json.dump(self.results, f, indent=2, ensure_ascii=False)
        print(f"Results saved to {filename}")

def main():
    # Get user input
    base_url = input("Enter the base URL of the wiki: ").strip()
    section_name = input("Enter the section name to scrape: ").strip()
    output_file = input("Enter the output filename (default: coral_island_prices.json): ").strip() or "coral_island_prices.json"
    
    # Create and run scraper
    scraper = CoralIslandScraper(base_url, section_name)
    scraper.scrape()
    scraper.save_results(output_file)

if __name__ == "__main__":
    main() 