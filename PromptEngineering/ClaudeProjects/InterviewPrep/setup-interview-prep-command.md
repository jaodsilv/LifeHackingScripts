# `setup_interview_prep` Command Documentation
SCOPE: project

## Purpose
The `setup_interview_prep` command configures a customized preparation plan for technical interviews at specific companies or for particular assessment formats. This allows you to create targeted study plans beyond the default Anthropic preparation.

## Basic Syntax
```
setup_interview_prep company:<company_name> [position:<job_title>] [format:<assessment_type>] [timeline:<days>] [start_date:<YYYY-MM-DD>]
```

## Parameters

| Parameter | Description | Required | Example Values |
|-----------|-------------|----------|---------------|
| `company` | Target company name | Yes | `google`, `meta`, `amazon`, `microsoft` |
| `position` | Specific job role | No | `software_engineer`, `data_scientist` |
| `format` | Interview format | No | `codesignal`, `hackerrank`, `live_coding`, `system_design` |
| `timeline` | Preparation days | No | Any positive integer (default: 14) |
| `start_date` | When to begin | No | Date in YYYY-MM-DD format |

## Examples

### Setup for Google SWE interview
```
setup_interview_prep company:google position:software_engineer format:live_coding timeline:21
```

### Configure Microsoft system design prep starting next week
```
setup_interview_prep company:microsoft format:system_design start_date:2025-04-07
```

### Quick preparation for Amazon online assessment
```
setup_interview_prep company:amazon format:hackerrank timeline:7
```

## Behavior

When executed, the command will:

1. Generate a customized preparation plan based on the specified company and format
2. Create a day-by-day schedule optimized for your parameters
3. Highlight company-specific focus areas and question patterns
4. Provide relevant resources and practice materials
5. Configure the `study_day` and `study_session` commands for this plan
6. Create a parallel tracking system for this specific preparation

## Company-Specific Customization Examples

The system contains specialized knowledge about interview patterns at major tech companies a research on the company might be required for other companies:

### Google
- Focus on algorithm efficiency and edge cases
- Clean, maintainable code with good variable naming
- Strong foundation in data structures
- System design for senior roles

### Amazon
- Leadership Principles integration
- Practical problem-solving emphasis
- OOP and scalable systems

### Microsoft
- Coding fundamentals and debugging
- Problem-solving approach communication
- Design patterns and architecture

### Meta
- Performance optimization
- Product-oriented thinking
- Ninja coding exercises

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

## Multi-Company Preparation

You can configure multiple preparation plans simultaneously by running the command multiple times with different company parameters. To switch between active plans:

```
switch_prep company:<company_name>
```

## Related Commands

- `study_day` - View the plan for a specific day in your custom plan
- `track_progress` - View progress in your custom preparation plan
- `compare_prep` - See differences between company-specific preparations
- `export_prep_plan` - Generate a downloadable version of your plan