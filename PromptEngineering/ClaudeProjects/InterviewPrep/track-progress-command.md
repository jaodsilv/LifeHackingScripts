# `track_progress` Command Documentation
SCOPE: project

## Purpose
The `track_progress` command provides a visual representation of your progress through the an study plan. It allows you to monitor completion status across all areas, topics, and subtopics, helping you identify knowledge gaps that need more attention. If no preparation name is provided, it will show the progress of all preparations.

## Basic Syntax
```
track_progress <preparation_name> [day:<day_number>] [topic:<topic_name>] [format:<display_type>] [focus:<focus_area>] [since:<date>]
```

## Parameters

| Parameter | Description | Required | Example Values |
|-----------|-------------|----------|---------------|
| `preparation_name` | Filter to show only a specific preparation | No | `Anthropic`, `Amazon`, `Meta`, `TechnicalInterviews`, `AwsCertification`, `SystemArchitecture`, `FullStack` |
| `day` | Filter to show only a specific day | No | `1` through `9` |
| `topic` | Filter to show only a specific topic | No | `python_fundamentals`, `refactoring` |
| `format` | Change the display format | No | `chart`, `text`, `detailed`, `timeline` (default: `chart`) |
| `focus` | Highlight areas needing attention | No | `gaps`, `strengths`, `recent`, `upcoming` |
| `since` | Show progress since date | No | `yesterday`, `last_week`, `2024-03-15` |
| `compare` | Compare with another timepoint | No | `yesterday`, `last_week`, `start` |

## Examples

### View overall progress across all days
```
track_progress TechnicalInterviews
```

### Check progress on a specific day
```
track_progress TechnicalInterviews day:3
```

### See detailed status of a specific topic
```
track_progress TechnicalInterviews topic:data_structures format:detailed
```

### Highlight knowledge gaps
```
track_progress TechnicalInterviews focus:gaps
```

### See progress over last week
```
track_progress TechnicalInterviews since:last_week format:timeline
```

### Compare with earlier progress
```
track_progress TechnicalInterviews compare:start
```

## Behavior

When executed, the command will:

1. Retrieve your saved progress information
2. Generate a visual representation based on the requested format
3. Show completion percentages for days, topics, and subtopics
4. Highlight areas that need attention
5. Provide recommendations for next study sessions based on progress
6. Display time spent on each topic if available
7. Identify knowledge gaps requiring additional focus
8. Show progress trends over time if comparison requested
9. Suggest optimal study schedule based on your progress patterns

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

### Timeline Format
Shows progress over time with daily/weekly improvements:

```
Python Fundamentals Progress:
Week 1: [██████░░░░] 60%
Week 2: [████████░░] 80% (+20%)
Week 3: [██████████] 100% (+20%)

Data Structures Progress:
Week 1: [██░░░░░░░░] 20%
Week 2: [████░░░░░░] 40% (+20%)
Week 3: [██████░░░░] 60% (+20%)
```

## Focus Areas

When using the `focus` parameter:

### Gaps
Highlights areas with lowest completion percentages:

```
Priority Focus Areas:
1. Data Structures - Practice Problems [0%]
2. Algorithms - Complexity Analysis [20%]
3. Testing - Integration Testing [30%]
```

### Strengths
Shows areas with highest proficiency:

```
Your Strongest Areas:
1. Python Fundamentals [100%]
2. OOP - Classes [90%]
3. Error Handling [85%]
```

### Recent
Shows recently studied topics:

```
Recently Studied:
1. Data Structures (Yesterday, 45m)
2. Algorithms (2 days ago, 1h 30m)
3. Testing (3 days ago, 1h)
```

### Upcoming
Suggests topics to study next based on progress patterns and plan:

```
Recommended Next Topics:
1. Data Structures - Practice Problems
2. Algorithms - Optimization Techniques
3. Testing - Integration Testing
```

## Progress Data Storage

Your progress data is saved in the conversation context and can be accessed across multiple chat sessions. The system tracks:

- Completion status of each topic and subtopic
- Time spent on each study session
- Last accessed timestamp
- Notes or areas of difficulty (if provided)
- Progress trends over time
- Common knowledge gaps across topics

## Related Commands

- `save_status` - Manually update your progress on a specific topic
- `study_session` - Start a study session that will automatically update progress
- `reset_progress` - Clear progress data (use with caution)
- `export_progress` - Generate a downloadable report of your progress
- `weekly_plan` - Generate weekly priority action list based on progress
- `dashboard` - Display comprehensive job search and study overview


```
weekly_plan
```
Generates weekly priority action list

```
dashboard
```
Displays comprehensive job search overview
