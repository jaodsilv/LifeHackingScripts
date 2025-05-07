# `setup_study` Command Documentation
SCOPE: project

## Purpose
The `setup_study` command configures a customized preparation plan for technical interviews at specific companies or for particular assessment formats or any learning reason. This allows you to create targeted study plans beyond the default preparation.

## Basic Syntax
```
setup_study topic [parameters]
```

## Parameters

| Parameter | Description | Required | Example Values | Default Value |
|-----------|-------------|----------|----------------|---------------|
| `topic` | Topic to Learn | Yes | `Django`, `behavioral_interviews`, `JavaScript` | `None` |
| `start_level` | Initial level of knowledge about the topic | No | `beginner`, `advanced`, `proficient` | `beginner` |
| `constraints` | Other constraints consideration for when writing the document | No | `I am proficient in Go already` | `None` |
| `depth` | How deep should the learning go | No | `certification`, `know_all`, `proficient`, `basics` | `one_level_deeper_than_start_level` |
| `length` | Length of the document in expected time to read | No | `10min`, `1h` | `flexible` |
| `exercises` | Exercises format | No | `in_artifact`, `external_url_codesignal`, `external_url_hackerrank`, `external_url_neet_code` | `in_artifact` |
| `timeline` | Same as `length`, but specifically in Preparation days | No | Any positive integer | `None` |
| `start_date` | When to begin | No | Date in YYYY-MM-DD format | `None` |

## Examples

### Basic Usage
```bash
# Basic setup for learning Django
setup_study Django

# Setup with specific start level
setup_study JavaScript start_level:advanced

# Setup with depth specification
setup_study Python depth:certification
```

### Company-Specific Preparation
```bash
# Google interview preparation
setup_study Google exercises:external_url_leetcode timeline:30

# Amazon interview preparation with leadership focus
setup_study Amazon constraints:"I need to focus on leadership principles" length:2h

# Meta preparation with specific start date
setup_study Meta start_date:2024-04-01 timeline:45
```

### Assessment Format Examples
```bash
# CodeSignal assessment preparation
setup_study CodeSignal exercises:external_url_codesignal length:1h

# System design interview preparation
setup_study SystemDesign depth:know_all exercises:in_artifact

# Live coding interview preparation
setup_study LiveCoding constraints:"I need practice with verbal communication" length:30min
```

### Multi-Topic Preparation
```bash
# Full-stack preparation
setup_study FullStack start_level:beginner depth:proficient timeline:60

# Data structures and algorithms
setup_study DSA exercises:external_url_neetcode constraints:"I am weak in graph algorithms"

# Behavioral interview preparation
setup_study BehavioralInterviews length:45min exercises:in_artifact
```

### Customized Learning Paths
```bash
# Quick certification preparation
setup_study AWS depth:certification timeline:14 start_date:2024-03-15

# In-depth system architecture study
setup_study SystemArchitecture depth:know_all length:2h exercises:in_artifact

# Focused debugging skills
setup_study Debugging start_level:proficient constraints:"Focus on production debugging"
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