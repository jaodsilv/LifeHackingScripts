# Organization Strategy for Resume Encodings

## Directory Structure

Create the following directory structure in your main branch:

```
analysis/
├── encodings/                  # All encoding JSON files
│   ├── resume_de_cloud_ms.json  
│   ├── resume_backend_api.json
│   └── ...
├── archive/                    # Historical encodings (optional)
│   ├── 2023/
│   └── 2024/
├── visualizations/             # Visualization tools
│   └── resume_visualization.html
├── reports/                    # Generated HTML comparison reports
│   ├── main_vs_resume_de_cloud_ms.html
│   └── resume_de_cloud_ms_vs_resume_backend_api.html
├── templates/                  # HTML templates for reports
│   └── report_template.html
├── scripts/                    # Analysis scripts
│   ├── extract_cv_resume.ps1
│   ├── manage_encodings.ps1
│   └── generate_reports.ps1
└── index.json                  # Master index of all encodings
```

## Naming Convention

Use a consistent naming convention for encoding files:

```
resume_[focus-area]_[company]_[date].json
```

Examples:
- `resume_de_cloud_ms_2023q4.json`
- `resume_backend_api_google_2022q4.json`
- `resume_fullstack_startup_2024q1.json`

## Master Index File

Create an `index.json` file to track all encodings:

```json
{
  "encodings": [
    {
      "branch_name": "resume/de_cloud_ms_2023q4",
      "encoding_file": "encodings/resume_de_cloud_ms_2023q4.json",
      "focus_tags": ["data-engineering", "cloud-infrastructure", "backend-services"],
      "weighted_score": 78,
      "created_date": "2023-10-15",
      "last_analyzed": "2023-11-02"
    },
    {
      "branch_name": "resume/backend_api_google_2022q4",
      "encoding_file": "encodings/resume_backend_api_google_2022q4.json",
      "focus_tags": ["backend-development", "api-design", "microservices"],
      "weighted_score": 82,
      "created_date": "2022-10-10",
      "last_analyzed": "2022-11-15"
    }
  ],
  "last_updated": "2024-04-26"
}
```

## PowerShell Script for Management

Create a PowerShell script (`manage_encodings.ps1`) to handle encoding file operations:

