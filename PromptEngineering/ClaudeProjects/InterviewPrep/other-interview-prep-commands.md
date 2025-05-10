# Interview Preparation Commands
SCOPE: project

```
feedback_integration [options]
```
Applies feedback to materials:
- `feedback:$text` - Feedback received
- `target:$cv_or_letter` - Where to apply feedback

```
interview_prep [options]
```
Simplified and more generic version of the command `setup_interview_prep` that only creates practice questions:
- `position:$title` - Position title
- `focus:$area` - Question focus (technical/behavioral/both)

```
interview_roleplay [job_title|industry] [company_name:$value] [skills]
```
Pretend to be a recruiter for [Job Title/Industry][ at [company name]]. Ask me 5 common interview questions related to [specific skills or responsabilities]. Evalluate my answers based on STAR format (Situation, Task, Action, Result) and provide actionable feedback to improve.
Options:
- `job_title`: Job title.
- `industry`: Industry.
- `company_name`: Optional company name
- `skills`: selections of skills
