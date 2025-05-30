# `setup_study` Command Documentation
SCOPE: project

## Purpose
The `setup_study` command configures a customized preparation plan for technical interviews at specific companies or for particular assessment formats or any learning reason. This allows you to create targeted study plans beyond the default preparation. This command must generate an artifact that can exported to the project folder and be used by the `study_day` command.

## Basic Syntax
```
setup_study topic [parameters]
```

## Parameters

| Parameter | Description | Required | Example Values | Default Value |
|-----------|-------------|----------|----------------|---------------|
| `preparation_plan_name` | Name of the preparation plan | Yes | `Anthropic`, `Google`, `Amazon`, `Meta` | `None` |
| `topic` | Topic to Learn | Yes | `Django`, `behavioral_interviews`, `JavaScript` | `None` |
| `start_level` | Initial level of knowledge about the topic | No | `beginner`, `advanced`, `proficient` | `beginner` |
| `constraints` | Other constraints consideration for when writing the document | No | `I am proficient in Go already` | `None` |
| `depth` | How deep should the learning go | No | `certification`, `know_all`, `proficient`, `basics` | `one_level_deeper_than_start_level` |
| `length` | Length of the document in expected time to read | No | `10min`, `1h` | `flexible` |
| `exercises` | Exercises format | No | `in_artifact`, `external_url_codesignal`, `external_url_hackerrank`, `external_url_neet_code` | `in_artifact` |
| `timeline` | Same as `length`, but specifically in Preparation days | No | Any positive integer | `None` |
| `start_date` | When to begin | No | Date in YYYY-MM-DD format | `None` |
| `interview_date` | Target interview date | No | Date in YYYY-MM-DD format | `None` |
| `priority_skills` | Skills to emphasize | No | `problem_solving`, `communication`, `coding_speed`, `design` | `None` |
| `resources_preference` | Preferred learning resources | No | `visual`, `text`, `interactive`, `practical` | `balanced` |
| `study_pattern` | Preferred study schedule | No | `daily_short`, `fewer_longer`, `weekends_focus` | `daily_balanced` |
| `mock_interviews` | Include mock interviews | No | `true`, `false`, `weekly` | `false` |
| `skill_check_frequency` | How often to evaluate progress | No | `daily`, `weekly`, `end_only` | `weekly` |

## Examples

### Basic Usage
```bash
# Basic setup for learning Django. In this case you should suggest the topics and subtopics to study, ideal timeline and exercises format.
setup_study Django
```

```bash
# Setup with specific start level
setup_study AnthropicInterviewPrep topic:Python start_level:advanced
```

```bash
# Setup with depth specification
setup_study Python depth:certification
```

### Company-Specific Preparation without a topic, but a description of the preparation
```bash
# Google interview preparation
setup_study GoogleInterviewPrep exercises:external_url_leetcode timeline:30
```

```bash
# Amazon interview preparation with leadership focus
setup_study AmazonInterviewPrep constraints:"I need to focus on leadership principles" length:2h
```

```bash
# Meta preparation with specific start date
setup_study MetaInterviewPrep start_date:2024-04-01 timeline:45
```

### Assessment Format Examples
```bash
# CodeSignal assessment preparation
setup_study TechnicalInterviewsPrep topic:CodeSignal exercises:external_url_codesignal length:1h
```

```bash
# System design interview preparation
setup_study TechnicalInterviewsPrep topic:SystemDesign depth:know_all exercises:in_artifact
```

```bash
# Live coding interview preparation
setup_study TechnicalInterviewsPrep topic:LiveCoding constraints:"I need practice with verbal communication" length:30min
```

### Multi-Topic Preparation
```bash
# Full-stack preparation
setup_study AnthropicInterviewPrep topic:FullStack start_level:beginner depth:proficient timeline:60
```

```bash
# Data structures and algorithms
setup_study AnthropicInterviewPrep topic:DSA exercises:external_url_neetcode constraints:"I am weak in graph algorithms"
```

