# Script to manage job descriptions for resume tailoring
# Save as manage_job_descriptions.ps1 and run from the repository root
param (
    [Parameter(Mandatory=$true)]
    [ValidateSet("add", "list", "show", "analyze", "associate", "best-match")]
    [string]$Action,
    
    [Parameter(Mandatory=$false)]
    [string]$JdId,
    
    [Parameter(Mandatory=$false)]
    [string]$Company,
    
    [Parameter(Mandatory=$false)]
    [string]$Position,
    
    [Parameter(Mandatory=$false)]
    [string]$JdFile,
    
    [Parameter(Mandatory=$false)]
    [string]$Url,
    
    [Parameter(Mandatory=$false)]
    [string]$BranchName,
    
    [Parameter(Mandatory=$false)]
    [switch]$SetPrimary,
    
    [Parameter(Mandatory=$false)]
    [string[]]$KeySkills,
    
    [Parameter(Mandatory=$false)]
    [switch]$Force
)

# Configuration
$JD_DIR = "analysis\job_descriptions"
$INDEX_FILE = "analysis\index.json"
$ENCODINGS_DIR = "analysis\encodings"

# Ensure directories exist
New-Item -ItemType Directory -Path $JD_DIR -Force | Out-Null

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

# Helper function to generate JD ID
function Generate-JdId {
    param($company, $position, $date)
    
    # Clean company and position names for ID
    $companyClean = $company -replace "[^a-zA-Z0-9]", "" -replace "\s+", ""
    $positionClean = $position -replace "[^a-zA-Z0-9]", "" -replace "\s+", ""
    
    # Format: company_position_date
    return "$($companyClean.ToLower())_$($positionClean.ToLower())_$date"
}

# Helper function to extract skills from JD text
function Extract-Skills {
    param($jdText)
    
    # This is a simple implementation - could be enhanced with NLP
    $commonSkills = @(
        "python", "java", "javascript", "c#", "go", "golang", "rust", "c++",
        "azure", "aws", "gcp", "cloud", "kubernetes", "docker", "terraform",
        "data-engineering", "machine-learning", "ai", "data-science",
        "distributed-systems", "microservices", "rest", "graphql",
        "react", "angular", "vue", "frontend", "backend", "full-stack",
        "sql", "nosql", "mongodb", "postgresql", "mysql", "oracle",
        "kafka", "rabbitmq", "redis", "spark", "hadoop", "airflow",
        "ci/cd", "github", "gitlab", "jenkins", "agile", "scrum"
    )
    
    $detectedSkills = @()
    
    foreach ($skill in $commonSkills) {
        if ($jdText -match $skill) {
            $detectedSkills += $skill
        }
    }
    
    return $detectedSkills
}

