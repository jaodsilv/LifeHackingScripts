import os
import mimetypes
from concurrent.futures import ThreadPoolExecutor
import time
import re
from ..base_scraper import BaseScraper

class ImageDownloader(BaseScraper):
    def __init__(self, output_dir="downloaded_images", path_pattern=None, filename_pattern=None, list_only=False, list_file="image_paths.txt"):
        super().__init__(None)  # No base URL needed for this scraper
        self.output_dir = output_dir
        self.visited_urls = set()
        self.downloaded_count = 0
        self.list_only = list_only
        self.list_file = list_file
        self.found_files = []
        
        # Compile regex patterns if provided
        self.path_pattern = re.compile(path_pattern) if path_pattern else None
        self.filename_pattern = re.compile(filename_pattern) if filename_pattern else None
        
        # Create output directory if it doesn't exist
        if not os.path.exists(output_dir):
            os.makedirs(output_dir)
    
    def is_image(self, url):
        """Check if the URL points to an image file."""
        mime_type, _ = mimetypes.guess_type(url)
        return mime_type and mime_type.startswith('image/')
    
    def should_process_path(self, url):
        """Check if the path matches the path pattern."""
        if not self.path_pattern:
            return True
        return bool(self.path_pattern.search(url))
    
    def should_process_filename(self, filename):
        """Check if the filename matches the filename pattern."""
        if not self.filename_pattern:
            return True
        return bool(self.filename_pattern.search(filename))
    
    def download_image(self, image_url, local_path):
        """Download a single image or add it to the list."""
        if self.list_only:
            self.found_files.append(image_url)
            print(f"Found: {image_url}")
            self.downloaded_count += 1
            return True
            
        try:
            response = self.session.get(image_url, stream=True)
            response.raise_for_status()
            
            with open(local_path, 'wb') as f:
                for chunk in response.iter_content(chunk_size=8192):
                    if chunk:
                        f.write(chunk)
            print(f"Downloaded: {image_url}")
            self.downloaded_count += 1
            return True
        except Exception as e:
            print(f"Error downloading {image_url}: {str(e)}")
            return False
    
    def process_url(self, url):
        """Process a URL and download images from it."""
        if url in self.visited_urls:
            return
        
        # Check if the path matches the pattern
        if not self.should_process_path(url):
            print(f"Skipping path (doesn't match pattern): {url}")
            return
        
        self.visited_urls.add(url)
        print(f"Processing: {url}")
        
        try:
            soup = self.get_soup(url)
            if not soup:
                return
            
            # Find all links
            for link in soup.find_all('a'):
                href = link.get('href')
                if not href:
                    continue
                
                # Skip "Parent Directory" link
                if link.text.strip() == "Parent Directory":
                    continue
                
                # Construct absolute URL
                absolute_url = self.get_absolute_url(url, href)
                
                # Skip if we've already visited this URL
                if absolute_url in self.visited_urls:
                    continue
                
                # If it's an image, download it
                if self.is_image(absolute_url):
                    filename = os.path.basename(absolute_url)
                    # Check if filename matches the pattern
                    if self.should_process_filename(filename):
                        local_path = os.path.join(self.output_dir, filename)
                        self.download_image(absolute_url, local_path)
                    else:
                        print(f"Skipping file (doesn't match pattern): {filename}")
                # If it's a directory, process it recursively
                elif href.endswith('/'):
                    self.process_url(absolute_url)
                
        except Exception as e:
            print(f"Error processing {url}: {str(e)}")
    
    def save_file_list(self):
        """Save the list of found files to a text file."""
        if not self.found_files:
            return
            
        with open(self.list_file, 'w', encoding='utf-8') as f:
            for file_url in self.found_files:
                f.write(f"{file_url}\n")
        print(f"\nFile list saved to: {self.list_file}")

def get_urls_from_user():
    """Get multiple URLs from user input."""
    print("Enter URLs (one per line). Press Enter twice to finish:")
    urls = []
    while True:
        url = input().strip()
        if not url:
            break
        urls.append(url)
    return urls

def main():
    # Get URLs from user input
    print("Enter the URLs to process (one per line, press Enter twice to finish):")
    urls = get_urls_from_user()
    
    if not urls:
        print("No URLs provided. Exiting.")
        return
    
    # Get regex patterns from user input
    path_pattern = input("Enter regex pattern for paths (press Enter to skip): ").strip() or None
    filename_pattern = input("Enter regex pattern for filenames (press Enter to skip): ").strip() or None
    
    # Ask if user wants to only list files
    list_only = input("Do you want to only list files without downloading? (y/n): ").lower().strip() == 'y'
    list_file = None
    if list_only:
        list_file = input("Enter output file name for the list (default: image_paths.txt): ").strip() or "image_paths.txt"
    
    # Create downloader instance
    downloader = ImageDownloader(
        path_pattern=path_pattern,
        filename_pattern=filename_pattern,
        list_only=list_only,
        list_file=list_file
    )
    
    # Process each URL
    print(f"\nStarting {'file listing' if list_only else 'download'} process...")
    for url in urls:
        print(f"\nProcessing URL: {url}")
        downloader.process_url(url)
    
    if list_only:
        downloader.save_file_list()
        print(f"\nProcess completed!")
        print(f"Total files found: {downloader.downloaded_count}")
    else:
        print(f"\nDownload process completed!")
        print(f"Total files downloaded: {downloader.downloaded_count}")

if __name__ == "__main__":
    main() 