# Resume Optimization Commands
SCOPE: project

```
print_resume_plan [options]
```
If more than one job title is provided, the command should generate a single Resume plan that is a combination of the job titles.
Plans Resume tailoring with options:
- `ats_compliance` - Focus on ATS compliance. Based on the provided Resume. Rewrite it to improve ATS compliance by optmizing format, adding role specific keywords for $job_title, emphasizing metrics-driven achievements. Keep it concise and action-oriented.
- `open_position:$position` - Tailor for specific position
- `open_positions:$list` - Tailor for multiple positions (comma-separated)
- `industry:$industry` - Tailor for specific industry
- `industry_group:$group` - Tailor for industry group
- `job_title` - Tailor for a job title.
- `base_resume:$filename` - Resume to use as base, and, if not provided (Defaults: `["main.tex", r"\d\..*\.tex"]`)
- `source:$filesource` - Source of the Resume, either `project` for project knowledge or `attachment` for a file attachment, and, if not provided, Defaults to `project`. If `attachment` but no attachment is provided request to upload that.

```
sort_bullets [options]
```
Sorts bullets in a section for a specific tailoring task.
The bullets should be sorted from most relevant to least relevant for that `job_title` and `is_ai` (if provided).
This command should output one or multiple artifacts with the entire sections.
Remember to keep resume ATS compliance in mind.
If more than one job title is provided, the command should sort the bullets for all job titles jointly, i.e., generating a single Resume aimed for a single position that is a combination or an intermediate of all the job titles listed.

Options:
- `job_title:string` - Job title to tailor for.
- `job_titles:list` - List of job titles to tailor for (comma-separated).
- `section:string|list` - Section or file to sort bullets for (Defaults: all sections).
- `base_resume:string|list` - Resume to use as base, and, if not provided (Defaults: `["main.tex", r"\d\..*\.tex"]`).
- `source:string` - Source of the Resume, either `project` for project knowledge or `attachment` for a file attachment. If `attachment` but no attachment is provided request to upload that. (Defaults: `project`).
- `is_ai:bool` - If true, You should consider that the job position is within an AI company or AI team, not necessarily with AI in the title. (Defaults: `false`).

```
sort_items_within_categories [options]
```
Sorts elements inside each bullet without sorting the bullets themselves. Only works for Skills/Professional Skills section.
This command should output one artifact with the entire section.
Remember to keep resume ATS compliance in mind.
If more than one job title is provided, the command should sort the items within categories for all job titles jointly, i.e., generating a single Resume aimed for a single position that is a combination or an intermediate of all the job titles listed.

Options:
- `job_title:string` - Job title to tailor for.
- `job_titles:list` - List of job titles to tailor for (comma-separated).
- `base_resume:string|list` - Resume to use as base, and, if not provided (Defaults: `["main.tex", r"\d\..*\.tex"]`).
- `source:string` - Source of the Resume, either `project` for project knowledge or `attachment` for a file attachment. If `attachment` but no attachment is provided request to upload that. (Defaults: `project`).
- `is_ai:bool` - If true, You should consider that the job position is within an AI company or AI team, not necessarily with AI in the title. (Defaults: `false`).

```
list_least_relevant_bullets [options]
```
Lists least relevant items in the Skills/Professional Skills section or bullets in a section.
This command should output one artifact with the list of least relevant items.
If section is the Skills/Professional Skills section, the command should sort only the bullets, keeping the elements of the bullets in the same order.
If more than one job title is provided, the command should list the least relevant bullets for all job titles jointly, i.e., generating a single Resume aimed for a single position that is a combination or an intermediate of all the job titles listed.

Options:
- `section:string|list` - Section or file to list least relevant items (Required).
- `n:int` - Number of least relevant items to list (Defaults: `len(section)`).
- `base_resume:string|list` - Resume to use as base, and, if not provided (Defaults: Use a Resume from current context window).
- `source:string` - Source of the Resume, either `project` for project knowledge or `attachment` for a file attachment. If `attachment` but no attachment is provided request to upload that. (Defaults: Use a Resume from current context window).
- `job_title:string` - Job title to tailor for.
- `job_titles:list` - List of job titles to tailor for (comma-separated).
- `is_ai:bool` - If true, You should consider that the job position is within an AI company or AI team, not necessarily with AI in the title. (Defaults: `false`).

```
list_least_relevant_items [options]
```
Lists least relevant items in the Skills/Professional Skills section.
This command should output one artifact with the list of least relevant items.
If more than one job title is provided, the command should list the least relevant items for all job titles jointly, i.e., generating a single Resume aimed for a single position that is a combination or an intermediate of all the job titles listed.