```bash
# Behavioral interview preparation
setup_study BehavioralInterviewsPrep topic:BehavioralInterviews length:45min exercises:in_artifact
```

### Customized Learning Paths
```bash
# Quick certification preparation
setup_study AwsCertification topic:AWS depth:certification timeline:14 start_date:2024-03-15
```

```bash
# In-depth system architecture study
setup_study AnthropicInterviewPrep topic:SystemArchitecture depth:know_all length:2h exercises:in_artifact
```

```bash
# Focused debugging skills
setup_study AnthropicInterviewPrep topic:Debugging start_level:proficient constraints:"Focus on production debugging"
```

### Time-Sensitive Interview Preparation
```bash
# Rapid preparation for upcoming interview
setup_study GoogleInterviewPrep topic:Algorithms interview_date:2024-04-20 priority_skills:problem_solving,coding_speed
```

```bash
# Weekend-focused study plan
setup_study AmazonInterviewPrep topic:SystemDesign study_pattern:weekends_focus timeline:30
```

```bash
# Comprehensive preparation with mock interviews
setup_study MicrosoftInterviewPrep topic:FullStackDev mock_interviews:weekly skill_check_frequency:daily
```

## Behavior

When executed, the command will:

1. Generate a customized preparation plan based on the specified topic and length
2. Create a day-by-day schedule optimized for your parameters if `timeline` is present
3. Highlight company-specific focus areas and question patterns
4. Provide relevant resources and practice materials
5. Configure the `study_day` and `study_session` commands for this plan
6. Create a parallel tracking system for this specific preparation
7. For company interview preparations do some ressearch on how is their interview prior to writing the study document
8. Adjust the schedule based on interview date if provided
9. Incorporate priority skills into the learning path
10. Generate study materials matching your resource preferences
11. Structure the plan according to your study pattern choice
12. Schedule mock interviews at appropriate intervals if requested
13. Create skill check assessments at the specified frequency

## Study Patterns

The command can adapt to your preferred learning style:

### Daily Balanced (Default)
- 1-2 hours of study per day
- Mix of theory and practice
- Consistent daily schedule
- Balanced topic distribution

### Daily Short
- 30-45 minutes daily
- Focused, high-priority content
- Spaced repetition emphasis
- Quick reference materials

### Fewer Longer
- 2-3 sessions per week
- 3-4 hours per session
- Deep dive into topics
- Extensive practice exercises
- Comprehensive reviews

### Weekends Focus
- Light weekday activities (30min)
- Intensive weekend sessions (4-6h)
- Theory during weekdays
- Practice on weekends
- Weekly review sessions

## Assessment Format Optimizations

### CodeSignal
- Timed practice with similar format
- Focus on completing all levels
- Efficient test case handling

### HackerRank / LeetCode / NeetCode
- Problem categories common on platform
- Time management techniques
- Input parsing practice

### Live Coding
- Verbalization practice
- Incremental development
- Handling interviewer hints

### System Design
- Component identification
- Scaling considerations
- Trade-off analysis

## Mock Interview Types

When `mock_interviews` is enabled, the plan includes:

### Technical Coding
- Algorithm problem-solving
- Time-constrained coding
- Explanation requirements
- Feedback on approach

### System Design
- Open-ended design questions
- Scalability discussions
- Component trade-offs
- Whiteboarding practice

### Behavioral
- STAR method questions
- Leadership scenarios
- Conflict resolution
- Team collaboration examples

## Multi-topic Study

You can configure multiple study plans simultaneously by running the command multiple times with different topic parameters. To switch between active plans:

```
switch_prep topic:<topic_name>
```

## Related Commands

- `study_day` - View the plan for a specific day in your custom plan
- `track_progress` - View progress in your custom preparation plan
- `compare_study` - See differences between topic-specific preparations
- `export_study_plan` - Generate a downloadable version of your plan
- `mock_interview` - Run a simulated interview session
- `skill_check` - Evaluate progress on specific skills
- `adjust_plan` - Modify your study plan based on progress