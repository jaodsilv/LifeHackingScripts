# Job Description Metadata Tracking Implementation Plan

## 1. Overview

This feature will enhance the resume management system by adding tracking for job descriptions that each resume version is tailored for. This will enable:
- Recording which job listings inspired each resume version
- Tracking alignment between resume content and job requirements
- Comparing how different resume versions match various job descriptions
- Guiding future resume optimizations based on job market trends

## 2. Data Structure Changes

### 2.1 New Job Description Storage Format

Create a new JSON structure for storing job descriptions:

```json
{
  "jd_id": "company_position_date",
  "company": "Example Corp",
  "position": "Senior Data Engineer",
  "date_added": "2023-10-15",
  "url": "https://example.com/jobs/12345",
  "key_requirements": [
    "5+ years experience with data pipelines",
    "Azure Data Factory expertise",
    "Python programming"
  ],
  "key_skills": [
    "data-pipelines",
    "azure",
    "python",
    "spark"
  ],
  "full_description": "Full text of job description...",
  "status": "active"
}
```

### 2.2 Enhanced Resume Encoding Structure

Update the existing encoding JSON structure to include JD references:

```json
{
  "branch_name": "resume/data_engineer_2023q4",
  "timestamp": "2023-10-15 14:30:22",
  "focus_tags": ["data-engineering", "cloud-infrastructure", "backend-services"],
  
  // New JD metadata section
  "job_descriptions": [
    {
      "jd_id": "examplecorp_seniordata_20231001",
      "alignment_score": 85,
      "matched_skills": ["azure", "data-pipelines", "python"],
      "missing_skills": ["spark"],
      "is_primary": true
    },
    {
      "jd_id": "techfirm_datarole_20231005",
      "alignment_score": 78,
      "matched_skills": ["azure", "python"],
      "missing_skills": ["kubernetes", "terraform"],
      "is_primary": false
    }
  ],
  
  // Existing fields continue...
  "section_weights": {...},
  "composite_scores": {...},
  //...
}
```

### 2.3 Index File Update

Update the index.json structure to include JD summary information:

```json
{
  "encodings": [
    {
      "branch_name": "resume/data_engineer_2023q4",
      "encoding_file": "encodings/resume_data_engineer_2023q4.json",
      "focus_tags": ["data-engineering", "cloud-infrastructure", "backend-services"],
      "weighted_score": 78,
      "created_date": "2023-10-15",
      "last_analyzed": "2023-10-15",
      "primary_jd": "examplecorp_seniordata_20231001",
      "jd_alignment": 85
    }
  ],
  "job_descriptions": [
    {
      "jd_id": "examplecorp_seniordata_20231001",
      "company": "Example Corp",
      "position": "Senior Data Engineer",
      "date_added": "2023-10-01",
      "used_by": ["resume/data_engineer_2023q4", "resume/azure_expert_2023q4"]
    }
  ],
  "last_updated": "2023-10-15"
}
```

## 3. New Script: manage_job_descriptions.ps1

Create a new PowerShell script to handle job description management:

```powershell
# manage_job_descriptions.ps1
param (
    [Parameter(Mandatory=$true)]
    [ValidateSet("add", "list", "show", "analyze", "associate")]
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
    [string]$BranchName,
    
    [Parameter(Mandatory=$false)]
    [switch]$SetPrimary
)

# Configuration
$JD_DIR = "analysis\job_descriptions"
$INDEX_FILE = "analysis\index.json"

# Implementation of actions:
# - add: Add a new JD to the system
# - list: List all JDs
# - show: Display details for a specific JD
# - analyze: Analyze alignment between a JD and resume
# - associate: Associate a JD with a resume branch
```

## 4. Updates to Existing Scripts

### 4.1 manage_encodings.ps1 Updates

Modify to integrate JD metadata:

- Update the "save" action to include JD info
- Enhance "list" command to show JD alignment
- Add "jd-match" command to find best resume for a given JD

### 4.2 html-report-generator.ps1 Updates

Enhance reporting to include JD alignment:

- Add JD information section to reports
- Add skill match visualization
- Compare multiple resumes against the same JD

### 4.3 resume_visualization.html Updates

Update visualization to show JD alignment:

- Add JD metadata display
- Add matched/missing skills visualization
- Add JD requirement coverage charts

## 5. Implementation Steps

1. Create directory structure for JD storage
2. Implement manage_job_descriptions.ps1
3. Update manage_encodings.ps1
4. Update visualization tools
5. Create test JDs and validate functionality
6. Update documentation

## 6. Testing Plan

1. Test adding new JDs to the system
2. Test associating JDs with resume branches
3. Test analyzing JD-resume alignment
4. Test visualization of JD metadata
5. Test report generation with JD information
6. Test finding best resume for a given JD

## 7. Command Reference

New commands to be implemented:

```
# Add a new job description
./manage_job_descriptions.ps1 -Action add -Company "Example Corp" -Position "Senior Data Engineer" -JdFile "path/to/jd.txt"

# List all job descriptions
./manage_job_descriptions.ps1 -Action list

# Show details for a specific JD
./manage_job_descriptions.ps1 -Action show -JdId "examplecorp_seniordata_20231001"

# Analyze alignment between a JD and resume
./manage_job_descriptions.ps1 -Action analyze -JdId "examplecorp_seniordata_20231001" -BranchName "resume/data_engineer_2023q4"

# Associate a JD with a resume branch
./manage_job_descriptions.ps1 -Action associate -JdId "examplecorp_seniordata_20231001" -BranchName "resume/data_engineer_2023q4" -SetPrimary

# Find best resume for a JD
./manage_encodings.ps1 -Action jd-match -JdId "examplecorp_seniordata_20231001"
```