```powershell
# Script to manage encoding files
param (
    [Parameter(Mandatory=$true)]
    [ValidateSet("save", "list", "find", "compare")]
    [string]$Action,
    
    [Parameter(Mandatory=$false)]
    [string]$BranchName,
    
    [Parameter(Mandatory=$false)]
    [string]$Tags,
    
    [Parameter(Mandatory=$false)]
    [string]$Branch1,
    
    [Parameter(Mandatory=$false)]
    [string]$Branch2
)

# Configuration
$ENCODINGS_DIR = "analysis\encodings"
$INDEX_FILE = "analysis\index.json"
$VISUALIZATION_FILE = "analysis\visualizations\resume_visualization.html"

# Ensure directories exist
New-Item -ItemType Directory -Path $ENCODINGS_DIR -Force | Out-Null
New-Item -ItemType Directory -Path "analysis\visualizations" -Force | Out-Null

# Helper function to load index
function Load-Index {
    if (Test-Path $INDEX_FILE) {
        return Get-Content $INDEX_FILE | ConvertFrom-Json
    } else {
        return @{
            "encodings" = @()
            "last_updated" = (Get-Date -Format "yyyy-MM-dd")
        }
    }
}

# Helper function to save index
function Save-Index {
    param($indexData)
    $indexData.last_updated = Get-Date -Format "yyyy-MM-dd"
    $indexData | ConvertTo-Json -Depth 4 | Set-Content $INDEX_FILE
}

# Helper function to clean branch name for filename
function Get-CleanFileName {
    param($branchName)
    return $branchName -replace "[\/\\]", "_" -replace "[^a-zA-Z0-9_]", ""
}

# Action: Save a new encoding
if ($Action -eq "save") {
    $currentBranch = git branch --show-current
    $BranchName = if ($BranchName) { $BranchName } else { $currentBranch }
    
    # Clean branch name for filename
    $cleanName = Get-CleanFileName -branchName $BranchName
    $encodingFile = "$ENCODINGS_DIR\$cleanName.json"
    $relativeEncodingPath = $encodingFile.Replace("analysis\", "")
    
    # Check if ResumeEncoding.json exists
    if (-not (Test-Path "analysis\ResumeEncoding.json")) {
        Write-Host "Error: analysis\ResumeEncoding.json not found!" -ForegroundColor Red
        exit 1
    }
    
    # Copy the encoding file to the encodings directory
    Copy-Item -Path "analysis\ResumeEncoding.json" -Destination $encodingFile -Force
    Write-Host "Saved encoding to $encodingFile" -ForegroundColor Green
    
    # Load and parse the encoding data
    $encodingData = Get-Content "analysis\ResumeEncoding.json" | ConvertFrom-Json
    
    # Update the index
    $index = Load-Index
    
    # Check if this branch already has an entry
    $existingEntry = $index.encodings | Where-Object { $_.branch_name -eq $BranchName }
    
    if ($existingEntry) {
        # Update existing entry
        $existingEntry.encoding_file = $relativeEncodingPath
        $existingEntry.focus_tags = $encodingData.focus_tags
        $existingEntry.weighted_score = $encodingData.composite_scores.weighted_average
        $existingEntry.last_analyzed = (Get-Date -Format "yyyy-MM-dd")
    } else {
        # Create new entry
        $newEntry = @{
            "branch_name" = $BranchName
            "encoding_file" = $relativeEncodingPath
            "focus_tags" = $encodingData.focus_tags
            "weighted_score" = $encodingData.composite_scores.weighted_average
            "created_date" = (Get-Date -Format "yyyy-MM-dd")
            "last_analyzed" = (Get-Date -Format "yyyy-MM-dd")
        }
        $index.encodings += $newEntry
    }
    
    # Save updated index
    Save-Index -indexData $index
    Write-Host "Updated index file with latest encoding information" -ForegroundColor Green
}

# Action: List all encodings
if ($Action -eq "list") {
    $index = Load-Index
    
    if ($index.encodings.Count -eq 0) {
        Write-Host "No encodings found in the index." -ForegroundColor Yellow
    } else {
        Write-Host "Found $($index.encodings.Count) encodings:" -ForegroundColor Cyan
        Write-Host "-----------------------------------------------------------" -ForegroundColor White
        Write-Host "BRANCH NAME                     | SCORE | FOCUS TAGS" -ForegroundColor White  
        Write-Host "-----------------------------------------------------------" -ForegroundColor White
        
        $index.encodings | Sort-Object -Property weighted_score -Descending | ForEach-Object {
            $tags = $_.focus_tags -join ", "
            $branchPadded = $_.branch_name.PadRight(30)
            $scorePadded = $_.weighted_score.ToString().PadRight(5)
            Write-Host "$branchPadded | $scorePadded | $tags" -ForegroundColor White
        }
        Write-Host "-----------------------------------------------------------" -ForegroundColor White
    }
}

# Action: Find encodings by tags
if ($Action -eq "find" -and $Tags) {
    $index = Load-Index
    $searchTags = $Tags -split "," | ForEach-Object { $_.Trim() }
    
    $matchingEncodings = $index.encodings | Where-Object {
        $branchTags = $_.focus_tags
        $matchCount = 0
        foreach ($tag in $searchTags) {
            if ($branchTags -contains $tag) {
                $matchCount++
            }
        }
        $matchCount -gt 0
    } | Sort-Object -Property @{Expression={
        $branchTags = $_.focus_tags
        $matchCount = 0
        foreach ($tag in $searchTags) {
            if ($branchTags -contains $tag) {
                $matchCount++
            }
        }
        return $matchCount
    }; Descending=$true}, @{Expression="weighted_score"; Descending=$true}
    
    if ($matchingEncodings.Count -eq 0) {
        Write-Host "No encodings found matching tags: $Tags" -ForegroundColor Yellow
    } else {
        Write-Host "Found $($matchingEncodings.Count) encodings matching tags: $Tags" -ForegroundColor Cyan
        Write-Host "-----------------------------------------------------------" -ForegroundColor White
        Write-Host "BRANCH NAME                     | SCORE | MATCHING TAGS" -ForegroundColor White  
        Write-Host "-----------------------------------------------------------" -ForegroundColor White
        
        $matchingEncodings | ForEach-Object {
            $tags = $_.focus_tags -join ", "
            $branchPadded = $_.branch_name.PadRight(30)
            $scorePadded = $_.weighted_score.ToString().PadRight(5)
            Write-Host "$branchPadded | $scorePadded | $tags" -ForegroundColor White
        }
        Write-Host "-----------------------------------------------------------" -ForegroundColor White
        
        Write-Host "`nTop 3 matches:" -ForegroundColor Green
        $matchingEncodings | Select-Object -First 3 | ForEach-Object {
            $tags = $_.focus_tags -join ", "
            Write-Host "* $($_.branch_name) (Score: $($_.weighted_score))" -ForegroundColor Green
        }
    }
}

