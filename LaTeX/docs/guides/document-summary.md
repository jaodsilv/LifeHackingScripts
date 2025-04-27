# Resume Tagging System: Complete Document Summary

| Filename | Type | Description |
|----------|------|-------------|
| **PowerShell Scripts** | | |
| extract_cv_resume.ps1 | PowerShell script | Extracts TeX files from CurriculumVitae and Resume directories for analysis |
| manage_encodings.ps1 | PowerShell script | Manages encoding files with commands for save, list, find, compare, and JD matching operations |
| html-report-generator.ps1 | PowerShell script | Generates interactive HTML comparison reports between resume versions with JD alignment metrics |
| manage_job_descriptions.ps1 | PowerShell script | Manages job description metadata with commands for add, list, show, analyze, associate, and best-match |
| report-manager.ps1 | PowerShell script | Manages HTML reports with actions for list, cleanup, regenerate, timeline, and index |
| ~~extract_branch_files.ps1~~ | PowerShell script | Deprecated initial extraction script for multiple branches |
| ~~extract_branch_files_simplified.ps1~~ | PowerShell script | Deprecated simplified extraction script |
| ~~extract_current_branch.ps1~~ | PowerShell script | Deprecated extraction script for single branch analysis |
| **Web Components** | | |
| resume_visualization.html | HTML/JavaScript | Interactive visualization tool for individual resume encodings |
| encoding_browser.html | HTML/JavaScript | Main dashboard for browsing, filtering, and selecting encodings |
| encoding_detail.html | HTML/JavaScript | Detailed view of a single encoding with comprehensive metrics and visualizations |
| encoding_compare.html | HTML/JavaScript | Side-by-side comparison of two encodings with difference highlighting |
| styles.css | CSS | Shared styles for the web interface components |
| utils.js | JavaScript | Shared utility functions for file handling, UI operations, and data processing |
| header.js | JavaScript | Shared header component for consistent navigation across web pages |
| ~~simple-visualization.html~~ | HTML/JavaScript | Deprecated standalone visualization component |
| **Analysis Output** | | |
| ResumeEncoding.json | JSON | Output file containing detailed encoding of resume content comparison |
| ResumeEncodings.json | JSON | Master index file tracking all resume encodings |
| **Prompts** | | |
| cursor-prompt-updated.md | Cursor prompt | Updated prompt for analyzing and encoding resume content differences |
| resume-tailoring-prompt.md | Cursor prompt | Step-by-step prompt for tailoring resumes with 4-phase approach |
| continuation-prompt.md | Claude prompt | Prompt for continuing development in a new conversation |
| ~~cursor-prompt.md~~ | Cursor prompt | Deprecated initial prompt for resume analysis |
| ~~cursor-prompt-simplified.md~~ | Cursor prompt | Deprecated simplified version of analysis prompt |
| ~~cursor-git-branch-prompt.md~~ | Cursor prompt | Deprecated prompt for branch-based analysis |
| **Documentation** | | |
| quick-start-guide.md | Guide | Step-by-step instructions for using the system |
| resume-matching-guide.md | Guide | Instructions for finding the best resume for a job description |
| implementation-plan-simplified.md | Plan | Comprehensive implementation plan for the system |
| json-organization-strategy-updated.md | Strategy | Organization strategy with HTML report integration |
| jd-tracking-implementation-plan.md | Plan | Implementation plan for Job Description Metadata Tracking |
| auto-report-implementation-plan.md | Plan | Implementation plan for Automatic HTML Report Generation |
| web-interface-plan.md | Plan | Implementation plan for Web Interface for Browsing Encodings |
| web-integration-guide.md | Guide | Integration guide for the web interface components |
| ~~json-organization-strategy.md~~ | Strategy | Deprecated initial organization strategy |
| **Templates and Reports** | | |
| report_template.html | HTML template | Enhanced template for HTML comparison reports with JD alignment |
| reports_index.html | HTML template | Web interface for browsing generated reports |
