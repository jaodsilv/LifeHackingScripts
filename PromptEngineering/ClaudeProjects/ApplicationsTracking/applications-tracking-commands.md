# Application Tracking Commands
SCOPE: project

```
deadline [action]
```
Manages application deadlines:
- `set_main_deadline date:YYYY-MM-DD reason:$text` - Sets main deadline
- `add_company company:$name deadline:YYYY-MM-DD notes:$text` - Adds company deadline
- `list` - Shows all deadlines chronologically
- `urgent` - Shows deadlines within 2 weeks
- `calculate_timeline company:$name process:$time_estimate` - Creates timeline

```
application_status [action]
```
Tracks application status:
- `add company:$name position:$title status:$stage [date:YYYY-MM-DD] [notes:$text] [contact:$name] [priority:$priority] [url:$url] [as_artifact] [export] [save] [load_from_attachment]` - Adds/updates application and generates a mneumonic unique id (checking project files for possible conflicts)
- `parse_from_attachment [file_name:$file_name] [as_artifact] [export] [save] [format:$format] [action_on_conflict:$action_on_conflict] [action_on_missing:$action_on_missing] [action_on_error:$action_on_error] [action_on_success:$action_on_success]` - Parses application from attachment
- `list [filter:$filter] [format:$format] [sort:$sort] [details:$details] [as_artifact] [export] [save] [load]` - Shows all applications
- `company company:$name [filter:$filter] [format:$format] [sort:$sort] [details:$details] [as_artifact] [export] [save] [load]` - Shows applications for specific company
- `active [filter:$filter] [format:$format] [sort:$sort] [details:$details] [as_artifact] [export] [save] [load]` - Shows active applications
- `export goal:<print,project> [format:$format] [as_artifact]` - Generates exportable summary to export to project folder or to a printable format
- `priority [filter:$filter] [format:$format] [sort:$sort] [details:$details] [as_artifact] [export] [save] [load]` - Shows priority applications

```
weekly_plan
```
Generates weekly priority action list

```
dashboard [parameters]
```
Displays comprehensive job search overview:
- `filter:$filter` - Filters applications
- `format:$format` - Format of the output
- `sort:$sort` - Sort applications by
- `details:$details` - Details to display
- `as_artifact` - Save as artifact
- `export` - Export to project folder
- `print` - Generates printable format
- `save` - Save to project folder

```
suggest_actions
```
Suggests actions based on application status:
- `apply_to_company company:$name position:$title [context:$context]` - Evaluates if applying to a company is a good idea
- `follow_up company:$name position:$title [context:$context]` - Evaluates if follows up on an application is a good idea
- `prepare_interview company:$name position:$title [context:$context]` - Suggest what to do to prepare for an interview
- `update_resume context:$context` - Suggest what to do to update resume
- `network_event context:$context` - Suggest what to do to attend a networking event or suggest events to attend
- `job_search_strategy context:$context` - Evaluates if the job search strategy is working, suggest changes if needed, or suggest new strategies

In case no option is provided, evaluate the current status and suggest best actions.

## Application Status Stages
- `preparing` - Materials in preparation
- `applied` - Application submitted
- `screening` - Initial screening (HR/phone)
- `interview` - Interview scheduled
- `technical` - Technical assessment
- `onsite` - Onsite/final interviews
- `offer` - Offer received
- `negotiation` - Negotiating terms
- `accepted` - Offer accepted
- `rejected` - Application rejected
- `withdrawn` - Application withdrawn
