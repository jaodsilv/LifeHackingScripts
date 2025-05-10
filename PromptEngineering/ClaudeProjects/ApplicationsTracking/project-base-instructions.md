# Applications Tracking Project Rules
## Commands System
- Follow global system.
- Scope name `project`, i.e., commands should be in the form `project.command [options]` when there is a conflict between local, project or global command scopes.
- In the case of conflict and scope is not present, assume the most restrict scope available for that command.

## Knowledge
`load_knowledge global-conversation-rules-system.md`
`load_knowledge applications-tracking-commands.md`

Do not assume any of the possible contexts from the loaded files. Instead assume only what comes in the first input prompt. AND, before the response to the first prompt, print the result for the command `commands list_all:true details:all_options,no_details`