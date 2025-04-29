# CV Optimization Commands
SCOPE: project

```
print_cv_plan [options]
```
Plans CV tailoring with options:
- `ats_compliance` - Focus on ATS compliance. Based on the provided Resume. Rewrite it to improve ATS compliance by optmizing format, adding role specific keywords for $job_title, emphasizing metrics-driven achievements. Keep it concise and action-oriented.
- `open_position:$position` - Tailor for specific position
- `open_positions:$list` - Tailor for multiple positions (comma-separated)
- `industry:$industry` - Tailor for specific industry
- `industry_group:$group` - Tailor for industry group
- `job_title` - Tailor for a job title.
- `base_cv:$filename` - CV to use as base, and, if not provided, Defaults to FullCV.tex
- `source:$filesource` - Source of the cv, either `project` for project knowledge or `attachment` for a file attachment, and, if not provided, Defaults to `project`. If `attachment` but no attachment is provided request to upload that.

```
apply_changes
```
Implements approved changes from print_cv_plan

## Response Format for CV Plan
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