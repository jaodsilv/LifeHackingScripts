# `track_progress` Command Documentation
SCOPE: project

## Purpose
The `track_progress` command provides a visual representation of your progress through the an study plan. It allows you to monitor completion status across all areas, topics, and subtopics, helping you identify knowledge gaps that need more attention.

## Basic Syntax
```
track_progress [day:<day_number>] [topic:<topic_name>] [format:<display_type>]
```

## Parameters

| Parameter | Description | Required | Example Values |
|-----------|-------------|----------|---------------|
| `day` | Filter to show only a specific day | No | `1` through `9` |
| `topic` | Filter to show only a specific topic | No | `python_fundamentals`, `refactoring` |
| `format` | Change the display format | No | `chart`, `text`, `detailed` (default: `chart`) |

## Examples

### View overall progress across all days
```
track_progress
```

### Check progress on a specific day
```
track_progress day:3
```

### See detailed status of a specific topic
```
track_progress topic:data_structures format:detailed
```

## Behavior

When executed, the command will:

1. Retrieve your saved progress information
2. Generate a visual representation based on the requested format
3. Show completion percentages for days, topics, and subtopics
4. Highlight areas that need attention
5. Provide recommendations for next study sessions based on progress
6. Display time spent on each topic if available

## Display Formats

### Chart Format (default)
Displays a graphical representation using progress bars or completion indicators:

```
Day 1: Python Fundamentals & Data Structures [████████░░] 80%
  ├─ Python Fundamentals [██████████] 100%
  │   ├─ Syntax Refresher [██████████] 100%
  │   ├─ Built-in Data Types [██████████] 100%
  │   └─ List/Dict Comprehensions [██████████] 100%
  └─ Data Structures [██████░░░░] 60%
      ├─ Collections Module [██████████] 100%
      ├─ Custom Data Structures [██████████] 100%
      └─ Practice Problems [░░░░░░░░░░] 0%
```

### Text Format
Provides a simple text-based summary of completion status:

```
Day 1: 80% complete (4/5 subtopics)
Day 2: 50% complete (3/6 subtopics)
...
```

### Detailed Format
Shows comprehensive information including time spent and last accessed:

```
Topic: Data Structures
Total Completion: 60% (3/5 subtopics)
Total Time Spent: 3h 45m

Subtopics:
1. Collections Module
   Status: Complete
   Time Spent: 45m
   Last Accessed: Mar 30, 2025, 10:30 AM

2. Custom Data Structures
   Status: Complete
   Time Spent: 1h 15m
   Last Accessed: Mar 30, 2025, 11:45 AM
...
```

## Progress Data Storage

Your progress data is saved in the conversation context and can be accessed across multiple chat sessions. The system tracks:

- Completion status of each topic and subtopic
- Time spent on each study session
- Last accessed timestamp
- Notes or areas of difficulty (if provided)

## Related Commands

- `save_status` - Manually update your progress on a specific topic
- `study_session` - Start a study session that will automatically update progress
- `reset_progress` - Clear progress data (use with caution)
- `export_progress` - Generate a downloadable report of your progress


```
weekly_plan
```
Generates weekly priority action list

```
dashboard
```
Displays comprehensive job search overview
