# `study_day` Command Documentation
SCOPE: project

## Purpose
The `study_day` command provides a structured overview of the learning topics scheduled for a specific day in your Anthropic interview preparation plan. It helps you organize your study sessions and generates the appropriate sequence of `study_session` commands for that day.

## Basic Syntax
```
study_day day:<day_number> [breakdown:<true|false>]
```

## Parameters

| Parameter | Description | Required | Example Values |
|-----------|-------------|----------|---------------|
| `day` | Day number from the 9-day preparation plan | Yes | `1` through `9` |
| `breakdown` | Whether to show detailed subtopics | No | `true`, `false` (default: `true`) |

## Examples

### Get overview of Day 1 study plan
```
study_day day:1
```

### Get Day 3 plan without detailed breakdowns
```
study_day day:3 breakdown:false
```

## Behavior

When executed, the command will:

1. Display the overall focus and learning objectives for the specified day
2. List the main topics to be covered in morning and afternoon sessions
3. Generate ready-to-copy `study_session` commands for each scheduled topic
4. If `breakdown:true`, also provide subtopic details and time allocations
5. Include any recommended preparation or follow-up activities
6. Show your current progress on the day's topics if you've started them

## Day Overview Content

For each day, the output includes:

1. **Day Summary**: Overall theme and learning goals
2. **Schedule**: Breakdown of morning and afternoon sessions
3. **Topics Overview**: Description of main topics
4. **Ready-to-Use Commands**: Copy-pastable commands to start each session
5. **Preparation Tips**: Recommended actions before starting
6. **Resources**: Specific materials/websites to reference
7. **Progress Tracking**: Completion status of topics/subtopics

## Related Commands

- `study_session` - Start a study session on a specific topic
- `track_progress` - View your overall preparation progress
- `setup_day` - Configure a custom day schedule if needed
- `review_day` - Get a summary of what you've completed in a previous day