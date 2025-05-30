import requests
from bs4 import BeautifulSoup
import json
from urllib.parse import urljoin
import os

class BaseScraper:
    def __init__(self, base_url):
        self.base_url = base_url
        self.session = requests.Session()
        self.results = []
        
    def get_page_content(self, url):
        """Get the HTML content of a page."""
        try:
            response = self.session.get(url)
            response.raise_for_status()
            return response.text
        except Exception as e:
            print(f"Error fetching {url}: {str(e)}")
            return None
            
    def get_soup(self, url):
        """Get BeautifulSoup object for a URL."""
        content = self.get_page_content(url)
        if not content:
            return None
        return BeautifulSoup(content, 'html.parser')
        
    def save_results(self, filename, data=None):
        """Save the results to a JSON file."""
        if data is None:
            data = self.results
            
        # Create directory if it doesn't exist
        os.makedirs(os.path.dirname(filename), exist_ok=True)
        
        with open(filename, 'w', encoding='utf-8') as f:
            json.dump(data, f, indent=2, ensure_ascii=False)
        print(f"Results saved to {filename}")
        
    def get_absolute_url(self, relative_url):
        """Convert a relative URL to an absolute URL."""
        return urljoin(self.base_url, relative_url) 