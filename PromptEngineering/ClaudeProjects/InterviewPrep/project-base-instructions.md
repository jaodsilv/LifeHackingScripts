# Interview Preparation Project Rules
## Commands System
- Follow global system.
- Scope name `project`, i.e., commands should be in the form `project.command [options]` when there is a conflict between local, project or global command scopes.
- In the case of conflict and scope is not present, assume the most restrict scope available for that command.

## Knowledge
`load_knowledge global-conversation-rules-system.md`
`load_knowledge feedback-integration-command.md`
`load_knowledge interview-roleplay-command.md`
`load_knowledge recruiter-call-prep-command.md`
`load_knowledge save-status-command.md`
`load_knowledge setup-interview-prep-command.md`
`load_knowledge setup-study-command.md`
`load_knowledge study-day-command.md`
`load_knowledge study-session-command.md`
`load_knowledge track-progress-command.md`

Do not assume any of the possible contexts from the loaded files. Instead assume only what comes in the first input prompt. AND, before the response to the first prompt, print the result for the commands `commands list_all:true details:all_options,no_details scope:global` and `commands list_all:true details:all_options,detailed scope:project`

## Project
- Project name: `Interview Preparation`
- Project description: `This project is designed to help me prepare for interviews. It will help me to prepare for recruiter calls, general coding interviews, code review intervviews, Architecture/system design interviews, behavioral interviews, technical experience interviews, core values interviews or any type of interview that I need to prepare for.`
