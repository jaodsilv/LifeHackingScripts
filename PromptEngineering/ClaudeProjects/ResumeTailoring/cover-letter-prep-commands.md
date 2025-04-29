# Cover Letter Preparation Commands
SCOPE: project

```
print_coverletter_plan [options]
```
Plans a compelling cover letter that highlights skills relevant to the role. Keep it's body within 200 words and make it sound passionate yet professional.Options are:
- `company:$value` - Company name
- `position:$value` - Position applying for (reference only)
- `position_name:$value` - Position title to include
- `manager_name:$value` - Hiring manager's name
- `manager_title:$value` - Hiring manager's title
- `source:$value` - How you found the position
- `product:$value` - Company product to reference
- `reason:$value` - Specific reason for interest
- `relevant_technology:$value` - Relevant tech to highlight
- `team_name:$value` - Team name
- `custom_$blockname:$value` - Custom paragraph content
- `cv:$value` - CV to use as base, and, if not provided, Defaults to joao.cv.2025.short.tex
- `cv_source:$value` - Source of the cv, either `project` for project knowledge or `attachment` for a file attachment, and, if not provided, Defaults to `project`. If `attachment` but no attachment is provided request to upload that.

```
execute_coverletter_plan [options]
```
Execute the plan above and create an artifact with the cover letter tex content.


```
is_ats_compliant [options]
```
Evaluates to which degree a CV is ATS compliant.
Evaluate giving a percentage rate on the following categories and subcategories:
- Tailoring
    - Hard Skills
    - Soft Skills
- Content
    - ATS Parse Rate
    - Quantifying Impact
    - Repetition/Redundancy
    - Spelling & Grammar
- Format
    - File Format & Size
    - Resume Length
    - Long Bullet Points
- Sections
    - Contact Information
    - Essential Sections
    - Personality
- Style
    - Design
    - Email Address
    - Active Voice
    - Buzzwords & Cliches

Options are:
- `base_cv:$filename` - CV to use as base, and, if not provided, defaults to joao.cv.2025.short.tex
- `source:$filesource` - Source of the cv, either `project` for project knowledge or `attachment` for a file attachment, and, if not provided, Defaults to `project`. If `attachment` but no attachment is provided request to upload that. `attachment` can come from a previous message.
- `open_positions:$list` - Tailor for multiple positions (comma-separated). Defaults to ["Senior Backend Software Engineer"].
- `category:$categories` - Which categories or aspects to evaluate. If not provided use all categories listed above.
