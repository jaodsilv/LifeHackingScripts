# Script to manage HTML resume comparison reports
# Save as report-manager.ps1 and run from the repository root
param (
    [Parameter(Mandatory=$true)]
    [ValidateSet("list", "cleanup", "regenerate", "timeline", "index")]
    [string]$Action,
    
    [Parameter(Mandatory=$false)]
    [string]$Branch,
    
    [Parameter(Mandatory=$false)]
    [int]$RetentionDays = 90,
    
    [Parameter(Mandatory=$false)]
    [string]$OutputDir = "analysis\reports",
    
    [Parameter(Mandatory=$false)]
    [switch]$Force
)

# Configuration
$ENCODINGS_DIR = "analysis\encodings"
$INDEX_FILE = "analysis\index.json"
$REPORTS_INDEX_FILE = "analysis\reports\reports_index.json"
$COMPARISONS_DIR = "analysis\reports\comparisons"
$TIMELINES_DIR = "analysis\reports\timelines"
$JD_MATCHES_DIR = "analysis\reports\jd_matches"

# Ensure directories exist
New-Item -ItemType Directory -Path $OutputDir -Force | Out-Null
New-Item -ItemType Directory -Path $COMPARISONS_DIR -Force | Out-Null
New-Item -ItemType Directory -Path $TIMELINES_DIR -Force | Out-Null
New-Item -ItemType Directory -Path $JD_MATCHES_DIR -Force | Out-Null

# Helper function to load index
function Load-Index {
    if (Test-Path $INDEX_FILE) {
        return Get-Content $INDEX_FILE | ConvertFrom-Json
    } else {
        Write-Host "Error: Index file not found at $INDEX_FILE" -ForegroundColor Red
        exit 1
    }
}

# Helper function to load reports index
function Load-ReportsIndex {
    if (Test-Path $REPORTS_INDEX_FILE) {
        return Get-Content $REPORTS_INDEX_FILE | ConvertFrom-Json
    } else {
        return @{
            "reports" = @()
            "latest_by_branch" = @{}
            "significant_changes" = @()
            "last_updated" = (Get-Date -Format "yyyy-MM-dd")
        }
    }
}

# Helper function to save reports index
function Save-ReportsIndex {
    param($indexData)
    $indexData.last_updated = Get-Date -Format "yyyy-MM-dd"
    $indexData | ConvertTo-Json -Depth 4 | Set-Content $REPORTS_INDEX_FILE
}

# Helper function to clean filename
function Get-CleanFileName {
    param($name)
    return $name -replace "[\/\\]", "_" -replace "[^a-zA-Z0-9_]", ""
}

# Helper function to check if a change is significant
function Is-SignificantChange {
    param($report)
    
    # Define thresholds for significant changes
    $SCORE_THRESHOLD = 5  # 5% difference in overall score is significant
    $JD_ALIGNMENT_THRESHOLD = 10  # 10% difference in JD alignment is significant
    $TAG_CHANGE_THRESHOLD = 2  # 2 or more tag changes is significant
    
    if ([Math]::Abs($report.score_diff) -ge $SCORE_THRESHOLD) {
        return $true
    }
    
    if ($report.jd_alignment_diff -and [Math]::Abs($report.jd_alignment_diff) -ge $JD_ALIGNMENT_THRESHOLD) {
        return $true
    }
    
    if ($report.tags_added -and $report.tags_added.Count -ge $TAG_CHANGE_THRESHOLD) {
        return $true
    }
    
    if ($report.tags_removed -and $report.tags_removed.Count -ge $TAG_CHANGE_THRESHOLD) {
        return $true
    }
    
    return $false
}

