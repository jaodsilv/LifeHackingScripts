# Script to manage encoding files
# Save as manage_encodings.ps1 and run from the repository root
param (
    [Parameter(Mandatory=$true)]
    [ValidateSet("save", "list", "find", "compare", "jd-match")]
    [string]$Action,
    
    [Parameter(Mandatory=$false)]
    [string]$BranchName,
    
    [Parameter(Mandatory=$false)]
    [string]$Tags,
    
    [Parameter(Mandatory=$false)]
    [string]$Branch1,
    
    [Parameter(Mandatory=$false)]
    [string]$Branch2,
    
    [Parameter(Mandatory=$false)]
    [string]$JdId,
    
    [Parameter(Mandatory=$false)]
    [switch]$SetPrimary,
    
    [Parameter(Mandatory=$false)]
    [switch]$AutoReport,
    
    [Parameter(Mandatory=$false)]
    [switch]$ViewReport,
    
    [Parameter(Mandatory=$false)]
    [switch]$Force
)

# Configuration
$ENCODINGS_DIR = "analysis\encodings"
$INDEX_FILE = "analysis\index.json"
$VISUALIZATION_FILE = "analysis\visualizations\resume_visualization.html"
$JD_DIR = "analysis\job_descriptions"
$REPORTS_DIR = "analysis\reports\comparisons"
$REPORTS_INDEX_FILE = "analysis\reports\reports_index.json"

# Ensure directories exist
New-Item -ItemType Directory -Path $ENCODINGS_DIR -Force | Out-Null
New-Item -ItemType Directory -Path "analysis\visualizations" -Force | Out-Null
New-Item -ItemType Directory -Path $REPORTS_DIR -Force | Out-Null

