# Resume Tagging Implementation Plan

## Overview

This plan outlines a streamlined approach to resume content analysis and tagging, focusing on 1-to-1 comparisons between CV and Resume files within the same branch. The process is designed to work with your specific directory structure and Git branch workflow.

## Step 1: Set Up Environment

1. **Verify repository structure**
   - Ensure each branch contains:
     - `CurriculumVitae/`: Directory with comprehensive CV TeX files
     - `Resume/`: Directory with tailored resume TeX files
   - Create an analysis directory for outputs:
   ```powershell
   mkdir -p analysis
   ```

2. **Install Cursor**
   - Download and install Cursor if you haven't already: [https://cursor.sh/](https://cursor.sh/)
   - Set up a workspace that includes your repository

3. **Prepare analysis tools**
   - Save the extraction script (`extract_cv_resume.ps1`) to your repository root
   - Save the visualization HTML file (`resume_visualization.html`) to the analysis directory

## Step 2: Branch-Specific Analysis Process

For each branch you want to analyze:

1. **Check out the target branch**
   ```powershell
   git checkout resume/your_branch_name
   ```

2. **Extract files for analysis**
   - Run the extraction script from the repository root:
   ```powershell
   .\extract_cv_resume.ps1
   ```
   - This creates a structured directory at `analysis/current_branch/` with CV and Resume files

3. **Run the encoding analysis**
   - Open Cursor and create a new file
   - Copy the "Updated Cursor Prompt for Resume Analysis" into this file
   - Use Cursor to process the prompt and analyze the extracted files
   - Save the generated JSON file as `analysis/ResumeEncoding.json`

4. **Visualize the results**
   - Open `analysis/resume_visualization.html` in a browser
   - Paste the contents of `ResumeEncoding.json` into the input area
   - Examine the radar chart, bar chart, and metrics

5. **Save the encoding to main branch (optional)**
   - If you want to store the encoding in main:
   ```powershell
   # While still in your feature branch
   cp analysis/ResumeEncoding.json analysis/resume_your_branch_name.json
   git add analysis/resume_your_branch_name.json
   git commit -m "Add encoding for resume branch"
   
   # Later merge to main if desired
   git checkout main
   git checkout your_branch_name -- analysis/resume_your_branch_name.json
   git commit -m "Add resume encoding from feature branch"
   ```

## Step 3: Resume Creation Workflow

When creating a new tailored resume:

1. **Analyze job requirements**
   - Review the job description carefully
   - Identify key skills, technologies, and experience required
   - Determine primary focus areas needed

2. **Select best existing branch**
   - Review your encodings from previous branches
   - Look for branches with similar focus tags and content emphasis
   - Choose the one that most closely aligns with the new job requirements

3. **Create new feature branch**
   ```powershell
   git checkout resume/best_match_branch
   git checkout -b resume/new_branch_name
   ```

4. **Use tailoring prompt**
   - Create a `tailoring_notes.md` file in your new branch
   - Copy the "Resume Tailoring Prompt" into Cursor
   - Add the job description and use Cursor to generate tailoring guidance
   - Apply changes in four distinct phases:
     - Phase 1: Content Exclusion (what to remove)
     - Phase 2: Content Editing (what to modify)
     - Phase 3: Content Addition (what to add from CV)
     - Phase 4: Content Reordering (how to prioritize)

5. **Analyze and validate new resume**
   - After tailoring, run the extraction and analysis again
   - Review the encoding to confirm appropriate focus and content coverage
   - Make additional adjustments if needed

## Step 4: CV Augmentation (Reverse Tailoring)

When you've created a particularly good resume with refined content:

1. **Identify CV augmentation opportunities**
   - Review the `cv_augmentation` section in your encoding
   - Validate each item to ensure it's accurate and valuable
   - Determine if it belongs in your comprehensive CV

2. **Update your CV**
   - Make the identified updates to your CV files in the current branch
   - Focus on additions that genuinely enhance the completeness of your CV
   - Commit the changes to your current branch

3. **Merge improvements to main (if desired)**
   ```powershell
   git checkout main
   git checkout -b cv-update-from-branch
   git checkout resume/your_branch -- CurriculumVitae/path/to/file.tex
   git commit -m "Update CV with refined content from branch"
   git checkout main
   git merge cv-update-from-branch
   ```

## Visualization and Analysis

The visualization tool provides several valuable views:

1. **Content Coverage Radar Chart**
   - Shows overall coverage percentages across major sections
   - Quickly identifies which sections have been emphasized/de-emphasized

2. **Technical Skills Breakdown**
   - Displays detailed coverage within the skills section
   - Helps identify skill emphasis patterns

3. **Content Metrics Table**
   - Shows coverage percentages, section weights, and content density
   - Includes weighted average that accounts for lower weight of Interests section

4. **CV Augmentation List**
   - Lists all content in the Resume that's not in the CV
   - Provides target files for potential additions

## Maintenance and Evolution

As you create more tailored resumes:

1. **Refine your analysis prompt**
   - Adjust metrics and weights based on what you find most useful
   - Update the prompt to focus on areas most relevant to your career

2. **Create a resume catalog**
   - Consider creating a central spreadsheet/document in main branch
   - List all resume branches with their focus tags and key metrics
   - Use this as a quick reference when starting a new tailoring job

3. **Periodically update scripts**
   - Refine the extraction script as needed
   - Enhance the visualization to track metrics over time