# Helper function to add a report to the index
function Add-ReportToIndex {
    param($reportInfo)
    
    $reportsIndex = Load-ReportsIndex
    
    # Check if this report ID already exists
    $existingReport = $reportsIndex.reports | Where-Object { $_.id -eq $reportInfo.id }
    
    if ($existingReport) {
        # Update existing report
        foreach ($key in $reportInfo.PSObject.Properties.Name) {
            $existingReport.$key = $reportInfo.$key
        }
    } else {
        # Add new report
        $reportsIndex.reports += $reportInfo
        
        # Update latest_by_branch
        if ($reportInfo.branch1 -and $reportInfo.branch2) {
            $reportsIndex.latest_by_branch[$reportInfo.branch1] = $reportInfo.id
            $reportsIndex.latest_by_branch[$reportInfo.branch2] = $reportInfo.id
        }
        
        # Check if this is a significant change
        if ($reportInfo.significant_changes) {
            $reportsIndex.significant_changes += $reportInfo.id
        }
    }
    
    # Save updated index
    Save-ReportsIndex -indexData $reportsIndex
    
    return $reportInfo.id
}

# Helper function to generate a comparison report
function Generate-ComparisonReport {
    param($branch1, $branch2, $outputPath)
    
    # Call the report generator script
    & .\html-report-generator.ps1 -OutputDir (Split-Path $outputPath -Parent) -Branches "$branch1,$branch2" -OutputFile (Split-Path $outputPath -Leaf) -Silent
    
    # Check if the report was generated
    if (Test-Path $outputPath) {
        Write-Host "Generated comparison report: $outputPath" -ForegroundColor Green
        return $true
    } else {
        Write-Host "Failed to generate comparison report for $branch1 vs $branch2" -ForegroundColor Red
        return $false
    }
}

