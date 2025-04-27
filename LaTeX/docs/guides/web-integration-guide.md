# Resume Web Interface - Integration Guide

## Overview

This guide explains how to integrate the web interface components with your existing resume management system. The interface consists of three main HTML files:

1. **encoding_browser.html** - Main dashboard for browsing and filtering encodings
2. **encoding_detail.html** - Detailed view of a single encoding with metrics and visualizations
3. **encoding_compare.html** - Side-by-side comparison of two encodings

## Installation

### 1. Directory Structure

Create the following directory structure in your project:

```
/analysis/
  /web/
    encoding_browser.html
    encoding_detail.html
    encoding_compare.html
    /css/
      styles.css (optional - styles are currently embedded)
    /js/
      main.js (optional - scripts are currently embedded)
```

### 2. Deploying Files

1. Copy all three HTML files to the `/analysis/web/` directory
2. No additional dependencies need to be installed as all required libraries (Chart.js) are loaded from CDN

### 3. Integration with PowerShell Scripts

Add the following function to your `manage_encodings.ps1` script to launch the web interface:

```powershell
# Action: Launch web interface
if ($Action -eq "web") {
    $webPath = "analysis\web\encoding_browser.html"
    
    if (-not (Test-Path $webPath)) {
        Write-Host "Error: Web interface files not found at $webPath" -ForegroundColor Red
        exit 1
    }
    
    Write-Host "Launching web interface..." -ForegroundColor Cyan
    Start-Process $webPath
}
```

## Usage Guide

### Browser Interface

The browser interface allows you to load and explore your encodings:

1. **Load Encodings**: 
   - Navigate to `encoding_browser.html`
   - Select your `index.json` file
   - The browser will display all encodings in a grid or list view

2. **Filter and Sort**:
   - Use the sidebar to filter by tags, job descriptions, or date
   - Use the search box to find specific encodings
   - Sort by various criteria like score, date, or JD alignment

3. **View Details**:
   - Click "View Details" on any encoding card to see detailed metrics
   - The system will prompt you to load the specific encoding file

4. **Compare Encodings**:
   - Select two encodings using the checkboxes
   - Click "Compare Selected" to view side-by-side comparison

### Detail View

The detail view shows comprehensive information about a single encoding:

1. **Load Encoding File**:
   - Select the JSON file for the requested encoding
   - View metrics, charts, and JD alignment information

2. **Access Reports**:
   - Click "View HTML Report" to see the generated comparison report
   - Compare with another encoding via the action bar

### Comparison View

The comparison view shows differences between two encodings:

1. **Load Encoding Files**:
   - Select JSON files for both encodings to compare
   - View side-by-side metrics and difference indicators

2. **Significant Changes**:
   - System automatically highlights important differences
   - Shows added/removed tags and metric changes

3. **Generate Reports**:
   - Click "Generate HTML Report" to create a shareable report
   - Access the generated report via "View Report" link

## Integration with Report Generation

The web interface integrates with the HTML report feature:

1. **View Reports**:
   - Automatically detects and links to existing reports
   - Provides access to comparison reports from the detail view

2. **Generate Reports**:
   - Interface includes buttons to trigger report generation
   - Reports are stored in the standard location (`/analysis/reports/comparisons/`)

## Browser Compatibility

The interface works with all modern browsers (Chrome, Firefox, Edge, Safari) and is responsive for desktop and mobile viewing.

## Customization

### Adding Styles

If you prefer external CSS:

1. Extract the styles from each HTML file
2. Save them to `/analysis/web/css/styles.css`
3. Update the HTML files to reference the external stylesheet

### Modifying Functionality

To modify the functionality:

1. Extract the scripts from each HTML file
2. Save them to `/analysis/web/js/main.js`
3. Update the HTML files to reference the external script

## Command Line Integration

Add the following command to your resume management system:

```
./manage_encodings.ps1 -Action web
```

This will open the web interface in the default browser, providing a graphical way to explore and compare encodings.

## Advanced Usage: Server Mode

While the interface is designed to work without a server, you can improve the experience by:

1. Using a simple HTTP server:
   ```powershell
   # In PowerShell
   cd analysis
   python -m http.server 8000
   ```

2. Add this command to your script:
   ```powershell
   if ($Action -eq "serve") {
       $port = 8000
       Write-Host "Starting web server on port $port..." -ForegroundColor Cyan
       Start-Process "http://localhost:$port/web/encoding_browser.html"
       Push-Location "analysis"
       python -m http.server $port
       Pop-Location
   }
   ```

This will allow file loading without the browser's file picker dialog.