# Action: Compare two branches
if ($Action -eq "compare" -and $Branch1 -and $Branch2) {
    $index = Load-Index
    
    $entry1 = $index.encodings | Where-Object { $_.branch_name -eq $Branch1 }
    $entry2 = $index.encodings | Where-Object { $_.branch_name -eq $Branch2 }
    
    if (-not $entry1) {
        Write-Host "Error: No encoding found for branch '$Branch1'" -ForegroundColor Red
        exit 1
    }
    
    if (-not $entry2) {
        Write-Host "Error: No encoding found for branch '$Branch2'" -ForegroundColor Red
        exit 1
    }
    
    $file1 = "analysis\$($entry1.encoding_file)"
    $file2 = "analysis\$($entry2.encoding_file)"
    
    if (-not (Test-Path $file1)) {
        Write-Host "Error: Encoding file not found: $file1" -ForegroundColor Red
        exit 1
    }
    
    if (-not (Test-Path $file2)) {
        Write-Host "Error: Encoding file not found: $file2" -ForegroundColor Red
        exit 1
    }
    
    $data1 = Get-Content $file1 | ConvertFrom-Json
    $data2 = Get-Content $file2 | ConvertFrom-Json
    
    Write-Host "Comparison: $Branch1 vs $Branch2" -ForegroundColor Cyan
    Write-Host "-----------------------------------------------------------" -ForegroundColor White
    
    # Compare focus tags
    Write-Host "FOCUS TAGS:" -ForegroundColor White
    Write-Host "$Branch1: $($data1.focus_tags -join ', ')" -ForegroundColor White
    Write-Host "$Branch2: $($data2.focus_tags -join ', ')" -ForegroundColor White
    Write-Host ""
    
    # Compare composite scores
    Write-Host "COMPOSITE SCORES:" -ForegroundColor White
    Write-Host "SECTION                      | $($Branch1.PadRight(20)) | $($Branch2.PadRight(20))" -ForegroundColor White
    Write-Host "-----------------------------------------------------------" -ForegroundColor White
    
    $allSections = @($data1.composite_scores.PSObject.Properties.Name) + @($data2.composite_scores.PSObject.Properties.Name) | Select-Object -Unique | Where-Object { $_ -ne "weighted_average" }
    
    foreach ($section in $allSections) {
        $score1 = if ($data1.composite_scores.PSObject.Properties[$section]) { $data1.composite_scores.$section } else { "N/A" }
        $score2 = if ($data2.composite_scores.PSObject.Properties[$section]) { $data2.composite_scores.$section } else { "N/A" }
        
        $sectionDisplay = $section -replace "_", " " -replace "\b[a-z]", { $_.Value.ToUpper() }
        $sectionPadded = $sectionDisplay.PadRight(26)
        $score1Padded = $score1.ToString().PadRight(22)
        
        Write-Host "$sectionPadded | $score1Padded | $score2" -ForegroundColor White
    }
    
    Write-Host "-----------------------------------------------------------" -ForegroundColor White
    $avg1 = $data1.composite_scores.weighted_average
    $avg2 = $data2.composite_scores.weighted_average
    $avgPadded = "Weighted Average".PadRight(26)
    $avg1Padded = $avg1.ToString().PadRight(22)
    Write-Host "$avgPadded | $avg1Padded | $avg2" -ForegroundColor Green
    
    Write-Host "`nOpen the visualization tool to compare these encodings visually." -ForegroundColor Cyan
}
```

## HTML Report Generator

Create a PowerShell script (`generate_reports.ps1`) to generate interactive HTML comparison reports:

```powershell
# Script to generate HTML comparison reports for resume encodings
param (
    [Parameter(Mandatory=$false)]
    [string]$OutputDir = "analysis\reports",
    
    [Parameter(Mandatory=$false)]
    [string[]]$Branches,
    
    [Parameter(Mandatory=$false)]
    [switch]$AllBranches,
    
    [Parameter(Mandatory=$false)]
    [switch]$CompareToMain
)

