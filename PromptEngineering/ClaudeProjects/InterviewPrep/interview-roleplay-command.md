# `interview_roleplay` Command Documentation
SCOPE: project

## Purpose
The `interview_roleplay` command simulates an interview scenario where the system acts as a recruiter or interviewer, asking relevant questions and providing feedback based on your responses. This helps you practice and improve your interview skills in a safe environment.

## Basic Syntax
```
interview_roleplay [job_title|industry] [company_name:$value] [skills] [options]
```

## Parameters

| Parameter | Description | Required | Example Values |
|-----------|-------------|----------|---------------|
| `job_title` | Target job position | Yes* | `software_engineer`, `data_scientist` |
| `industry` | Target industry | Yes* | `tech`, `finance`, `healthcare` |
| `company_name` | Specific company | No | `google`, `microsoft`, `amazon` |
| `skills` | Focus areas for questions | No | `python`, `system_design`, `leadership` |
| `interview_type` | Type of interview | No | `recruiter`, `technical`, `behavioral`, `system_design` (default: `recruiter`) |
| `difficulty` | Question difficulty level | No | `beginner`, `intermediate`, `advanced` (default: `intermediate`) |
| `format` | Interview format | No | `star`, `casual`, `formal` (default: `star`) |
| `questions` | Number of questions | No | Integer (default: `5`) |
| `feedback_mode` | Type of feedback | No | `detailed`, `brief`, `none` (default: `detailed`) |
| `time_limit` | Time per question | No | `2min`, `5min`, `10min` (default: based on type) |
| `follow_up` | Enable follow-up questions | No | `true`, `false` (default: `true`) |
| `scenario` | Specific interview scenario | No | `onsite`, `phone`, `video`, `panel` |
| `interviewer_role` | Interviewer's role | No | `recruiter`, `hiring_manager`, `peer`, `skip_level` |
| `previous_feedback` | Incorporate past feedback | No | `tracking_id:interview_2024_03_15_google` |
| `language` | Interview language | No | `en`, `es`, `fr` (default: `en`) |
| `recording` | Enable response recording | No | `true`, `false` (default: `false`) |

*Either `job_title` OR `industry` must be provided

## Examples

### Basic recruiter call simulation
```
interview_roleplay job_title:software_engineer company_name:google
```

### Technical interview with specific skills focus
```
interview_roleplay job_title:backend_engineer skills:python,system_design interview_type:technical difficulty:advanced time_limit:5min
```

### Behavioral interview in STAR format
```
interview_roleplay industry:tech company_name:microsoft interview_type:behavioral format:star questions:3 scenario:onsite interviewer_role:hiring_manager
```

### Practice with previous feedback
```
interview_roleplay job_title:system_engineer interview_type:system_design previous_feedback:tracking_id:interview_2024_03_15_google recording:true
```

## Behavior

When executed, the command will:

1. Generate appropriate interview questions based on parameters
2. Act as the interviewer, asking questions one at a time
3. Evaluate responses based on the specified format
4. Provide constructive feedback after each response
5. Track performance metrics
6. Offer improvement suggestions
7. Record responses if enabled
8. Generate follow-up questions based on responses
9. Create a detailed feedback report
10. Link practice session to previous feedback

## Interview Types

### Recruiter Call
- Company culture fit
- Experience overview
- Salary expectations
- Timeline and process
- Basic technical screening
- Visa sponsorship (if applicable)
- Remote work policies
- Team structure

### Technical Interview
- Coding problems
- System design
- Architecture discussions
- Problem-solving approach
- Technical depth assessment
- Code review scenarios
- Debugging exercises
- Performance optimization

### Behavioral Interview
- Past experiences
- Leadership examples
- Conflict resolution
- Team collaboration
- Decision-making process
- Project management
- Innovation examples
- Failure handling

### System Design Interview
- Architecture planning
- Scalability considerations
- Trade-off analysis
- Technology selection
- Performance optimization
- Security considerations
- Cost analysis
- Maintenance planning

## Feedback Categories

The system provides feedback on:

### Content
- Answer completeness
- Example relevance
- Technical accuracy
- STAR format adherence
- Problem-solving approach
- Solution quality
- Code quality
- Architecture decisions

### Delivery
- Communication clarity
- Confidence level
- Time management
- Professional tone
- Body language (if video)
- Voice modulation
- Engagement level
- Question clarification

### Improvement Areas
- Specific suggestions
- Alternative approaches
- Best practices
- Common pitfalls
- Time management
- Technical depth
- Communication style
- Problem-solving strategy

## Performance Metrics

The system tracks:
- Response time
- Answer completeness
- Technical accuracy
- Communication effectiveness
- STAR format adherence
- Problem-solving efficiency
- Improvement over time
- Weak areas identification

## Related Commands

- `track_progress` - View interview practice history
- `export_feedback` - Generate interview feedback report
- `practice_question` - Get additional practice questions
- `review_session` - Analyze past interview sessions
- `feedback_integration` - Apply feedback to future sessions
- `study_session` - Focus on identified weak areas
- `compare_performance` - Track improvement over time 