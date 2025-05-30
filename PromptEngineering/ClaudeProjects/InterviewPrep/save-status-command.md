# `save_status` Command Documentation
SCOPE: project

## Purpose
The `save_status` command allows me to manually update and save my progress on specific topics or subtopics in my tailored courses plan. This is particularly useful when continuing study sessions across different chat windows or when I want to mark topics as complete outside of a formal study session.

## Basic Syntax
```
save_status <parameters>
```

## Parameters

| Parameter    | Description                                                   | Required | Example Values                                                                     |
|--------------|---------------------------------------------------------------|----------|------------------------------------------------------------------------------------|
| `topic`      | Path of the course or lesson being updated.                   | Yes*     | `python.fundamentals`, `software_engineering.refactoring.common_cases.exercises`   |
| `course_id`  | Id of the course, a shortcut to the `topic` parameter format. | Yes*     |  `ML12LD`, `TF26DL`                                                                |
| `complete`   | Completion status.                                            | Yes      | `true`, `false`, `partial`, `3/17`, `30%`                                          |
| `time_spent` | Minutes spent studying.                                       | No       | Any positive integer                                                               |
| `notes`      | Brief notes about progress.                                   | No       | Text (use quotes for multi-word notes)                                             |
| `confidence` | Confidence level in the topic                                 | No       | `low`, `medium`, `high`                                                            |
| `priority`   | Personal priority for review                                  | No       | `low`, `medium`, `high`                                                            |
| `review_date`| Suggested date for review                                     | No       | `tomorrow`, `next_week`, `2024-04-15`                                              |
| `difficulty` | How difficult you found the material                          | No       | `easy`, `moderate`, `hard`                                                         |

Either `course_id` or `topic` must be present or it should be possible to infer from the context.

## Examples

### Mark a topic as complete
```
save_status topic:day_1.python_fundamentals complete:true time_spent:120
```

### Update a specific subtopic or lesson with notes
```
save_status topic:day_3.refactoring.clean_code complete:partial time_spent:45 notes:"Completed exercises 1-3, need to review exercise 4"
```

### Mark something as incomplete (to revisit later)
```
save_status topic:week_2.algorithms.complexity_analysis complete:5/17 notes:"Need more practice with space complexity analysis"
```

### Track confidence and set review date
```
save_status topic:day_2.data_structures complete:true confidence:medium priority:high review_date:next_week
```

### Record difficulty and notes for interview topics
```
save_status topic:behavioral_interviews.conflict_resolution complete:true difficulty:hard notes:"Need more specific examples from past experience"
```

## Behavior

When executed, the command will:

1. Validate that the specified day/topic/subtopic combination exists in the plan
2. Update my progress information in an Artifact
3. Provide confirmation of the update
4. Show my current overall progress
5. Offer recommendations for what to study next
6. Update any related progress visualization
7. Schedule reviews based on confidence and priority settings
8. Create spaced repetition recommendations for difficult topics
9. Link related interview preparation materials for weak areas

## Status Values

- `true` - Topic/subtopic is fully completed
- `false` - Topic/subtopic has not been started or needs to be reset
- `partial` - Topic/subtopic has been partially completed
- `m/n` - Topic/subtopic had `m` lessons complete out of `n` lessons total
- `30%` - Topic/subtopic had `30%` of the lesson complete out of `100%` lessons total

## Additional Tracking

### Confidence Levels
Tracks your comfort with the material:
- `low` - Need significant review
- `medium` - Understand basics but need practice
- `high` - Comfortable and ready for interview

### Priority Settings
Determines focus areas for review:
- `low` - Can revisit if time permits
- `medium` - Should review before interviews
- `high` - Critical area needing immediate focus

### Difficulty Tracking
Records challenging topics for extra attention:
- `easy` - Comfortable with minimal review
- `moderate` - Requires regular practice
- `hard` - Needs intensive focus and multiple reviews

## Progress Data Management

The system maintains a hierarchical structure of my progress and course configuration from Learning Program to Lessons (If available) and all of them associated with a lowercase [id] that is unique within their tree siblings, e.g.:

```
Python Programming [py] [5 / 13] (Program Name followed by its id and its progress)
  └─ Python Fundamentals [fu] (course)
      ├─ Syntax Refresher [sy] [5 / 15] (course without lessons available to you followed by a progress)
      ├─ Built-in Data Types [ty] [0 / 2] (subtopic with child courses)
      |   └─ Python Custom Types [cu] (course)
      |       ├─ Theory [th] (Lesson)
      |       └─ Exercises [ex] (Lesson)
      └─ List/Dict Comprehensions (subtopic or lesson or course)
```

When I mark a topic as complete, all its subtopics are automatically marked complete unless explicitly specified otherwise.

## Spaced Repetition Integration

The system uses your confidence, priority, and difficulty ratings to create an optimal review schedule:
- High-priority, low-confidence topics are scheduled for immediate review
- Difficult topics follow a more frequent review pattern
- Topics marked as easy with high confidence have longer intervals between reviews

## Persistence Across Sessions

My status data is preserved in the conversation context and can be accessed in future chat sessions. To maintain continuity across multiple chat windows:

1. Use `save_status` at the end of each study session
2. Begin new sessions with a `track_progress` command to verify my saved state
3. Use `study_session` with the `status:continue` parameter to resume

## Related Commands

- `track_progress` - View my current progress
- `study_session` - Start a study session (automatically updates progress)
- `reset_status` - Clear progress data for a specific topic
- `export_status` - Generate a downloadable report of my progress
- `review_schedule` - See your upcoming topic review schedule
- `practice_weak_areas` - Focus on low-confidence topics
- `interview_readiness` - Assess interview preparedness by topic