# Configuration
$ENCODINGS_DIR = "analysis\encodings"
$INDEX_FILE = "analysis\index.json"
$TEMPLATE_FILE = "analysis\templates\report_template.html"

# Ensure directories exist
New-Item -ItemType Directory -Path $OutputDir -Force | Out-Null

# Helper function to load index
function Load-Index {
    if (Test-Path $INDEX_FILE) {
        return Get-Content $INDEX_FILE | ConvertFrom-Json
    } else {
        Write-Host "Error: Index file not found at $INDEX_FILE" -ForegroundColor Red
        exit 1
    }
}

# Function to get branch encoding data
function Get-BranchEncoding {
    param($branchName)
    
    $index = Load-Index
    $entry = $index.encodings | Where-Object { $_.branch_name -eq $branchName }
    
    if (-not $entry) {
        Write-Host "Error: No encoding found for branch '$branchName'" -ForegroundColor Red
        return $null
    }
    
    $filePath = "analysis\$($entry.encoding_file)"
    
    if (-not (Test-Path $filePath)) {
        Write-Host "Error: Encoding file not found: $filePath" -ForegroundColor Red
        return $null
    }
    
    return Get-Content $filePath | ConvertFrom-Json
}

# Function to create comparison data for two branches
function Create-ComparisonData {
    param($branch1Data, $branch2Data, $branch1Name, $branch2Name)
    
    $comparisonData = @{
        timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        branch1 = @{
            name = $branch1Name
            focus_tags = $branch1Data.focus_tags
            weighted_score = $branch1Data.composite_scores.weighted_average
        }
        branch2 = @{
            name = $branch2Name
            focus_tags = $branch2Data.focus_tags
            weighted_score = $branch2Data.composite_scores.weighted_average
        }
        sections = @()
        radar_data = @{
            labels = @()
            datasets = @(
                @{
                    label = $branch1Name
                    data = @()
                    backgroundColor = "rgba(54, 162, 235, 0.2)"
                    borderColor = "rgb(54, 162, 235)"
                    borderWidth = 1
                },
                @{
                    label = $branch2Name
                    data = @()
                    backgroundColor = "rgba(255, 99, 132, 0.2)"
                    borderColor = "rgb(255, 99, 132)"
                    borderWidth = 1
                }
            )
        }
        skill_data = @{
            labels = @()
            datasets = @(
                @{
                    label = $branch1Name
                    data = @()
                    backgroundColor = "rgba(54, 162, 235, 0.5)"
                    borderColor = "rgb(54, 162, 235)"
                    borderWidth = 1
                },
                @{
                    label = $branch2Name
                    data = @()
                    backgroundColor = "rgba(255, 99, 132, 0.5)"
                    borderColor = "rgb(255, 99, 132)"
                    borderWidth = 1
                }
            )
        }
        common_tags = @()
        unique_tags1 = @()
        unique_tags2 = @()
    }
    
    # Find common and unique tags
    foreach ($tag in $branch1Data.focus_tags) {
        if ($branch2Data.focus_tags -contains $tag) {
            $comparisonData.common_tags += $tag
        } else {
            $comparisonData.unique_tags1 += $tag
        }
    }
    
    foreach ($tag in $branch2Data.focus_tags) {
        if ($branch1Data.focus_tags -notcontains $tag) {
            $comparisonData.unique_tags2 += $tag
        }
    }
    
    # Process sections for composite scores
    $allSections = @($branch1Data.composite_scores.PSObject.Properties.Name) + @($branch2Data.composite_scores.PSObject.Properties.Name) | 
        Select-Object -Unique | 
        Where-Object { $_ -ne "weighted_average" }
    
    foreach ($section in $allSections) {
        $score1 = if ($branch1Data.composite_scores.PSObject.Properties[$section]) { $branch1Data.composite_scores.$section } else { 0 }
        $score2 = if ($branch2Data.composite_scores.PSObject.Properties[$section]) { $branch2Data.composite_scores.$section } else { 0 }
        $diff = $score2 - $score1
        
        $sectionDisplayName = $section -replace "_", " " -replace "\b[a-z]", { $_.Value.ToUpper() }
        
        $comparisonData.sections += @{
            name = $sectionDisplayName
            score1 = $score1
            score2 = $score2
            diff = $diff
        }
        
        # Add to radar chart data
        $comparisonData.radar_data.labels += $sectionDisplayName
        $comparisonData.radar_data.datasets[0].data += $score1
        $comparisonData.radar_data.datasets[1].data += $score2
    }
    
    # Process skills data - if available
    if ($branch1Data.detailed_scores.PSObject.Properties["technical_skills"] -and 
        $branch2Data.detailed_scores.PSObject.Properties["technical_skills"]) {
        
        $skills1 = $branch1Data.detailed_scores.technical_skills
        $skills2 = $branch2Data.detailed_scores.technical_skills
        
        $allSkills = @($skills1.PSObject.Properties.Name) + @($skills2.PSObject.Properties.Name) | Select-Object -Unique
        
        foreach ($skill in $allSkills) {
            $score1 = if ($skills1.PSObject.Properties[$skill]) { $skills1.$skill } else { 0 }
            $score2 = if ($skills2.PSObject.Properties[$skill]) { $skills2.$skill } else { 0 }
            
            $skillDisplayName = $skill -replace "_", " " -replace "\b[a-z]", { $_.Value.ToUpper() }
            
            $comparisonData.skill_data.labels += $skillDisplayName
            $comparisonData.skill_data.datasets[0].data += $score1
            $comparisonData.skill_data.datasets[1].data += $score2
        }
    }
    
    return $comparisonData
}