# Helper function to analyze JD-Resume alignment
function Analyze-Alignment {
    param($jdData, $resumeData)
    
    $jdSkills = $jdData.key_skills
    $resumeTags = $resumeData.focus_tags
    $resumeKeywords = $resumeData.keyword_emphasis.PSObject.Properties.Name
    
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

# Helper function to load a JD
function Load-JobDescription {
    param($jdId)
    
    $jdFile = Join-Path -Path $JD_DIR -ChildPath "$jdId.json"
    
    if (-not (Test-Path $jdFile)) {
        Write-Host "Error: Job description not found: $jdId" -ForegroundColor Red
        return $null
    }
    
    return Get-Content $jdFile | ConvertFrom-Json
}

# Helper function to load a resume encoding
function Load-ResumeEncoding {
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

# Action: Add a new job description
if ($Action -eq "add") {
    if (-not $Company) {
        Write-Host "Error: Company name is required for adding a job description." -ForegroundColor Red
        exit 1
    }
    
    if (-not $Position) {
        Write-Host "Error: Position title is required for adding a job description." -ForegroundColor Red
        exit 1
    }
    
    # Generate date if not provided
    $currentDate = Get-Date -Format "yyyyMMdd"
    
    # Generate JD ID
    $newJdId = Generate-JdId -company $Company -position $Position -date $currentDate
    
    # Check if JD already exists
    $jdFile = Join-Path -Path $JD_DIR -ChildPath "$newJdId.json"
    if (Test-Path $jdFile) {
        if (-not $Force) {
            Write-Host "Error: Job description with ID $newJdId already exists." -ForegroundColor Red
            Write-Host "Use -Force to overwrite." -ForegroundColor Yellow
            exit 1
        }
    }
    
    # Create JD data
    $jdData = @{
        "jd_id" = $newJdId
        "company" = $Company
        "position" = $Position
        "date_added" = $currentDate
        "url" = $Url
        "key_skills" = @()
        "key_requirements" = @()
        "full_description" = ""
        "status" = "active"
    }
    
    # Process JD file if provided
    if ($JdFile -and (Test-Path $JdFile)) {
        $jdContent = Get-Content -Path $JdFile -Raw
        $jdData.full_description = $jdContent
        
        # Extract skills from JD content
        $extractedSkills = Extract-Skills -jdText $jdContent
        $jdData.key_skills = $extractedSkills
        
        Write-Host "Extracted skills from JD: $($extractedSkills -join ', ')" -ForegroundColor Cyan
    }
    
    # Add manual skills if provided
    if ($KeySkills) {
        $jdData.key_skills = $KeySkills
    }
    
    # Save JD to file
    $jdData | ConvertTo-Json -Depth 4 | Set-Content $jdFile
    
    # Update index file
    $index = Load-Index
    
    # Check if JD already exists in index
    $existingJd = $index.job_descriptions | Where-Object { $_.jd_id -eq $newJdId }
    
    if ($existingJd) {
        # Update existing entry
        $existingJd.company = $Company
        $existingJd.position = $Position
        $existingJd.date_added = $currentDate
    } else {
        # Add new entry
        $newEntry = @{
            "jd_id" = $newJdId
            "company" = $Company
            "position" = $Position
            "date_added" = $currentDate
            "used_by" = @()
        }
        $index.job_descriptions += $newEntry
    }
    
    # Save updated index
    Save-Index -indexData $index
    
    Write-Host "Job description added with ID: $newJdId" -ForegroundColor Green
    Write-Host "File saved to: $jdFile" -ForegroundColor Green
}

# Action: List all job descriptions
if ($Action -eq "list") {
    $index = Load-Index
    
    if ($index.job_descriptions.Count -eq 0) {
        Write-Host "No job descriptions found in the index." -ForegroundColor Yellow
    } else {
        Write-Host "Found $($index.job_descriptions.Count) job descriptions:" -ForegroundColor Cyan
        Write-Host "-----------------------------------------------------------" -ForegroundColor White
        Write-Host "ID                            | COMPANY               | POSITION                | USED BY" -ForegroundColor White  
        Write-Host "-----------------------------------------------------------" -ForegroundColor White
        
        $index.job_descriptions | ForEach-Object {
            $idPadded = $_.jd_id.PadRight(30)
            $companyPadded = $_.company.PadRight(22)
            $positionPadded = $_.position.PadRight(24)
            $usedCount = if ($_.used_by) { $_.used_by.Count } else { 0 }
            Write-Host "$idPadded | $companyPadded | $positionPadded | $usedCount resume(s)" -ForegroundColor White
        }
        Write-Host "-----------------------------------------------------------" -ForegroundColor White
    }
}

# Action: Show details for a specific JD
if ($Action -eq "show") {
    if (-not $JdId) {
        Write-Host "Error: JD ID is required for showing job description details." -ForegroundColor Red
        exit 1
    }
    
    $jdData = Load-JobDescription -jdId $JdId
    
    if ($jdData) {
        Write-Host "Job Description: $JdId" -ForegroundColor Cyan
        Write-Host "-----------------------------------------------------------" -ForegroundColor White
        Write-Host "Company:    $($jdData.company)"
        Write-Host "Position:   $($jdData.position)"
        Write-Host "Added:      $($jdData.date_added)"
        if ($jdData.url) {
            Write-Host "URL:        $($jdData.url)"
        }
        Write-Host ""
        
        Write-Host "Key Skills:" -ForegroundColor Cyan
        if ($jdData.key_skills -and $jdData.key_skills.Count -gt 0) {
            $jdData.key_skills | ForEach-Object {
                Write-Host "- $_"
            }
        } else {
            Write-Host "No key skills defined."
        }
        
        # Find which resumes use this JD
        $index = Load-Index
        $usedBy = $index.job_descriptions | Where-Object { $_.jd_id -eq $JdId } | Select-Object -ExpandProperty used_by
        
        if ($usedBy -and $usedBy.Count -gt 0) {
            Write-Host ""
            Write-Host "Used by Resume Branches:" -ForegroundColor Cyan
            $usedBy | ForEach-Object {
                # Find alignment score if available
                $encoding = Load-ResumeEncoding -branchName $_
                $alignmentScore = "N/A"
                
                if ($encoding -and $encoding.job_descriptions) {
                    $jdRef = $encoding.job_descriptions | Where-Object { $_.jd_id -eq $JdId }
                    if ($jdRef) {
                        $alignmentScore = "$($jdRef.alignment_score)%"
                    }
                }
                
                $isPrimary = if ($encoding -and $encoding.job_descriptions) {
                    $primaryJd = $encoding.job_descriptions | Where-Object { $_.is_primary -eq $true -and $_.jd_id -eq $JdId }
                    if ($primaryJd) { "(Primary)" } else { "" }
                } else { "" }
                
                Write-Host "- $_ $isPrimary - Alignment: $alignmentScore"
            }
        } else {
            Write-Host ""
            Write-Host "Not used by any resume branches."
        }
        
        # Show snippet of full description
        if ($jdData.full_description) {
            Write-Host ""
            Write-Host "Description Preview:" -ForegroundColor Cyan
            
            # Get first 200 characters
            $preview = if ($jdData.full_description.Length -gt 200) {
                $jdData.full_description.Substring(0, 200) + "..."
            } else {
                $jdData.full_description
            }
            
            Write-Host $preview
            Write-Host "(Full description available in $JD_DIR\$JdId.json)"
        }
    }
}

# Action: Analyze alignment between a JD and resume
if ($Action -eq "analyze") {
    if (-not $JdId) {
        Write-Host "Error: JD ID is required for analysis." -ForegroundColor Red
        exit 1
    }
    
    if (-not $BranchName) {
        Write-Host "Error: Branch name is required for analysis." -ForegroundColor Red
        exit 1
    }
    
    $jdData = Load-JobDescription -jdId $JdId
    $resumeData = Load-ResumeEncoding -branchName $BranchName
    
    if ($jdData -and $resumeData) {
        $alignment = Analyze-Alignment -jdData $jdData -resumeData $resumeData
        
        Write-Host "Alignment Analysis:" -ForegroundColor Cyan
        Write-Host "-----------------------------------------------------------" -ForegroundColor White
        Write-Host "Resume:     $BranchName"
        Write-Host "JD:         $($jdData.company) - $($jdData.position)"
        Write-Host "Alignment:  $($alignment.alignment_score)%"
        Write-Host ""
        
        Write-Host "Matched Skills:" -ForegroundColor Green
        if ($alignment.matched_skills -and $alignment.matched_skills.Count -gt 0) {
            $alignment.matched_skills | ForEach-Object {
                Write-Host "✓ $_"
            }
        } else {
            Write-Host "No skills matched."
        }
        
        Write-Host ""
        Write-Host "Missing Skills:" -ForegroundColor Yellow
        if ($alignment.missing_skills -and $alignment.missing_skills.Count -gt 0) {
            $alignment.missing_skills | ForEach-Object {
                Write-Host "✗ $_"
            }
        } else {
            Write-Host "No missing skills."
        }
        
        # Ask if user wants to save this analysis
        if (-not $Force) {
            $saveAnalysis = Read-Host "Do you want to save this analysis to the resume encoding? (Y/N)"
            if ($saveAnalysis -ne "Y" -and $saveAnalysis -ne "y") {
                Write-Host "Analysis not saved." -ForegroundColor Yellow
                exit 0
            }
        }
        
        # Save analysis to resume encoding
        $encodingPath = "analysis\$($resumeData.encoding_file)"
        
        # Initialize job_descriptions array if it doesn't exist
        if (-not $resumeData.job_descriptions) {
            $resumeData | Add-Member -NotePropertyName "job_descriptions" -NotePropertyValue @()
        }
        
        # Check if this JD is already associated
        $existingJd = $resumeData.job_descriptions | Where-Object { $_.jd_id -eq $JdId }
        
        if ($existingJd) {
            # Update existing entry
            $existingJd.alignment_score = $alignment.alignment_score
            $existingJd.matched_skills = $alignment.matched_skills
            $existingJd.missing_skills = $alignment.missing_skills
            
            # Set as primary if requested
            if ($SetPrimary) {
                # Reset all other JDs to not primary
                $resumeData.job_descriptions | ForEach-Object {
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
                $resumeData.job_descriptions | ForEach-Object {
                    $_.is_primary = $false
                }
            }
            
            # Add to job_descriptions array
            $resumeData.job_descriptions += $newJdEntry
        }
        
        # Save updated encoding
        $resumeData | ConvertTo-Json -Depth 6 | Set-Content $encodingPath
        
        # Update index file to record this association
        $index = Load-Index
        $jdEntry = $index.job_descriptions | Where-Object { $_.jd_id -eq $JdId }
        
        if ($jdEntry) {
            # Initialize used_by array if it doesn't exist
            if (-not $jdEntry.used_by) {
                $jdEntry | Add-Member -NotePropertyName "used_by" -NotePropertyValue @()
            }
            
            # Add branch to used_by if not already there
            if ($jdEntry.used_by -notcontains $BranchName) {
                $jdEntry.used_by += $BranchName
            }
            
            # Update resume entry in index with JD info
            $resumeEntry = $index.encodings | Where-Object { $_.branch_name -eq $BranchName }
            if ($resumeEntry) {
                if ($SetPrimary) {
                    $resumeEntry | Add-Member -NotePropertyName "primary_jd" -NotePropertyValue $JdId -Force
                    $resumeEntry | Add-Member -NotePropertyName "jd_alignment" -NotePropertyValue $alignment.alignment_score -Force
                }
            }
            
            # Save updated index
            Save-Index -indexData $index
        }
        
        Write-Host "Analysis saved to resume encoding." -ForegroundColor Green
    }
}

# Action: Associate a JD with a resume branch
if ($Action -eq "associate") {
    if (-not $JdId) {
        Write-Host "Error: JD ID is required for association." -ForegroundColor Red
        exit 1
    }
    
    if (-not $BranchName) {
        Write-Host "Error: Branch name is required for association." -ForegroundColor Red
        exit 1
    }
    
    # This is essentially the same as analyze but without showing the analysis
    $jdData = Load-JobDescription -jdId $JdId
    $resumeData = Load-ResumeEncoding -branchName $BranchName
    
    if ($jdData -and $resumeData) {
        $alignment = Analyze-Alignment -jdData $jdData -resumeData $resumeData
        
        # Save analysis to resume encoding
        $encodingPath = "analysis\$($resumeData.encoding_file)"
        
        # Initialize job_descriptions array if it doesn't exist
        if (-not $resumeData.job_descriptions) {
            $resumeData | Add-Member -NotePropertyName "job_descriptions" -NotePropertyValue @()
        }
        
        # Check if this JD is already associated
        $existingJd = $resumeData.job_descriptions | Where-Object { $_.jd_id -eq $JdId }
        
        if ($existingJd) {
            # Update existing entry
            $existingJd.alignment_score = $alignment.alignment_score
            $existingJd.matched_skills = $alignment.matched_skills
            $existingJd.missing_skills = $alignment.missing_skills
            
            # Set as primary if requested
            if ($SetPrimary) {
                # Reset all other JDs to not primary
                $resumeData.job_descriptions | ForEach-Object {
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
                $resumeData.job_descriptions | ForEach-Object {
                    $_.is_primary = $false
                }
            }
            
            # Add to job_descriptions array
            $resumeData.job_descriptions += $newJdEntry
        }
        
        # Save updated encoding
        $resumeData | ConvertTo-Json -Depth 6 | Set-Content $encodingPath
        
        # Update index file to record this association
        $index = Load-Index
        $jdEntry = $index.job_descriptions | Where-Object { $_.jd_id -eq $JdId }
        
        if ($jdEntry) {
            # Initialize used_by array if it doesn't exist
            if (-not $jdEntry.used_by) {
                $jdEntry | Add-Member -NotePropertyName "used_by" -NotePropertyValue @()
            }
            
            # Add branch to used_by if not already there
            if ($jdEntry.used_by -notcontains $BranchName) {
                $jdEntry.used_by += $BranchName
            }
            
            # Update resume entry in index with JD info
            $resumeEntry = $index.encodings | Where-Object { $_.branch_name -eq $BranchName }
            if ($resumeEntry) {
                if ($SetPrimary) {
                    $resumeEntry | Add-Member -NotePropertyName "primary_jd" -NotePropertyValue $JdId -Force
                    $resumeEntry | Add-Member -NotePropertyName "jd_alignment" -NotePropertyValue $alignment.alignment_score -Force
                }
            }
            
            # Save updated index
            Save-Index -indexData $index
        }
        
        Write-Host "Associated job description $JdId with resume branch $BranchName." -ForegroundColor Green
        if ($SetPrimary) {
            Write-Host "Set as primary job description for this resume." -ForegroundColor Green
        }
        Write-Host "Alignment score: $($alignment.alignment_score)%" -ForegroundColor Cyan
    }
}

# Action: Find best resume match for a JD
if ($Action -eq "best-match") {
    if (-not $JdId) {
        Write-Host "Error: JD ID is required to find best matching resume." -ForegroundColor Red
        exit 1
    }
    
    $jdData = Load-JobDescription -jdId $JdId
    
    if ($jdData) {
        $index = Load-Index
        
        $results = @()
        
        foreach ($encoding in $index.encodings) {
            $resumeData = Load-ResumeEncoding -branchName $encoding.branch_name
            
            if ($resumeData) {
                $alignment = Analyze-Alignment -jdData $jdData -resumeData $resumeData
                
                $results += [PSCustomObject]@{
                    BranchName = $encoding.branch_name
                    AlignmentScore = $alignment.alignment_score
                    MatchedSkills = $alignment.matched_skills.Count
                    MissingSkills = $alignment.missing_skills.Count
                }
            }
        }
        
        # Sort by alignment score (descending)
        $sortedResults = $results | Sort-Object -Property AlignmentScore -Descending
        
        Write-Host "Best matching resumes for $($jdData.company) - $($jdData.position):" -ForegroundColor Cyan
        Write-Host "-----------------------------------------------------------" -ForegroundColor White
        Write-Host "RANK | BRANCH                          | SCORE | MATCHED | MISSING" -ForegroundColor White  
        Write-Host "-----------------------------------------------------------" -ForegroundColor White
        
        $rank = 1
        foreach ($result in $sortedResults) {
            $rankPadded = $rank.ToString().PadRight(4)
            $branchPadded = $result.BranchName.PadRight(34)
            $scorePadded = "$($result.AlignmentScore)%".PadRight(7)
            $matchedPadded = $result.MatchedSkills.ToString().PadRight(8)
            
            Write-Host "$rankPadded | $branchPadded | $scorePadded | $matchedPadded | $($result.MissingSkills)" -ForegroundColor White
            
            $rank++
        }
        Write-Host "-----------------------------------------------------------" -ForegroundColor White
        
        # Show detailed info for top match
        if ($sortedResults.Count -gt 0) {
            $topMatch = $sortedResults[0]
            $topResumeData = Load-ResumeEncoding -branchName $topMatch.BranchName
            $topAlignment = Analyze-Alignment -jdData $jdData -resumeData $topResumeData
            
            Write-Host ""
            Write-Host "Top Match Details:" -ForegroundColor Green
            Write-Host "Resume:     $($topMatch.BranchName)"
            Write-Host "Alignment:  $($topMatch.AlignmentScore)%"
            Write-Host ""
            
            Write-Host "Matched Skills:" -ForegroundColor Green
            $topAlignment.matched_skills | ForEach-Object {
                Write-Host "✓ $_"
            }
            
            Write-Host ""
            Write-Host "Missing Skills:" -ForegroundColor Yellow
            if ($topAlignment.missing_skills -and $topAlignment.missing_skills.Count -gt 0) {
                $topAlignment.missing_skills | ForEach-Object {
                    Write-Host "✗ $_"
                }
            } else {
                Write-Host "No missing skills."
            }
        }
    }
}
