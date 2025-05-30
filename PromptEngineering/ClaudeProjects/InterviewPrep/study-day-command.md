# `study_day` Command Documentation
SCOPE: project

## Purpose
The `study_day` command provides a structured overview of the learning topics scheduled for a specific day in your custom interview preparation plan. It helps you organize your study sessions and generates the appropriate sequence of `study_session` commands for that day.

## Basic Syntax
```
study_day preparation_plan_name day:<day_number> [breakdown:<true|false>] [focus:<focus_area>] [time_available:<minutes>]
```

## Parameters

| Parameter | Description | Required | Example Values |
|-----------|-------------|----------|---------------|
| `preparation_plan_name` | Name of the preparation plan | Yes | `Anthropic` |
| `day` | Day number from the 9-day preparation plan | Yes | `1` through `9` |
| `breakdown` | Whether to show detailed subtopics | No | `true`, `false` (default: `true`) |
| `focus` | Area to emphasize in the study plan | No | `technical`, `behavioral`, `system_design`, `weak_areas` |
| `time_available` | Total study time available for the day | No | `60`, `120`, `240` (in minutes) |
| `include_exercises` | Whether to include practice exercises | No | `true`, `false` (default: `true`) |
| `interview_date` | Date of upcoming interview | No | `tomorrow`, `next_week`, `2024-04-15` |

## Examples

### Get overview of Day 1 study plan
```
study_day Anthropic day:1
```

### Get Day 3 plan without detailed breakdowns
```
study_day Anthropic day:3 breakdown:false
```

### Create a time-constrained study plan focusing on technical topics
```
study_day Anthropic day:2 focus:technical time_available:120
```

### Prepare for an upcoming interview
```
study_day Anthropic day:5 focus:weak_areas interview_date:tomorrow
```

## Behavior

When executed, the command will:

1. Display the overall focus and learning objectives for the specified day
2. List the main topics to be covered in morning and afternoon sessions
3. Generate ready-to-copy `study_session` commands for each scheduled topic
4. If `breakdown:true`, also provide subtopic details and time allocations
5. Include any recommended preparation or follow-up activities
6. Show your current progress on the day's topics if you've started them
7. Adjust the plan if a time constraint is specified
8. Prioritize topics based on focus area and upcoming interviews
9. Include quick review materials for previously studied topics
10. Generate a printer-friendly schedule for offline reference

## Focus Areas

When specifying a focus area:

### Technical
Emphasizes coding and algorithm topics:
- Data structures
- Algorithms
- Problem-solving
- Language-specific features
- Time complexity

### Behavioral
Focuses on interpersonal and soft skill preparation:
- STAR method practice
- Leadership examples
- Conflict resolution
- Teamwork scenarios
- Communication skills

### System Design
Concentrates on architecture and design skills:
- Requirements gathering
- Component design
- Scaling considerations
- Database choices
- API design

### Weak Areas
Prioritizes topics with low confidence scores:
- Previously difficult topics
- Incomplete exercises
- Low-confidence ratings
- Areas needing review
- Interview-critical topics

## Day Overview Content

For each day, the output includes:

1. **Day Summary**: Overall theme and learning goals
2. **Schedule**: Breakdown of morning and afternoon sessions
3. **Topics Overview**: Description of main topics
4. **Ready-to-Use Commands**: Copy-pastable commands to start each session
5. **Preparation Tips**: Recommended actions before starting
6. **Resources**: Specific materials/websites to reference
7. **Progress Tracking**: Completion status of topics/subtopics
8. **Time Allocation**: Suggested time to spend on each topic
9. **Interview Relevance**: How topics relate to common interview questions
10. **Review Suggestions**: Quick reviews of previous days' materials

## Time Management Features

When `time_available` is specified:
- Topics are prioritized based on importance and your progress
- Session durations are adjusted to fit within the available time
- Essential topics are preserved while optional ones may be shortened
- Review material is condensed for efficiency
- Study commands include optimal time allocations

## Related Commands

- `study_session` - Start a study session on a specific topic
- `track_progress` - View your overall preparation progress
- `setup_day` - Configure a custom day schedule if needed
- `review_day` - Get a summary of what you've completed in a previous day
- `weekly_plan` - Generate a full week study schedule
- `interview_readiness` - Assess your preparation for upcoming interviews