# `check_ats_compliance` Command Documentation
SCOPE: project

## Purpose
Evaluates resume files for ATS (Applicant Tracking System) compliance and generates a detailed report with scores across multiple categories.

## Syntax
```
check_ats_compliance [parameters]
```

## Parameters

| Parameter | Description | Required | Example Values | Default Value |
|-----------|-------------|----------|----------------|---------------|
| `cv` | CV file(s) to evaluate | No | `"main.tex"`, `["main.tex", "cv.pdf"]` | Files matching `*.tex` pattern or inferred from context |
| `cv_source` | Source location of the CV | No | `project`, `attachment` | Inferred from context |
| `suggest_improvements` | Whether to include suggested improvements | No | `true`, `false` | `false` |
| `job_position` | Single job position to evaluate against | No | `"Senior Backend Engineer"`, `{"position":"Senior Backend Engineer", "company":"Google"}`, `{"position":"Senior Backend Engineer", "company":"Google", "job_description":"ABC aBC"}` | `"Senior Backend Software Engineer"` |
| `job_positions` | Multiple job positions (comma-separated) | No | `["Senior Backend Engineer", "Data Engineer"]` | `["Senior Backend Software Engineer", "Senior Distributed Systems Engineer", "Senior Data Engineer"]` |
| `output_format` | Format of the evaluation output | No | `markdown`, `json`, `text` | `markdown` |
| `detailed_analysis` | Include detailed analysis for each category | No | `true`, `false` | `true` |
| `include_weaknesses` | Include weaknesses for each category | No | `true`, `false` | `true` |
| `min_score_threshold` | Minimum score to consider a category passing | No | `0.7`, `0.8` | `0.7` |
| `exclude_categories` | Categories to exclude from evaluation | No | `["Style", "Personality"]` | `[]` |
| `custom_keywords` | Additional keywords for tailoring evaluation | No | `["kubernetes", "microservices"]` | `[]` |
| `language` | Language of the resume | No | `en`, `pt`, `es` | `en` |

## Examples

```
check_ats_compliance
```
Evaluates all .tex files in the project for ATS compliance against default job positions.

```
check_ats_compliance cv:main.tex cv_source:attachment job_position:"Senior Software Architect" suggest_improvements:true
```
Evaluates the attached main.tex file against the "Senior Software Architect" position with suggested improvements.

```
check_ats_compliance cv:[resume.tex, cv.pdf] output_format:json detailed_analysis:false
```
Evaluates both resume.tex and cv.pdf files, outputs results in JSON format without detailed analysis.

```
check_ats_compliance cv:main.tex job_position:{"position":"Senior Backend Engineer", "company":"Google", "job_description":"ABC aBC"}
```
Evaluates main.tex against the "Senior Backend Engineer" position at Google, using the provided job description.

## Evaluation Categories

The command evaluates resumes across the following categories and subcategories:

### Tailoring (for each job position)
- **Hard Skills**: Assesses presence of relevant technical skills, programming languages, and methodologies for the specified job position
- **Soft Skills**: Evaluates inclusion of relevant interpersonal, leadership, and communication skills

### Content
- **ATS Parse Rate**: Measures how well an ATS can extract information from the resume
- **Quantifying Impact**: Evaluates the use of metrics and numbers to demonstrate achievements
- **Experience Relevance**: Even if an experience is properly quantified, it can still be less or more relevant, especially if a job positions is associated with this evaluation
- **Unnecessary information**: Identifies unnecessary information
- **Completeness**: Check for completeness of information within sections
- **Repetition/Redundancy**: Checks for word repetition and redundant content
- **Spelling & Grammar**: Assesses the resume for typos, spelling and grammatical errors
- **Tone**: Checks if resume is entirely in a Professional tone

### Format
- **File Format & Size**: Evaluates compatibility with common ATS systems (PDF preferred, under 2MB)
- **Resume Length**: Assesses appropriate length based on experience level (generally 1-2 pages)
- **Long Bullet Points**: Checks for overly long bullet points (ideally 20-50 words)

### Sections
- **Essential Sections**: Verifies presence of required sections (Experience, Education, Skills)
- **Personality**: Evaluates appropriate inclusion of personal sections (Interests, Books, Hobbies)

### Style
- **Design**: Assesses visual appeal and readability of the resume
- **Word Choice**: Evaluates word choices for the Resume
- **Active Voice**: Evaluates use of active voice over passive voice
- **Buzzwords & Cliches**: Checks for overuse of industry jargon and cliched phrases

## Output
The command generates an artifact containing a detailed ATS compliance report with:
- Overall compliance score
- Individual category and subcategory scores
- Strengths for each category
- Weaknesses for each category
- Improvement suggestions (if enabled)
- Custom tailoring analysis for each specified job position