# Helper function to load index
function Load-Index {
    if (Test-Path $INDEX_FILE) {
        return Get-Content $INDEX_FILE | ConvertFrom-Json
    } else {
        return @{
            "encodings" = @()
            "job_descriptions" = @()
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

# Helper function to clean branch name for filename
function Get-CleanFileName {
    param($branchName)
    return $branchName -replace "[\/\\]", "_" -replace "[^a-zA-Z0-9_]", ""
}

# Helper function to analyze JD alignment
function Analyze-JdAlignment {
    param($encodingData, $jdId)
    
    # Check if JD exists
    $jdFile = Join-Path -Path $JD_DIR -ChildPath "$jdId.json"
    if (-not (Test-Path $jdFile)) {
        Write-Host "Warning: Job description $jdId not found. Skipping alignment analysis." -ForegroundColor Yellow
        return $null
    }
    
    # Load JD
    $jdData = Get-Content $jdFile | ConvertFrom-Json
    
    $jdSkills = $jdData.key_skills
    $resumeTags = $encodingData.focus_tags
    $resumeKeywords = if ($encodingData.keyword_emphasis) {
        $encodingData.keyword_emphasis.PSObject.Properties.Name
    } else {
        @()
    }
    
    # Matched skills (in both JD and resume)
    $matchedSkills = @()
    # Missing skills (in JD but not in resume)
    $missingSkills = @()
    
    foreach ($skill in $jdSkills) {
        if ($resumeTags -contains $skill -or $resumeKeywords -contains $skill) {
            $matchedSkills += $skill
        } else {
            $missingSkills += $skill
        }
    }
    
    # Calculate alignment score
    $alignmentScore = 0
    if ($jdSkills.Count -gt 0) {
        $alignmentScore = [Math]::Round(($matchedSkills.Count / $jdSkills.Count) * 100)
    }
    
    return @{
        "alignment_score" = $alignmentScore
        "matched_skills" = $matchedSkills
        "missing_skills" = $missingSkills
        "jd_id" = $jdData.jd_id
    }
}

# Helper function to generate reports for a branch
function Generate-Reports {
    param($branchName)
    
    $cleanName = Get-CleanFileName -branchName $branchName
    $reportPath = "$REPORTS_DIR\main_vs_${cleanName}.html"
    
    # Call report generator script
    & .\html-report-generator.ps1 -OutputDir $REPORTS_DIR -Branches $branchName -CompareToMain -Silent
    
    # Check if the report was generated
    if (Test-Path $reportPath) {
        Write-Host "Generated comparison report: $reportPath" -ForegroundColor Green
        
        # Check for significant changes
        $reportsIndex = Load-ReportsIndex
        $reportId = "main_vs_${cleanName}"
        $report = $reportsIndex.reports | Where-Object { $_.id -eq $reportId }
        
        if ($report -and $report.significant_changes) {
            Write-Host "SIGNIFICANT CHANGES DETECTED!" -ForegroundColor Yellow
            
            # Display changes
            $changes = @()
                    
            if ($report.score_diff) {
                $scoreChange = if ($report.score_diff -gt 0) { "+$($report.score_diff)%" } else { "$($report.score_diff)%" }
                $changes += "Score change: $scoreChange"
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
            
            foreach ($change in $changes) {
                Write-Host "* $change" -ForegroundColor Yellow
            }
        }
        
        return $reportPath
    } else {
        Write-Host "Failed to generate comparison report." -ForegroundColor Red
        return $null
    }
}

# Helper function to open a report in the default browser
function Open-Report {
    param($reportPath)
    
    if (Test-Path $reportPath) {
        Start-Process $reportPath
    } else {
        Write-Host "Report file not found: $reportPath" -ForegroundColor Red
    }
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
    
    # Load and parse the encoding data
    $encodingData = Get-Content "analysis\ResumeEncoding.json" | ConvertFrom-Json
    
    # Add branch name to the encoding
    $encodingData | Add-Member -NotePropertyName "branch_name" -NotePropertyValue $BranchName -Force
    
    # Add timestamp
    $encodingData | Add-Member -NotePropertyName "timestamp" -NotePropertyValue (Get-Date -Format "yyyy-MM-dd HH:mm:ss") -Force
    
    # Initialize job_descriptions array if it doesn't exist
    if (-not $encodingData.PSObject.Properties["job_descriptions"]) {
        $encodingData | Add-Member -NotePropertyName "job_descriptions" -NotePropertyValue @() -Force
    }
    
    # If JdId is provided, analyze alignment and add to encoding
    if ($JdId) {
        $alignment = Analyze-JdAlignment -encodingData $encodingData -jdId $JdId
        
        if ($alignment) {
            # Check if this JD is already associated
            $existingJd = $encodingData.job_descriptions | Where-Object { $_.jd_id -eq $JdId }
            
            if ($existingJd) {
                # Update existing entry
                $existingJd.alignment_score = $alignment.alignment_score
                $existingJd.matched_skills = $alignment.matched_skills
                $existingJd.missing_skills = $alignment.missing_skills
                
                # Set as primary if requested
                if ($SetPrimary) {
                    # Reset all other JDs to not primary
                    $encodingData.job_descriptions | ForEach-Object {
                        $_.is_primary = $false
                    }
                    $existingJd.is_primary = $true
                }
            } else {
                # Create new JD entry
                $newJdEntry = @{
                    "jd_id" = $JdId
                    "alignment_score" = $alignment.alignment_score
                    "matched_skills" = $alignment.matched_skills
                    "missing_skills" = $alignment.missing_skills
                    "is_primary" = $SetPrimary
                }
                
                # If setting as primary, reset other JDs
                if ($SetPrimary) {
                    $encodingData.job_descriptions | ForEach-Object {
                        $_.is_primary = $false
                    }
                }
                
                # Add to job_descriptions array
                $encodingData.job_descriptions += $newJdEntry
            }
            
            Write-Host "Added Job Description alignment: $JdId (Score: $($alignment.alignment_score)%)" -ForegroundColor Cyan
        }
    }
    
    # Save encoding to file
    $encodingData | ConvertTo-Json -Depth 6 | Set-Content $encodingFile
    Write-Host "Saved encoding to $encodingFile" -ForegroundColor Green
    
    # Update the index
    $index = Load-Index
    
    # Check if this branch already has an entry
    $existingEntry = $index.encodings | Where-Object { $_.branch_name -eq $BranchName }
    
    # Get primary JD info if available
    $primaryJdId = $null
    $jdAlignmentScore = $null
    
    $primaryJd = $encodingData.job_descriptions | Where-Object { $_.is_primary -eq $true }
    if ($primaryJd) {
        $primaryJdId = $primaryJd.jd_id
        $jdAlignmentScore = $primaryJd.alignment_score
    }
    
    if ($existingEntry) {
        # Update existing entry
        $existingEntry.encoding_file = $relativeEncodingPath
        $existingEntry.focus_tags = $encodingData.focus_tags
        $existingEntry.weighted_score = $encodingData.composite_scores.weighted_average
        $existingEntry.last_analyzed = (Get-Date -Format "yyyy-MM-dd")
        
        # Update JD info if available
        if ($primaryJdId) {
            $existingEntry | Add-Member -NotePropertyName "primary_jd" -NotePropertyValue $primaryJdId -Force
            $existingEntry | Add-Member -NotePropertyName "jd_alignment" -NotePropertyValue $jdAlignmentScore -Force
        }
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
        
        # Add JD info if available
        if ($primaryJdId) {
            $newEntry["primary_jd"] = $primaryJdId
            $newEntry["jd_alignment"] = $jdAlignmentScore
        }
        
        $index.encodings += $newEntry
    }
    
    # Update JD index entries if we have JDs
    if ($encodingData.job_descriptions -and $encodingData.job_descriptions.Count -gt 0) {
        foreach ($jdRef in $encodingData.job_descriptions) {
            $jdEntry = $index.job_descriptions | Where-Object { $_.jd_id -eq $jdRef.jd_id }
            
            if ($jdEntry) {
                # Initialize used_by array if it doesn't exist
                if (-not $jdEntry.PSObject.Properties["used_by"]) {
                    $jdEntry | Add-Member -NotePropertyName "used_by" -NotePropertyValue @() -Force
                }
                
                # Add branch to used_by if not already there
                if ($jdEntry.used_by -notcontains $BranchName) {
                    $jdEntry.used_by += $BranchName
                }
            }
        }
    }
    
    # Save updated index
    Save-Index -indexData $index
    Write-Host "Updated index file with latest encoding information" -ForegroundColor Green
    
    # Generate report if requested
    $reportPath = $null
    if ($AutoReport -or $ViewReport -or ($Force -and (-not $Silent))) {
        # Generate report comparing with main branch
        $reportPath = Generate-Reports -branchName $BranchName
    } else {
        # Ask if user wants to generate a report
        $generateReport = Read-Host "Do you want to generate an HTML report comparing this to main branch? (Y/N)"
        if ($generateReport -eq "Y" -or $generateReport -eq "y") {
            $reportPath = Generate-Reports -branchName $BranchName
        }
    }
    
    # Open report if requested
    if ($ViewReport -and $reportPath) {
        Open-Report -reportPath $reportPath
    } elseif ($reportPath) {
        $viewReportNow = Read-Host "Do you want to view the report now? (Y/N)"
        if ($viewReportNow -eq "Y" -or $viewReportNow -eq "y") {
            Open-Report -reportPath $reportPath
        }
    }
}

# Action: List all encodings
if ($Action -eq "list") {
    $index = Load-Index
    
    if ($index.encodings.Count -eq 0) {
        Write-Host "No encodings found in the index." -ForegroundColor Yellow
    } else {
        Write-Host "Found $($index.encodings.Count) encodings:" -ForegroundColor Cyan
        Write-Host "---------------------------------------------------------------------------------" -ForegroundColor White
        Write-Host "BRANCH NAME                | SCORE | JD ALIGN | PRIMARY JD                 | FOCUS TAGS" -ForegroundColor White  
        Write-Host "---------------------------------------------------------------------------------" -ForegroundColor White
        
        $index.encodings | Sort-Object -Property weighted_score -Descending | ForEach-Object {
            $tags = $_.focus_tags -join ", "
            $branchPadded = $_.branch_name.PadRight(25)
            $scorePadded = $_.weighted_score.ToString().PadRight(5)
            
            $jdAlignPadded = if ($_.jd_alignment) { $_.jd_alignment.ToString().PadRight(8) } else { "N/A".PadRight(8) }
            $primaryJdPadded = if ($_.primary_jd) { $_.primary_jd.PadRight(27) } else { "None".PadRight(27) }
            
            Write-Host "$branchPadded | $scorePadded | $jdAlignPadded | $primaryJdPadded | $tags" -ForegroundColor White
        }
        Write-Host "---------------------------------------------------------------------------------" -ForegroundColor White
        
        # Check if reports exist
        $reportsIndex = Load-ReportsIndex
        if ($reportsIndex.reports.Count -gt 0) {
            Write-Host "`nRecent significant changes:" -ForegroundColor Yellow
            
            # Get the last 3 significant changes
            $reportsIndex.significant_changes | Select-Object -Last 3 | ForEach-Object {
                $reportId = $_
                $report = $reportsIndex.reports | Where-Object { $_.id -eq $reportId }
                
                if ($report) {
                    $branch1Display = $report.branch1.Replace("_", "/")
                    $branch2Display = $report.branch2.Replace("_", "/")
                    
                    $changeInfo = if ($report.score_diff) {
                        $scoreChange = if ($report.score_diff -gt 0) { "+$($report.score_diff)%" } else { "$($report.score_diff)%" }
                        "Score: $scoreChange"
                    } else {
                        ""
                    }
                    
                    Write-Host "* $branch1Display vs $branch2Display - $changeInfo" -ForegroundColor Yellow
                }
            }
            
            # Offer to view reports
            Write-Host "`nUse 'report-manager.ps1 -Action list' to see all reports." -ForegroundColor Cyan
        }
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
        Write-Host "---------------------------------------------------------------------------------" -ForegroundColor White
        Write-Host "BRANCH NAME                | SCORE | JD ALIGN | PRIMARY JD                 | MATCHING TAGS" -ForegroundColor White  
        Write-Host "---------------------------------------------------------------------------------" -ForegroundColor White
        
        $matchingEncodings | ForEach-Object {
            $tags = $_.focus_tags -join ", "
            $branchPadded = $_.branch_name.PadRight(25)
            $scorePadded = $_.weighted_score.ToString().PadRight(5)
            
            $jdAlignPadded = if ($_.jd_alignment) { $_.jd_alignment.ToString().PadRight(8) } else { "N/A".PadRight(8) }
            $primaryJdPadded = if ($_.primary_jd) { $_.primary_jd.PadRight(27) } else { "None".PadRight(27) }
            
            Write-Host "$branchPadded | $scorePadded | $jdAlignPadded | $primaryJdPadded | $tags" -ForegroundColor White
        }
        Write-Host "---------------------------------------------------------------------------------" -ForegroundColor White
        
        Write-Host "`nTop 3 matches:" -ForegroundColor Green
        $matchingEncodings | Select-Object -First 3 | ForEach-Object {
            $tags = $_.focus_tags -join ", "
            $jdInfo = if ($_.primary_jd) { ", Aligned to: $($_.primary_jd) ($($_.jd_alignment)%)" } else { "" }
            Write-Host "* $($_.branch_name) (Score: $($_.weighted_score)$jdInfo)" -ForegroundColor Green
        }
        
        # Check if there are recent reports
        $reportsIndex = Load-ReportsIndex
        $topMatch = $matchingEncodings | Select-Object -First 1
        
        if ($topMatch) {
            $cleanName = Get-CleanFileName -branchName $topMatch.branch_name
            $reportId = "main_vs_$cleanName"
            $report = $reportsIndex.reports | Where-Object { $_.id -eq $reportId }
            
            if ($report) {
                $reportPath = "analysis\$($report.report_file)"
                
                Write-Host "`nA comparison report exists for the top match." -ForegroundColor Cyan
                $viewReport = Read-Host "Do you want to view it? (Y/N)"
                
                if ($viewReport -eq "Y" -or $viewReport -eq "y") {
                    Open-Report -reportPath $reportPath
                }
            } else {
                Write-Host "`nNo existing report found for the top match." -ForegroundColor Yellow
                $generateReport = Read-Host "Do you want to generate a report? (Y/N)"
                
                if ($generateReport -eq "Y" -or $generateReport -eq "y") {
                    $reportPath = Generate-Reports -branchName $topMatch.branch_name
                    
                    if ($reportPath) {
                        $viewReport = Read-Host "Do you want to view the report now? (Y/N)"
                        if ($viewReport -eq "Y" -or $viewReport -eq "y") {
                            Open-Report -reportPath $reportPath
                        }
                    }
                }
            }
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
    
    # Compare JD info if available
    if (($data1.job_descriptions -and $data1.job_descriptions.Count -gt 0) -or 
        ($data2.job_descriptions -and $data2.job_descriptions.Count -gt 0)) {
        
        Write-Host "JOB DESCRIPTION ALIGNMENT:" -ForegroundColor White
        
        # Get primary JDs
        $primary1 = $data1.job_descriptions | Where-Object { $_.is_primary -eq $true }
        $primary2 = $data2.job_descriptions | Where-Object { $_.is_primary -eq $true }
        
        $primary1Id = if ($primary1) { $primary1.jd_id } else { "None" }
        $primary2Id = if ($primary2) { $primary2.jd_id } else { "None" }
        
        $primary1Score = if ($primary1) { "$($primary1.alignment_score)%" } else { "N/A" }
        $primary2Score = if ($primary2) { "$($primary2.alignment_score)%" } else { "N/A" }
        
        Write-Host "$Branch1: Primary JD = $primary1Id, Alignment = $primary1Score" -ForegroundColor White
        Write-Host "$Branch2: Primary JD = $primary2Id, Alignment = $primary2Score" -ForegroundColor White
        Write-Host ""
    }
    
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
    
    # Check for existing report
    $reportsIndex = Load-ReportsIndex
    $cleanName1 = Get-CleanFileName -branchName $Branch1
    $cleanName2 = Get-CleanFileName -branchName $Branch2
    $reportId = "${cleanName1}_vs_${cleanName2}"
    $report = $reportsIndex.reports | Where-Object { $_.id -eq $reportId }
    
    if ($report) {
        $reportPath = "analysis\$($report.report_file)"
        
        Write-Host "`nA comparison report already exists." -ForegroundColor Cyan
        $viewReport = Read-Host "Do you want to view it? (Y/N)"
        
        if ($viewReport -eq "Y" -or $viewReport -eq "y") {
            Open-Report -reportPath $reportPath
        }
    } else {
        # Generate a new report
        $generateReport = Read-Host "Do you want to generate an HTML comparison report? (Y/N)"
        if ($generateReport -eq "Y" -or $generateReport -eq "y") {
            $reportDir = "analysis\reports\comparisons"
            New-Item -ItemType Directory -Path $reportDir -Force | Out-Null
            
            $reportPath = "$reportDir\${cleanName1}_vs_${cleanName2}.html"
            
            # Call report generator script
            & .\html-report-generator.ps1 -OutputDir $reportDir -Branches "$Branch1,$Branch2" -OutputFile "${cleanName1}_vs_${cleanName2}.html"
            
            Write-Host "Report generated: $reportPath" -ForegroundColor Green
            
            $viewReport = Read-Host "Do you want to view the report now? (Y/N)"
            if ($viewReport -eq "Y" -or $viewReport -eq "y") {
                Open-Report -reportPath $reportPath
            }
        }
    }
}

# Action: Find best resume for a JD
if ($Action -eq "jd-match" -and $JdId) {
    # Call the best-match action in manage_job_descriptions.ps1
    & .\manage_job_descriptions.ps1 -Action best-match -JdId $JdId
    
    # Ask if user wants to see reports for top matches
    $index = Load-Index
    
    # Check if JD exists
    $jdFile = Join-Path -Path $JD_DIR -ChildPath "$JdId.json"
    if (-not (Test-Path $jdFile)) {
        Write-Host "Error: Job description $JdId not found!" -ForegroundColor Red
        exit 1
    }
    
    # Load JD data
    $jdData = Get-Content $jdFile | ConvertFrom-Json
    
    # Get branches used by this JD
    $jdEntry = $index.job_descriptions | Where-Object { $_.jd_id -eq $JdId }
    
    if ($jdEntry -and $jdEntry.used_by -and $jdEntry.used_by.Count -gt 0) {
        Write-Host "`nReports are available for resumes aligned to this job description." -ForegroundColor Cyan
        $viewReports = Read-Host "Do you want to see the comparison reports? (Y/N)"
        
        if ($viewReports -eq "Y" -or $viewReports -eq "y") {
            # Get top match
            $topBranch = $jdEntry.used_by | Select-Object -First 1
            $cleanName = Get-CleanFileName -branchName $topBranch
            $reportPath = "$REPORTS_DIR\main_vs_${cleanName}.html"
            
            # Check if report exists, generate if not
            if (-not (Test-Path $reportPath)) {
                Write-Host "Generating report for $topBranch..." -ForegroundColor Cyan
                & .\html-report-generator.ps1 -OutputDir $REPORTS_DIR -Branches $topBranch -CompareToMain -Silent
            }
            
            if (Test-Path $reportPath) {
                Open-Report -reportPath $reportPath
            } else {
                Write-Host "Failed to generate or find report for $topBranch" -ForegroundColor Red
            }
        }
    }
}