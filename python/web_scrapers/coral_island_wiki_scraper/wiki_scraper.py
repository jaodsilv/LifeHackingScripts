import requests
from bs4 import BeautifulSoup
import re
from urllib.parse import urljoin
import json
import os

class WikiScraper:
    def __init__(self, base_url, section_name):
        self.base_url = base_url
        self.section_name = section_name
        self.session = requests.Session()
        self.results = {}

    def get_page_content(self, url):
        """Fetch and parse a wiki page."""
        try:
            response = self.session.get(url)
            response.raise_for_status()
            return BeautifulSoup(response.text, 'html.parser')
        except Exception as e:
            print(f"Error fetching {url}: {str(e)}")
            return None

    def find_section_links(self, soup):
        """Find all links under the specified section."""
        # Find all section headers
        headers = soup.find_all(['h2', 'h3'])
        print(f"Found {len(headers)} headers on the page")
        
        # Find our target section
        target_section = None
        for header in headers:
            header_text = header.get_text(strip=True)
            print(f"Found header: '{header_text}'")
            if header_text == self.section_name:
                target_section = header
                break
        
        if not target_section:
            print(f"Section '{self.section_name}' not found")
            print("Available sections:")
            for header in headers:
                print(f"- {header.get_text(strip=True)}")
            return []

        print("\nAnalyzing section structure:")
        links = []
        
        # Find the next main section to determine where to stop
        next_main_section = target_section.find_next('h2')
        
        # Process all content until the next main section
        current = target_section.find_next()
        while current and current != next_main_section:
            # If we find a subsection (h3), process it
            if current.name == 'h3':
                subsection_name = current.get_text(strip=True)
                print(f"\nProcessing subsection: {subsection_name}")
                
                # Process all content until the next h3 or h2
                subsection_content = current.find_next()
                while subsection_content and subsection_content.name not in ['h2', 'h3']:
                    # Look for links in any element
                    for link in subsection_content.find_all('a'):
                        href = link.get('href')
                        if href and not href.startswith('#'):
                            full_url = urljoin(self.base_url, href)
                            if full_url not in links:
                                links.append(full_url)
                                print(f"Found link in {subsection_name}: {full_url}")
                    
                    subsection_content = subsection_content.find_next()
            # If we find a list (ul or ol), process it directly
            elif current.name in ['ul', 'ol']:
                print("\nProcessing list directly")
                for link in current.find_all('a'):
                    href = link.get('href')
                    if href and not href.startswith('#'):
                        full_url = urljoin(self.base_url, href)
                        if full_url not in links:
                            links.append(full_url)
                            print(f"Found link in list: {full_url}")
            # If we find a paragraph or div, look for links in it
            elif current.name in ['p', 'div']:
                print("\nProcessing content block")
                for link in current.find_all('a'):
                    href = link.get('href')
                    if href and not href.startswith('#'):
                        full_url = urljoin(self.base_url, href)
                        if full_url not in links:
                            links.append(full_url)
                            print(f"Found link in content: {full_url}")
            # If we find a table, look for links in it
            elif current.name == 'table':
                print("\nProcessing table")
                for link in current.find_all('a'):
                    href = link.get('href')
                    if href and not href.startswith('#'):
                        full_url = urljoin(self.base_url, href)
                        if full_url not in links:
                            links.append(full_url)
                            print(f"Found link in table: {full_url}")
            
            current = current.find_next()

        print(f"\nFound {len(links)} links in section '{self.section_name}'")
        return links

    def get_quality_name(self, th):
        """Extract quality name from a table header cell."""
        # First check for data-source attribute
        data_source = th.get('data-source', '')
        if data_source:
            # Map data-source values to quality names
            quality_map = {
                'sell': 'Base',
                'bronze': 'Bronze',
                'silver': 'Silver',
                'gold': 'Gold',
                'osmium': 'Osmium'
            }
            return quality_map.get(data_source, data_source)

        # If no data-source, try to get text directly
        text = th.get_text(strip=True)
        if text:
            return text

        # If still no text, look for custom-icon-text
        icon_text = th.find('span', {'class': 'custom-icon-text'})
        if icon_text:
            icon_text_value = icon_text.get_text(strip=True)
            if icon_text_value:
                return icon_text_value

        return "Unknown"

    def extract_sell_prices(self, soup):
        """Extract sell prices for different item qualities."""
        prices = {}
        
        # Find the portable infobox
        infobox = soup.find('aside', {'class': 'portable-infobox'})
        if not infobox:
            print("No infobox found")
            return prices

        print("\nFound infobox, looking for sell prices...")
        
        # Find all tables in the infobox
        tables = infobox.find_all('table', {'class': 'pi-horizontal-group'})
        print(f"Found {len(tables)} tables in infobox")
        
        # Look for the sell prices table
        sell_table = None
        for table in tables:
            caption = table.find('caption')
            if caption:
                caption_text = caption.get_text(strip=True)
                print(f"Found table with caption: {caption_text}")
                if caption_text == "Sell prices":
                    sell_table = table
                    print("Found sell prices table")
                    break

        if not sell_table:
            print("No sell prices table found")
            return prices

        # Get the header row
        header_row = sell_table.find('thead').find('tr')
        if not header_row:
            print("No header row found")
            return prices

        # Get quality names from header
        qualities = []
        for th in header_row.find_all('th'):
            quality = self.get_quality_name(th)
            if quality:
                qualities.append(quality)
                print(f"Found quality: {quality}")

        if not qualities:
            print("No qualities found in header")
            return prices

        # Get price values
        value_row = sell_table.find('tbody').find('tr')
        if not value_row:
            print("No value row found")
            return prices

        # Match qualities with their prices
        for td, quality in zip(value_row.find_all('td'), qualities):
            price_text = td.get_text(strip=True)
            price_match = re.search(r'(\d+)', price_text)
            if price_match:
                prices[quality] = int(price_match.group(1))
                print(f"Found {quality} price: {prices[quality]}")

        return prices

    def process_page(self, url):
        """Process a single page and extract sell prices."""
        print(f"\nProcessing page: {url}")
        soup = self.get_page_content(url)
        if not soup:
            return

        # Get the item name from the page title
        title = soup.find('h1', {'id': 'firstHeading'})
        if not title:
            print("Could not find page title")
            return

        item_name = title.get_text(strip=True)
        print(f"Processing item: {item_name}")
        
        prices = self.extract_sell_prices(soup)
        
        if prices:
            self.results[item_name] = prices
            print(f"Successfully extracted prices for {item_name}")
        else:
            print(f"No prices found for {item_name}")

    def scrape(self):
        """Main scraping process."""
        print(f"\nStarting scrape of {self.base_url}")
        print(f"Looking for section: {self.section_name}")
        
        # Get the main page
        main_soup = self.get_page_content(self.base_url)
        if not main_soup:
            return

        # Find all links in the specified section
        links = self.find_section_links(main_soup)
        
        if not links:
            print("No links found to process")
            return

        # Process each linked page
        for link in links:
            self.process_page(link)

        return self.results

    def save_results(self, filename):
        """Save the scraped results to a JSON file."""
        with open(filename, 'w', encoding='utf-8') as f:
            json.dump(self.results, f, indent=2, ensure_ascii=False)
        print(f"Results saved to {filename}")

def main():
    # Get user input
    base_url = input("Enter the base wiki URL: ").strip()
    section_name = input("Enter the section name to scrape: ").strip()
    output_file = input("Enter the output filename (default: wiki_data.json): ").strip() or "wiki_data.json"
    
    # Create and run the scraper
    scraper = WikiScraper(base_url, section_name)
    results = scraper.scrape()
    
    if results:
        scraper.save_results(output_file)
        print(f"Successfully scraped {len(results)} items")
    else:
        print("No results found")

if __name__ == "__main__":
    main() 