# Script to extract TeX files from CurriculumVitae and Resume directories
# Save as extract_cv_resume.ps1 and run from the repository root
# Run this from the common root directory containing both folders

# Configuration
$OUTPUT_DIR = "analysis\current_branch"
$CV_DIR = "CurriculumVitae"
$RESUME_DIR = "Resume"
$CV_SUBDIR = "cv"
$RESUME_SUBDIR = "resume"
$FILE_LIST = @(
  "main.tex",
  "1.Summary.tex",
  "2.1.Microsoft.tex",
  "2.2.Google.tex",
  "3.Education.tex",
  "4.Skills.tex",
  "7.Interests.tex"
)

# Get current branch name
$CURRENT_BRANCH = git branch --show-current

Write-Host "Analyzing current branch: $CURRENT_BRANCH" -ForegroundColor Cyan

# Ensure output directory exists
New-Item -ItemType Directory -Path $OUTPUT_DIR -Force | Out-Null
New-Item -ItemType Directory -Path (Join-Path -Path $OUTPUT_DIR -ChildPath $CV_SUBDIR) -Force | Out-Null
New-Item -ItemType Directory -Path (Join-Path -Path $OUTPUT_DIR -ChildPath $RESUME_SUBDIR) -Force | Out-Null

# Function to extract file to target directory
function Extract-File {
  param (
    [string]$sourceDir,
    [string]$file,
    [string]$targetSubdir,
    [string]$type
  )
  
  $source_file = Join-Path -Path $sourceDir -ChildPath $file
  $output_dir = Join-Path -Path $OUTPUT_DIR -ChildPath $targetSubdir
  $output_file = Join-Path -Path $output_dir -ChildPath $file
  
  # Extract file from the source directory
  Write-Host "Extracting $type file: $file..."
  
  try {
    if (Test-Path $source_file) {
      Copy-Item -Path $source_file -Destination $output_file -Force
      Write-Host "✓ Successfully copied $file from $sourceDir" -ForegroundColor Green
    } else {
      Write-Host "⚠ File $file not found in $sourceDir" -ForegroundColor Yellow
      # Create an empty file to maintain structure
      "" | Out-File -FilePath $output_file -Encoding utf8
    }
  } catch {
    Write-Host "⚠ Failed to copy $file - $($_.Exception.Message)" -ForegroundColor Yellow
    # Create an empty file to maintain structure
    "" | Out-File -FilePath $output_file -Encoding utf8
  }
}

# Check if the required directories exist
if (-not (Test-Path $CV_DIR)) {
  Write-Host "⚠ $CV_DIR directory not found!" -ForegroundColor Red
  Write-Host "This script should be run from the common root directory that contains both $CV_DIR and $RESUME_DIR folders." -ForegroundColor Yellow
  exit
}

if (-not (Test-Path $RESUME_DIR)) {
  Write-Host "⚠ $RESUME_DIR directory not found!" -ForegroundColor Red
  Write-Host "This script should be run from the common root directory that contains both $CV_DIR and $RESUME_DIR folders." -ForegroundColor Yellow
  exit
}

foreach ($file in $FILE_LIST) {
  # Extract CV file
  Extract-File -sourceDir $CV_DIR -file $file -targetSubdir $CV_SUBDIR -type "CV"
  
  # Extract Resume file
  Extract-File -sourceDir $RESUME_DIR -file $file -targetSubdir $RESUME_SUBDIR -type "Resume"
}

# Create a metadata file with branch information
$metadata = @{
  "branch_name" = $CURRENT_BRANCH
  "timestamp" = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
  "cv_dir" = $CV_DIR
  "resume_dir" = $RESUME_DIR
} | ConvertTo-Json

$metadata | Out-File -FilePath (Join-Path -Path $OUTPUT_DIR -ChildPath "metadata.json") -Encoding utf8

Write-Host "=== Extraction complete ===" -ForegroundColor Green
Write-Host "Files extracted to $OUTPUT_DIR"
Write-Host "You can now analyze these files using Cursor"