# Function to generate HTML report
function Generate-HtmlReport {
    param($comparisonData, $outputFile)
    
    # Read HTML template or create default if it doesn't exist
    if (-not (Test-Path $TEMPLATE_FILE)) {
        # Create template directories
        New-Item -ItemType Directory -Path "analysis\templates" -Force | Out-Null
        
        # Create a default template (HTML content would go here)
        $templateHtml = "<!DOCTYPE html>
<html>
<head>
    <title>Resume Comparison Report</title>
    <!-- Template HTML content truncated for brevity -->
</head>
<body>
    <!-- Report structure -->
</body>
</html>"
        $templateHtml | Set-Content -Path $TEMPLATE_FILE -Force
    }
    
    $template = Get-Content -Path $TEMPLATE_FILE -Raw
    
    # Process comparison data and generate the HTML report
    # (Implementation details omitted for brevity)
    
    # Save the report
    $outputHtml | Set-Content -Path $outputFile -Force
    Write-Host "Report generated: $outputFile" -ForegroundColor Green
}

# Main execution
if ($AllBranches) {
    # Get all branches from the index
    $Branches = $index.encodings | ForEach-Object { $_.branch_name }
}

if ($Branches -and $Branches.Count -gt 0) {
    if ($CompareToMain) {
        # Compare each branch to main
        $mainData = Get-BranchEncoding -branchName "main"
        if ($mainData) {
            foreach ($branch in $Branches) {
                $branchData = Get-BranchEncoding -branchName $branch
                if ($branchData) {
                    # Generate comparison report between main and this branch
                    $comparisonData = Create-ComparisonData -branch1Data $mainData -branch2Data $branchData -branch1Name "main" -branch2Name $branch
                    $outputFile = "$OutputDir\main_vs_$(Get-CleanFileName -branchName $branch).html"
                    Generate-HtmlReport -comparisonData $comparisonData -outputFile $outputFile
                }
            }
        }
    } else {
        # Compare branches pairwise
        if ($Branches.Count -gt 1) {
            for ($i = 0; $i -lt $Branches.Count - 1; $i++) {
                for ($j = $i + 1; $j -lt $Branches.Count; $j++) {
                    $branch1 = $Branches[$i]
                    $branch2 = $Branches[$j]
                    
                    $branch1Data = Get-BranchEncoding -branchName $branch1
                    $branch2Data = Get-BranchEncoding -branchName $branch2
                    
                    if ($branch1Data -and $branch2Data) {
                        # Generate comparison report between these branches
                        $comparisonData = Create-ComparisonData -branch1Data $branch1Data -branch2Data $branch2Data -branch1Name $branch1 -branch2Name $branch2
                        $outputFile = "$OutputDir\$(Get-CleanFileName -branchName $branch1)_vs_$(Get-CleanFileName -branchName $branch2).html"
                        Generate-HtmlReport -comparisonData $comparisonData -outputFile $outputFile
                    }
                }
            }
        } else {
            Write-Host "Please provide more than one branch for comparison or use the -CompareToMain switch." -ForegroundColor Yellow
        }
    }
} else {
    Write-Host "No branches specified for report generation. Use -Branches or -AllBranches parameter." -ForegroundColor Yellow
    Write-Host "Example: .\generate_reports.ps1 -Branches resume/branch1,resume/branch2" -ForegroundColor Yellow
}

