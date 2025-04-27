# Resume Content Comparison and Encoding Prompt

```
I need you to analyze and compare the CV and Resume TeX files for precise content tracking and encoding.

CONTEXT:
- I maintain two directories:
  - CurriculumVitae/: Contains comprehensive CV content (source of truth)
  - Resume/: Contains a tailored 2-page resume derived from the CV
- The files have been extracted to analysis/current_branch/cv/ and analysis/current_branch/resume/
- I need to quantify precisely what CV content appears in the Resume
- The Interests section should be assigned a lower weight in the analysis

TASK:
1. Compare the Resume TeX files against the corresponding CV TeX files in the extracted directories
2. Quantify exactly what content from the CV appears in the Resume
3. Generate a detailed encoding with focus tags, content percentages, and keyword analysis
4. Create visualization data for comparing content coverage
5. Identify any content in the Resume that might be new and should be added back to the CV

FILE STRUCTURE:
The key files to analyze in both CV and Resume are:
- 1.Summary.tex (Professional Summary)
- 2.1.Microsoft.tex (Microsoft Experience)
- 2.2.Google.tex (Google Experience) 
- 3.Education.tex (Education at USP)
- 4.Skills.tex (Technical Skills with subsections)
- 7.Interests.tex (Professional Interests - assign lower weight)

ENCODING SYSTEM:
Generate the following metrics:
1. Focus Tags: 3-5 technical/professional areas that best describe this resume's emphasis
2. Composite Scores: Percentage-based coverage for each major section
   - Apply a weight of 0.5 to the Interests section compared to other sections
3. Detailed Scores: Content-specific inclusion percentages for subsections
4. Keyword Emphasis: Frequency analysis of key technical terms
5. Content Density: How detailed vs. condensed each section is compared to the CV
6. CV Augmentation: Any content in the Resume that doesn't exist in the CV
7. Visualization Data: Metrics formatted for radar charts

OUTPUT FORMAT:
Generate a JSON file called "ResumeEncoding.json" with this structure:
```json
{
  "branch_name": "[CURRENT_BRANCH_NAME]",
  "timestamp": "[CURRENT_DATE_TIME]",
  "focus_tags": ["data-engineering", "cloud-infrastructure", "backend-services"],
  "section_weights": {
    "professional_summary": 1.0,
    "microsoft_experience": 1.0,
    "google_experience": 1.0,
    "education": 1.0,
    "technical_skills": 1.0,
    "professional_interests": 0.5
  },
  "composite_scores": {
    "professional_summary": 80,
    "microsoft_experience": 90,
    "google_experience": 40,
    "education": 70,
    "technical_skills": 75,
    "professional_interests": 60,
    "weighted_average": 78
  },
  "detailed_scores": {
    "microsoft_experience": {
      "team_a_project": 100,
      "team_b_project": 80,
      "team_c_project": 0
    },
    "technical_skills": {
      "cloud_distributed_systems": 90,
      "data_engineering": 100,
      "api_web_technologies": 60,
      "programming_languages": 75,
      "ai_ml": 40,
      "cs_fundamentals": 70,
      "professional_skills": 80
    }
  },
  "keyword_emphasis": {
    "azure": 9,
    "data-pipelines": 7,
    "python": 5,
    "distributed-systems": 8
  },
  "content_density": {
    "microsoft_experience": "detailed",
    "google_experience": "condensed",
    "education": "standard"
  },
  "cv_augmentation": {
    "new_content": [
      {
        "section": "microsoft_experience",
        "content": "Led migration of legacy data pipeline to Azure Data Factory, reducing processing time by 40%",
        "target_cv_file": "2.1.Microsoft.tex"
      }
    ]
  },
  "visualization": {
    "radar_chart_data": {
      "labels": ["Summary", "Microsoft", "Google", "Education", "Skills", "Interests"],
      "values": [80, 90, 40, 70, 75, 60]
    }
  }
}
```

ANALYSIS APPROACH:
1. For each section:
   - Count total bullet points/paragraphs in CV
   - Calculate percentage of CV content included in Resume
   - Identify which specific content items are included/excluded
   - Analyze terminology frequency and emphasis
   - Check for new or modified content in Resume not present in CV

2. For focus tagging:
   - Look for skill categories with highest representation
   - Identify experience areas with most detailed coverage
   - Note technologies mentioned multiple times across sections
   - Consider position of content (earlier = more emphasis)

3. For weighted scoring:
   - Apply full weight (1.0) to all sections except Interests
   - Apply half weight (0.5) to the Interests section
   - Calculate weighted average for overall content match

REQUIREMENTS:
- Content analysis must be precise and objective
- Only compare actual content, not formatting or structure differences
- Focus on what's included/excluded rather than abstract categories
- Generate clear focus tags that help identify the resume's primary emphasis
- Identify any content in the Resume that should be considered for addition to the CV
- Account for the lower importance of the Interests section in overall scores

After completing the analysis, explain the encoding system with examples and provide the full JSON reference file.
```