# Helper function to extract report metadata
function Extract-ReportMetadata {
    param($branch1, $branch2, $reportPath)
    
    $index = Load-Index
    
    $entry1 = $index.encodings | Where-Object { $_.branch_name -eq $branch1 }
    $entry2 = $index.encodings | Where-Object { $_.branch_name -eq $branch2 }
    
    if (-not $entry1 -or -not $entry2) {
        Write-Host "Warning: Missing encoding entries for branches" -ForegroundColor Yellow
        return $null
    }
    
    # Calculate differences
    $scoreDiff = $entry2.weighted_score - $entry1.weighted_score
    
    # Check for JD alignment difference
    $jdAlignmentDiff = $null
    if ($entry1.PSObject.Properties["jd_alignment"] -and $entry2.PSObject.Properties["jd_alignment"]) {
        $jdAlignmentDiff = $entry2.jd_alignment - $entry1.jd_alignment
    }
    
    # Identify tag changes
    $tagsAdded = @()
    $tagsRemoved = @()
    
    foreach ($tag in $entry2.focus_tags) {
        if ($entry1.focus_tags -notcontains $tag) {
            $tagsAdded += $tag
        }
    }
    
    foreach ($tag in $entry1.focus_tags) {
        if ($entry2.focus_tags -notcontains $tag) {
            $tagsRemoved += $tag
        }
    }
    
    # Create timestamp with format suitable for filenames
    $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    
    # Create report ID
    $cleanName1 = Get-CleanFileName -name $branch1
    $cleanName2 = Get-CleanFileName -name $branch2
    $reportId = "${cleanName1}_vs_${cleanName2}"
    
    # Create metadata
    $metadata = @{
        "id" = $reportId
        "report_file" = $reportPath.Replace("analysis\", "")
        "branch1" = $branch1
        "branch2" = $branch2
        "timestamp" = (Get-Date -Format "yyyy-MM-dd HH:mm:ss")
        "score_diff" = $scoreDiff
        "tags_added" = $tagsAdded
        "tags_removed" = $tagsRemoved
    }
    
    # Add JD information if available
    if ($entry2.PSObject.Properties["primary_jd"]) {
        $metadata["primary_jd"] = $entry2.primary_jd
    }
    
    if ($jdAlignmentDiff -ne $null) {
        $metadata["jd_alignment_diff"] = $jdAlignmentDiff
    }
    
    # Check if this is a significant change
    $metadata["significant_changes"] = Is-SignificantChange -report $metadata
    
    return $metadata
}

# Helper function to get encoding for a branch
function Get-BranchEncoding {
    param($branchName)
    
    $index = Load-Index
    $entry = $index.encodings | Where-Object { $_.branch_name -eq $branchName }
    
    if (-not $entry) {
        Write-Host "Error: No encoding found for branch '$branchName'" -ForegroundColor Red
        return $null
    }
    
    $encodingFile = "analysis\$($entry.encoding_file)"
    
    if (-not (Test-Path $encodingFile)) {
        Write-Host "Error: Encoding file not found: $encodingFile" -ForegroundColor Red
        return $null
    }
    
    return Get-Content $encodingFile | ConvertFrom-Json
}

# Action: List reports
if ($Action -eq "list") {
    $reportsIndex = Load-ReportsIndex
    
    if ($reportsIndex.reports.Count -eq 0) {
        Write-Host "No reports found in the index." -ForegroundColor Yellow
    } else {
        $targetReports = $reportsIndex.reports
        
        # Filter by branch if specified
        if ($Branch) {
            $targetReports = $targetReports | Where-Object { $_.branch1 -eq $Branch -or $_.branch2 -eq $Branch }
            
            if ($targetReports.Count -eq 0) {
                Write-Host "No reports found for branch: $Branch" -ForegroundColor Yellow
                exit 0
            }
            
            Write-Host "Found $($targetReports.Count) reports for branch: $Branch" -ForegroundColor Cyan
        } else {
            Write-Host "Found $($targetReports.Count) reports:" -ForegroundColor Cyan
        }
        
        Write-Host "---------------------------------------------------------------------------------" -ForegroundColor White
        Write-Host "ID                            | BRANCHES                       | DATE       | CHANGE" -ForegroundColor White  
        Write-Host "---------------------------------------------------------------------------------" -ForegroundColor White
        
        $targetReports | Sort-Object -Property timestamp -Descending | ForEach-Object {
            $idPadded = $_.id.PadRight(30)
            $branchesPadded = "$($_.branch1) vs $($_.branch2)".PadRight(30)
            $datePadded = $_.timestamp.Substring(0, 10).PadRight(10)
            
            $changeIndicator = if ($_.significant_changes) { "SIGNIFICANT" } else { "Minor" }
            $changeColor = if ($_.significant_changes) { "Yellow" } else { "White" }
            
            Write-Host "$idPadded | $branchesPadded | $datePadded | $changeIndicator" -ForegroundColor $changeColor
        }
        Write-Host "---------------------------------------------------------------------------------" -ForegroundColor White
        
        # Show significant changes
        if ($reportsIndex.significant_changes.Count -gt 0) {
            Write-Host "`nSignificant Changes:" -ForegroundColor Yellow
            
            $reportsIndex.significant_changes | ForEach-Object {
                $reportId = $_
                $report = $reportsIndex.reports | Where-Object { $_.id -eq $reportId }
                
                if ($report) {
                    $changes = @()
                    
                    if ($report.score_diff) {
                        $scoreChange = if ($report.score_diff -gt 0) { "+$($report.score_diff)%" } else { "$($report.score_diff)%" }
                        $changes += "Score: $scoreChange"
                    }
                    
                    if ($report.jd_alignment_diff) {
                        $alignChange = if ($report.jd_alignment_diff -gt 0) { "+$($report.jd_alignment_diff)%" } else { "$($report.jd_alignment_diff)%" }
                        $changes += "JD Alignment: $alignChange"
                    }
                    
                    if ($report.tags_added -and $report.tags_added.Count -gt 0) {
                        $changes += "Added tags: $($report.tags_added -join ', ')"
                    }
                    
                    if ($report.tags_removed -and $report.tags_removed.Count -gt 0) {
                        $changes += "Removed tags: $($report.tags_removed -join ', ')"
                    }
                    
                    Write-Host "* $($report.branch1) vs $($report.branch2) - $($changes -join '; ')" -ForegroundColor Yellow
                }
            }
        }
    }
}

# Action: Cleanup old reports
if ($Action -eq "cleanup") {
    $reportsIndex = Load-ReportsIndex
    
    if ($reportsIndex.reports.Count -eq 0) {
        Write-Host "No reports found in the index." -ForegroundColor Yellow
        exit 0
    }
    
    $cutoffDate = (Get-Date).AddDays(-$RetentionDays)
    $cutoffString = $cutoffDate.ToString("yyyy-MM-dd")
    
    Write-Host "Cleaning up reports older than $cutoffString..." -ForegroundColor Cyan
    
    $reportsToRemove = @()
    $reportsToKeep = @()
    
    # Find reports to remove
    foreach ($report in $reportsIndex.reports) {
        $reportDate = [DateTime]::ParseExact($report.timestamp.Substring(0, 10), "yyyy-MM-dd", $null)
        
        if ($reportDate -lt $cutoffDate) {
            # Always keep significant changes
            if ($report.significant_changes -and -not $Force) {
                Write-Host "Keeping significant change report: $($report.id)" -ForegroundColor Yellow
                $reportsToKeep += $report
            } else {
                $reportsToRemove += $report
            }
        } else {
            $reportsToKeep += $report
        }
    }
    
    if ($reportsToRemove.Count -eq 0) {
        Write-Host "No reports found older than $cutoffString." -ForegroundColor Green
        exit 0
    }
    
    # Confirm deletion
    if (-not $Force) {
        Write-Host "Found $($reportsToRemove.Count) reports to remove." -ForegroundColor Yellow
        $confirm = Read-Host "Do you want to continue? (Y/N)"
        
        if ($confirm -ne "Y" -and $confirm -ne "y") {
            Write-Host "Operation cancelled." -ForegroundColor Yellow
            exit 0
        }
    }
    
    # Remove reports
    foreach ($report in $reportsToRemove) {
        $reportPath = "analysis\$($report.report_file)"
        
        if (Test-Path $reportPath) {
            Remove-Item -Path $reportPath -Force
            Write-Host "Removed report file: $reportPath" -ForegroundColor Cyan
        } else {
            Write-Host "Report file not found: $reportPath" -ForegroundColor Yellow
        }
    }
    
    # Update index
    $updatedIndex = @{
        "reports" = $reportsToKeep
        "latest_by_branch" = $reportsIndex.latest_by_branch
        "significant_changes" = $reportsIndex.significant_changes | Where-Object {
            $id = $_
            $reportsToKeep | Where-Object { $_.id -eq $id }
        }
        "last_updated" = (Get-Date -Format "yyyy-MM-dd")
    }
    
    # Save updated index
    Save-ReportsIndex -indexData $updatedIndex
    
    Write-Host "Removed $($reportsToRemove.Count) reports." -ForegroundColor Green
}

# Action: Regenerate reports for a branch
if ($Action -eq "regenerate") {
    if (-not $Branch) {
        Write-Host "Error: Branch name is required for regeneration." -ForegroundColor Red
        exit 1
    }
    
    $index = Load-Index
    $entry = $index.encodings | Where-Object { $_.branch_name -eq $Branch }
    
    if (-not $entry) {
        Write-Host "Error: No encoding found for branch '$Branch'" -ForegroundColor Red
        exit 1
    }
    
    Write-Host "Regenerating reports for branch: $Branch" -ForegroundColor Cyan
    
    # Generate comparison with main
    $cleanName = Get-CleanFileName -name $Branch
    $reportPath = "$COMPARISONS_DIR\main_vs_${cleanName}.html"
    
    $generated = Generate-ComparisonReport -branch1 "main" -branch2 $Branch -outputPath $reportPath
    
    if ($generated) {
        $metadata = Extract-ReportMetadata -branch1 "main" -branch2 $Branch -reportPath $reportPath
        
        if ($metadata) {
            Add-ReportToIndex -reportInfo $metadata
        }
    }
    
    # Find previous version of this branch
    # This would require additional logic to determine version sequence
    # For now, we'll skip this step
    
    Write-Host "Reports regenerated for $Branch." -ForegroundColor Green
}

# Action: Generate timeline view for a branch
if ($Action -eq "timeline") {
    if (-not $Branch) {
        Write-Host "Error: Branch name is required for timeline generation." -ForegroundColor Red
        exit 1
    }
    
    $reportsIndex = Load-ReportsIndex
    
    $branchReports = $reportsIndex.reports | Where-Object { $_.branch1 -eq $Branch -or $_.branch2 -eq $Branch }
    
    if ($branchReports.Count -eq 0) {
        Write-Host "No reports found for branch: $Branch" -ForegroundColor Yellow
        exit 0
    }
    
    $cleanName = Get-CleanFileName -name $Branch
    $timelineFile = "$TIMELINES_DIR\${cleanName}_timeline.html"
    $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    
    # For now, we'll use a simplified version by calling the report generator in a special mode
    # This would ideally be enhanced with a custom timeline template
    & .\html-report-generator.ps1 -OutputDir $TIMELINES_DIR -Branches $Branch -TimelineMode -OutputFile "${cleanName}_timeline.html" -Silent
    
    Write-Host "Generated timeline report: $timelineFile" -ForegroundColor Green
}

# Action: Rebuild report index
if ($Action -eq "index") {
    Write-Host "Rebuilding report index..." -ForegroundColor Cyan
    
    # Find all HTML reports
    $reportFiles = Get-ChildItem -Path "analysis\reports" -Filter "*.html" -Recurse | Select-Object -ExpandProperty FullName
    
    if ($reportFiles.Count -eq 0) {
        Write-Host "No report files found." -ForegroundColor Yellow
        exit 0
    }
    
    Write-Host "Found $($reportFiles.Count) report files." -ForegroundColor Cyan
    
    # Initialize new index
    $newIndex = @{
        "reports" = @()
        "latest_by_branch" = @{}
        "significant_changes" = @()
        "last_updated" = (Get-Date -Format "yyyy-MM-dd")
    }
    
    # This is a simplified implementation - full implementation would require
    # parsing the HTML files to extract metadata, or using a more sophisticated approach
    # For now, we'll rely on filename patterns
    
    foreach ($file in $reportFiles) {
        $relativePath = $file.Replace((Resolve-Path .).Path + "\", "")
        $fileName = Split-Path $file -Leaf
        
        # Skip timeline reports for now
        if ($fileName -like "*timeline*") {
            continue
        }
        
        # Parse comparison report filename (expected format: branch1_vs_branch2.html)
        if ($fileName -match "(.+)_vs_(.+)\.html") {
            $branch1 = $matches[1] -replace "_", "/"
            $branch2 = $matches[2] -replace "_", "/"
            
            # Skip if either branch doesn't exist in the main index
            $index = Load-Index
            $entry1 = $index.encodings | Where-Object { $_.branch_name -eq $branch1 }
            $entry2 = $index.encodings | Where-Object { $_.branch_name -eq $branch2 }
            
            if (-not $entry1 -or -not $entry2) {
                continue
            }
            
            # Create basic metadata
            $reportId = "$($matches[1])_vs_$($matches[2])"
            
            $metadata = @{
                "id" = $reportId
                "report_file" = $relativePath
                "branch1" = $branch1
                "branch2" = $branch2
                "timestamp" = (Get-Item $file).CreationTime.ToString("yyyy-MM-dd HH:mm:ss")
            }
            
            # Extract more detailed metadata if possible
            $detailedMetadata = Extract-ReportMetadata -branch1 $branch1 -branch2 $branch2 -reportPath $file
            
            if ($detailedMetadata) {
                $metadata = $detailedMetadata
            }
            
            # Add to index
            $newIndex.reports += $metadata
            
            # Update latest_by_branch
            $newIndex.latest_by_branch[$branch1] = $reportId
            $newIndex.latest_by_branch[$branch2] = $reportId
            
            # Check if significant change
            if ($metadata.significant_changes) {
                $newIndex.significant_changes += $reportId
            }
        }
    }
    
    # Save new index
    Save-ReportsIndex -indexData $newIndex
    
    Write-Host "Report index rebuilt with $($newIndex.reports.Count) reports." -ForegroundColor Green
}