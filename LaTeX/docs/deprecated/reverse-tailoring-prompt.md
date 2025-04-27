# CV Augmentation (Reverse Tailoring) Prompt

```
I need you to analyze a newly created resume and identify content that should be added back to my comprehensive CV.

TASK:
1. Compare the TeX files in this tailored Resume with the corresponding files in my CurriculumVitae directory
2. Identify any new or modified content in the Resume that doesn't exist in the CV
3. Generate suggestions for adding this content back to the appropriate CV files
4. Output a structured plan for CV augmentation

FILE STRUCTURE:
The key files to analyze in both directories are:
- 1.Summary.tex (Professional Summary)
- 2.1.Microsoft.tex (Microsoft Experience)
- 2.2.Google.tex (Google Experience)
- 3.Education.tex (Education at USP)
- 4.Skills.tex (Technical Skills with subsections)
- 7.Interests.tex (Professional Interests)

ANALYSIS APPROACH:
1. For each file pair (Resume version and CV version):
   - Perform a detailed text diff to identify additions in the Resume
   - Look for rephrased or refined statements that improve upon CV content
   - Note any new accomplishments, metrics, or project details
   - Check for updated terminology or technology references

2. For each identified addition:
   - Evaluate if it's genuinely new information or just reformatted existing content
   - Determine the appropriate location in the CV file for insertion
   - Consider if it should replace existing content or be added alongside it
   - Verify it doesn't contradict other CV content

OUTPUT FORMAT:
Generate a structured plan in this format:

# CV Augmentation Plan

## New Content Identified

### 1. Microsoft Experience (2.1.Microsoft.tex)
- **New bullet point**: "Led migration of legacy data pipeline to Azure Data Factory, reducing processing time by 40%"
  - **Context**: This appears under the Team X project section
  - **Recommendation**: Add as a new bullet point after line 25 in 2.1.Microsoft.tex
  - **Rationale**: Provides specific metric about efficiency improvement

- **Enhanced description**: "Designed and implemented a distributed processing architecture that scaled to handle 5TB of daily data"
  - **Original in CV**: "Built a distributed processing system for large data volumes"
  - **Recommendation**: Replace the original text at line 42 with this enhanced version
  - **Rationale**: Adds specific scale information and more precise terminology

### 2. Technical Skills (4.Skills.tex)
- **New skill**: "Apache Airflow"
  - **Context**: Listed under Data Engineering skills
  - **Recommendation**: Add to the Data Engineering section at line 78
  - **Rationale**: This tool was not previously mentioned but appears relevant to experience

## Implementation Steps
1. Make a backup of current CV files
2. Update each file with the recommended additions
3. Verify consistency across the complete CV after all changes
4. Update the ResumeEncodings.json file to reflect the CV enhancements

## Additional Observations
- The resume contains more concise phrasing for several achievements that could improve the CV
- Consider reviewing the overall structure of the Microsoft experience section to better highlight key projects

REQUIREMENTS:
- Focus only on substantive content additions, not formatting changes
- Recommend precise locations for insertions using line numbers or context
- Provide clear rationale for each suggested addition
- Ensure all suggested additions maintain the professional tone and accuracy of the CV
- Flag any potential inconsistencies or contradictions that might arise from additions
```