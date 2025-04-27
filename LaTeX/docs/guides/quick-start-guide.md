# Quick Start Guide: Resume Tagging with Git Branches

## First Steps

1. **Verify your repository structure**
   - Ensure your repository has these directories in each branch:
     - `CurriculumVitae/`: Contains all CV TeX files directly (no subdirectories)
     - `Resume/`: Contains tailored resume TeX files directly (no subdirectories)
   - Create an `analysis` directory to store encoding outputs:
   ```powershell
   mkdir -p analysis
   ```

2. **Create the extraction script**
   - Create a file named `extract_cv_resume.ps1` with the PowerShell script content
   - Save it in the root directory (common parent of CurriculumVitae and Resume)
   - The script will extract these files from both directories:
     - `main.tex` - Contains important aliases and settings
     - `1.Summary.tex` - Professional Summary
     - `2.1.Microsoft.tex` - Microsoft Experience
     - `2.2.Google.tex` - Google Experience 
     - `3.Education.tex` - Education
     - `4.Skills.tex` - Technical Skills
     - `7.Interests.tex` - Professional Interests

3. **Analyze your current branch**
   - Check out the branch you want to analyze:
   ```powershell
   git checkout resume/your_branch_name
   ```
   - Run the extraction script from the repository root:
   ```powershell
   .\extract_cv_resume.ps1
   ```
   - Open Cursor and create a new file with the updated analysis prompt
   - Let Cursor analyze the extracted files
   - Save the JSON output as `analysis/ResumeEncoding.json`
   - Review the encoding to understand content coverage and focus

## Workflow for New Resume Creation

1. **Find the best match for a new job description**
   - Review your existing Resume branches and encodings
   - Choose the closest matching branch based on focus areas

2. **Create a new branch**
   ```powershell
   git checkout resume/best_match_branch
   git checkout -b resume/new_position_company_date
   ```

3. **Use the tailoring prompt**
   - Create a file in your new branch called `tailoring_notes.md`
   - Copy the "Resume Tailoring Prompt" into Cursor
   - Add the job description and run the analysis
   - Apply the recommendations in four phases:
     - Phase 1: Content Exclusion
     - Phase 2: Content Editing
     - Phase 3: Content Addition
     - Phase 4: Content Reordering

4. **Analyze your tailored resume**
   - Run the extraction script again
   - Use Cursor to analyze the new content
   - Save the encoding to the `analysis` directory
   - Before switching branches, copy the encoding to main if desired:
   ```powershell
   # From your resume branch
   git checkout main -- analysis/
   git commit -m "Add encoding for [branch-name]"
   git checkout resume/your_branch_name
   ```

## CV Augmentation (Reverse Tailoring)

When you've created a resume with valuable new or refined content:

1. **Identify content for CV augmentation**
   - Check the `cv_augmentation` section in your encoding
   - Review each item for accuracy and value

2. **Update your CV in the current branch**
   - Apply the valuable refinements to your CV
   - Commit the changes

3. **Consider merging CV improvements to main**
   ```powershell
   git checkout main
   git checkout -b cv-update
   git checkout resume/your_branch -- CurriculumVitae/path/to/file.tex
   git commit -m "Update CV with refined content"
   git checkout main
   git merge cv-update
   ```

## Using Visualization

1. **Setup the visualization tool**
   - Save the HTML visualization file to `analysis/resume_visualization.html`

2. **Visualize encoding data**
   - Open the HTML file in a browser
   - Paste your `ResumeEncoding.json` content into the input box
   - Click "Visualize Content" to generate:
     - Radar chart showing coverage percentages for all sections (including main.tex)
     - Bar chart showing detailed breakdown of technical skills
     - Table with coverage metrics, weights, and content density
     - List of any content that should be added to your CV