Write-Host "Report generation complete." -ForegroundColor Green
```

## Usage Workflow

### Saving a New Encoding

After analyzing a resume branch:

1. Generate the `ResumeEncoding.json` using Cursor
2. Save it to the central repository:

```powershell
# From any branch, after generating ResumeEncoding.json
.\analysis\scripts\manage_encodings.ps1 -Action save
```

### Finding the Best Resume for a Job

When you need to find a matching resume:

```powershell
# List all available encodings
.\analysis\scripts\manage_encodings.ps1 -Action list

# Find resumes matching specific tags
.\analysis\scripts\manage_encodings.ps1 -Action find -Tags "cloud-infrastructure,data-engineering"

# Compare two resume branches
.\analysis\scripts\manage_encodings.ps1 -Action compare -Branch1 "resume/de_cloud_ms" -Branch2 "resume/backend_api"
```

### Generating Comparison Reports

To generate visual HTML reports comparing resume versions:

```powershell
# Compare specific branches
.\analysis\scripts\generate_reports.ps1 -Branches "resume/de_cloud_ms","resume/backend_api"

# Compare all branches to main
.\analysis\scripts\generate_reports.ps1 -AllBranches -CompareToMain

# Generate all possible comparisons
.\analysis\scripts\generate_reports.ps1 -AllBranches
```

### Visualizing an Encoding

1. Open the visualization tool in your browser:
   `analysis/visualizations/resume_visualization.html`

2. Load the specific encoding file:
   `analysis/encodings/resume_de_cloud_ms_2023q4.json`

3. View generated HTML comparison reports:
   `analysis/reports/main_vs_resume_de_cloud_ms.html`

## Batch Processing 

For analyzing multiple branches in sequence, create a batch script:

```powershell
# analyze_all_branches.ps1
$branches = git branch | Where-Object { $_ -match "resume/" } | ForEach-Object { $_.Trim().Replace("* ", "") }

foreach ($branch in $branches) {
    Write-Host "Analyzing branch: $branch" -ForegroundColor Cyan
    
    # Checkout branch
    git checkout $branch
    
    # Run extraction and analysis
    .\extract_cv_resume.ps1
    # [Run Cursor analysis here manually]
    
    # Save encoding
    .\analysis\scripts\manage_encodings.ps1 -Action save
}

# Return to original branch
git checkout main

# Generate comparison reports
.\analysis\scripts\generate_reports.ps1 -AllBranches -CompareToMain
```

## Maintenance Best Practices

1. **Regular updates**: Run the analysis on each branch periodically to keep encodings current

2. **Versioning**: For significant changes to a resume, create a new encoding with a version suffix:
   `resume_de_cloud_ms_2023q4_v2.json`

3. **Archiving**: Move older encodings to the archive directory when they're no longer relevant:
   ```powershell
   # Create archive structure
   $year = (Get-Date).Year
   New-Item -ItemType Directory -Path "analysis\archive\$year" -Force | Out-Null
   
   # Move file to archive
   Move-Item "analysis\encodings\old_resume.json" "analysis\archive\$year\"
   ```

4. **Documentation**: Add comments to the index entries for important information:
   ```json
   "comment": "Strong emphasis on cloud migration experience"
   ```

5. **Backup**: Periodically backup the entire analysis directory