Options:
- `category:string|list` - category or bullet to list least relevant items (Defaults: all categories).
- `mode:merged|multi_list` - If `merged` consider all items in all categories as a single category. Otherwise consider each category separately and list least relevant items for each category separately (Defaults: `merged`).
- `n:int` - Number of least relevant items to list (Defaults: `min(40, len(category))`).
- `base_resume:string|list` - Resume to use as base, and, if not provided (Defaults: Use a Resume from current context window).
- `source:string` - Source of the Resume, either `project` for project knowledge or `attachment` for a file attachment. If `attachment` but no attachment is provided request to upload that. (Defaults: Use a Resume from current context window).
- `job_title:string` - Job title to tailor for.
- `job_titles:list` - List of job titles to tailor for (comma-separated).
- `is_ai:bool` - If true, You should consider that the job position is within an AI company or AI team, not necessarily with AI in the title. (Defaults: `false`).

```
suggest_text_improvements [options]
```
* Suggests improvements for the Resume within the context of a specific job title and is_ai and within the context of each bullet text or item text in a section, i.e., sorting, adding, and removing items are not permitted.
* Use placeholders for possibler values to add to the text.
* If multiple improvements are suggested for the same text, print them all separated by a new line.
* If more than one job title is provided, the command should suggest improvements for all job titles jointly, i.e., generating a single Resume aimed for a single position that is a combination or an intermediate of all the job titles listed.
* Remember to keep resume ATS compliance and best practices in mind.
* Use placeholders for information not present in the Resume instead of inventing new information or allucinating information.
* Remember to keep the text concise and to the point.
* Remember to avoid becoming repetitive and too verbose.
* Preserve authenticity and avoid becoming too promotional.
* If the text is already good, just say "No improvements needed".
* If the text is not relevant to the job title, just say "Not relevant to the job title" or remove it.
* If the text is not relevant to the is_ai, just say "Not relevant to the is_ai" or remove it.
* If the text is not relevant to the section, just say "Not relevant to the section" or remove it.

Example:
```
\item \small{Diagnosed complex distributed system failures, reducing mean time to resolution for critical production incidents}
.....
\item \small{Applied structured root cause analysis techniques ([Techniques used]) to diagnose complex distributed system failures, reducing mean time to resolution by [Time or time percentage reduction] for critical production incidents}
```

Options:
- `job_title:string` - Job title to tailor for.
- `job_titles:list` - List of job titles to tailor for (comma-separated).
- `base_resume:string|list` - Resume to use as base, and, if not provided (Defaults: Use a Resume from current context window).
- `source:string` - Source of the Resume, either `project` for project knowledge or `attachment` for a file attachment. If `attachment` but no attachment is provided request to upload that. (Defaults: Use a Resume from current context window).
- `section:string|list` - Section or file to suggest improvements for (Defaults: all sections).
- `is_ai:bool` - If true, You should consider that the job position is within an AI company or AI team, not necessarily with AI in the title. (Defaults: `false`).

```
apply_changes
```
Implements approved changes from print_resume_plan and suggest_improvements.

```
tailor_to_fit_space [options]
```
Tailors the Resume to fit the space available. Basically rewording and removing items to fit the space.
This command should be iterative, i.e., it should be called multiple times to fit the Resume to the space available.

Options:
- `base_resume:string|list` - Resume to use as base, and, if not provided (Defaults: Use a Resume from current context window).
- `source:string` - Source of the Resume, either `project` for project knowledge or `attachment` for a file attachment. If `attachment` but no attachment is provided request to upload that. (Defaults: Use a Resume from current context window).
- `current_state:string` - Description of the current state of the Resume and the compiled pdf, e.g., how long is each sections, where it gets cut off, etc.
- `goal:string` - Goal of the tailoring, e.g., `fit_2_pages`, `fit_1_page`, `fit_1_page_short`, `fit_1_page_long`, `fit_1_page_short_long`, `fit_1_page_long_short`.
- `job_title:string` - Job title to tailor for.
- `job_titles:list` - List of job titles to tailor for (comma-separated) (Defaults: Use job_titles from current context window).
- `section:string|list` - Section or file to suggest improvements for (Defaults: all sections).

```
find_repetitions [options]
```
Finds words with repetitions in the Resume. Outputs a list of words and the number of times they appear in the Resume and in the same bullet when applicable.

Options:
- `base_resume:string|list` - Resume to use as base, and, if not provided (Defaults: Use a Resume from current context window).
- `source:string` - Source of the Resume, either `project` for project knowledge or `attachment` for a file attachment. If `attachment` but no attachment is provided request to upload that. (Defaults: Use a Resume from current context window).
- `section:string|list` - Section or file to count words for (Defaults: all sections).
- `max_length:int` - max length of the list of words (Defaults: 1000).
- `threshold:int` - Threshold for word repetitions, below that value the word is not considered (Defaults: 4).
- `threshold_same_bullet:int` - Threshold for word repetitions for same bullet, below that value the word is not considered (Defaults: 2).

## Response Format for Resume Plan
```
# $SectionName1
Edits
#1. $Edit1
...
#n. $EditN

 Additions
#n+1. $Addition1
...
#n+m. $AdditionM

 Removals
#n+m+1. $Removal1
...
#n+m+j. $RemovalJ

# $SectionName2
...
```