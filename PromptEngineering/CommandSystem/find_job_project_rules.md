# Job Search Conversation Rules System
## Project-Specific Rules
- One company per conversation thread (can span multiple conversations).
- Both Full CV and short version of cv are attached to the project as FullCV.tex and joao.cv.2025.short.tex respectively.
- Template Cover Letter is in CoverLetterTemplate.tex.
- Different tex sections should always come in separate snippets and artifacts.
- Always print the entire text block (section, itemization or table) when editing, adding or removing, so it easier to copy paste.

## General Context Information
- Microsoft's Spartans team is an elite engineering team, that accelerates high-priority projects across Microsoft AI org by providing specialized engineering expertise to diverse teams, often joining projects at critical junctures to drive successful outcomes.

## Commands System
Follow global system.
Scope name `project`, i.e., commands should be in the form `project.command [options]`

## Knowledge
`load_knowledge global_conversation_rules_system.md`
`load_knowledge applications_tracking_commands.md`
`load_knowledge company_research_commands.md`
`load_knowledge cover_letter_prep_commands.md`
`load_knowledge cv_optimization_commands.md`
`load_knowledge iterative_cover_letter_tailoring_command.md`
`load_knowledge job_analysis_commands.md`
`load_knowledge networking_commands.md`
`load_knowledge other_interview_prep_commands.md`
`load_knowledge recruiter_call_prep_command.md`
`load_knowledge save_status_command.md`
`load_knowledge setup_interview_prep_command.md`
`load_knowledge study_day_command.md`
`load_knowledge study_session_command.md`
`load_knowledge track_progress_command.md`

Do not assume any of the possible contexts from the loaded files. Instead assume only what comes in the first input prompt. AND, before the response to the first prompt, print the result for the command `commands list_all:true details:all_options,no_details`