# Enhanced Command: `recruiter_call_prep`
SCOPE: project

## Purpose
Generates comprehensive preparation materials for an upcoming introductory call with a recruiter, including company research, position analysis, key talking points, questions to ask, and follow-up strategy.

## Syntax
```
recruiter_call_prep [options]
```

## Parameters

| Parameter | Description | Required | Example Values |
|-----------|-------------|----------|---------------|
| `company:$name` | Company name for research | Yes | `anthropic`, `microsoft` |
| `position:$title` | Single position being discussed | Yes* | `software_engineer`, `data_scientist` |
| `positions:$list` | Multiple positions being discussed | Yes* | `software_engineer,data_scientist` |
| `recruiter:$name` | Name of the recruiter | No | `Jane Smith` |
| `recruiter_title:$title` | Recruiter's position | No | `Technical Recruiter` |
| `call_time:$duration` | Expected call duration | No | `30min`, `45min` (default: `30min`) |
| `call_date:$date` | Date of scheduled call | No | `2025-04-15` |
| `today_date:$date` | Today's date for reference | No | `2025-04-11` |
| `priority_topics:$list` | Topics to emphasize | No | `visa_sponsorship,interview_process` |
| `research_depth:$level` | Company research detail | No | `basic`, `detailed` (default: `basic`) |
| `questions:$count` | Number of questions to prepare | No | Integer (default: `5`) |
| `experience_focus:$area` | Experience to emphasize | No | `microsoft`, `data_pipelines` |
| `compensation_research:$boolean` | Include salary data | No | `true`, `false` (default: `true`) |
| `cv:$filename` | CV to reference | No | Default: `joao.cv.2025.short.tex` |
| `cv_source:$source` | Source of CV file | No | `project`, `attachment` (default: `project`) |
| `as_artifact:$boolean` | Output as an artifact | No | `true`, `false` (default: `true`) |
| `mode:$format` | Output format | No | `checklist`, `detailed`, `script` (default: `detailed`) |
| `applied_positions:$filenames` | Previous applications | No | Comma-separated list of filenames |
| `applied_positions_source:$source` | Source of application files | No | `project`, `attachment` (default: `attachment`) |
| `email_thread:$content` | Email correspondence | No | Text content of emails or filename |
| `email_thread_source:$source` | Source of email thread | No | `text`, `attachment` (default: `text`) |
| `mock_call:$boolean` | Generate mock call dialogue | No | `true`, `false` (default: `false`) |
| `industry_insights:$boolean` | Include industry trends | No | `true`, `false` (default: `false`) |
| `call_recording:$boolean` | Prepare for recorded call | No | `true`, `false` (default: `false`) |
| `follow_up_template:$boolean` | Include follow-up email template | No | `true`, `false` (default: `true`) |
| `recent_news:$days` | Recent company news (days) | No | Integer (default: `30`) |
| `concerns:$list` | Personal concerns to address | No | `relocation,visa,remote_work` |

*Either `position` OR `positions` must be provided

## Example Usage

### Basic preparation with essential information
```
recruiter_call_prep company:anthropic position:software_engineer
```

### Comprehensive preparation with additional context
```
recruiter_call_prep company:microsoft position:senior_engineer recruiter:John_Smith priority_topics:visa_sponsorship,team_structure experience_focus:data_pipelines applied_positions:microsoft_swe_application.pdf,microsoft_cover_letter.pdf
```

### With email thread context
```
recruiter_call_prep company:anthropic position:ml_engineer call_date:2025-04-12 email_thread:recruiter_emails.txt email_thread_source:attachment
```

### With multiple positions
```
recruiter_call_prep company:google positions:software_engineer,data_engineer,cloud_architect priority_topics:visa_sponsorship,remote_work
```

### With mock call dialogue and follow-up template
```
recruiter_call_prep company:amazon position:system_engineer mock_call:true follow_up_template:true concerns:relocation,team_fit
```

### Industry insights and recent news focus
```
recruiter_call_prep company:salesforce position:solutions_architect industry_insights:true recent_news:60 research_depth:detailed
```

## Output Content

The command will generate preparation materials including:

1. **Company Overview**
   - Company background, size, and structure
   - Recent news, product launches, and industry position
   - Company culture and values
   - Financial status and growth trajectory
   - Key competitors and market position
   - Technology stack and development approach
   - Recruitment patterns and hiring timeline

2. **Position Analysis**
   - Key responsibilities and requirements
   - Alignment with your experience
   - Potential growth opportunities
   - Team structure and reporting relationships
   - Day-to-day activities
   - Success metrics for the role
   - Typical career progression

3. **Application Context** (if applied_positions provided)
   - Summary of previous applications
   - Alignment between applications and current position
   - Key points from submitted materials to reference
   - Timeline of past interactions
   - Consistency check with current opportunity

4. **Communication History** (if email_thread provided)
   - Key points from previous correspondence
   - Topics already discussed
   - Outstanding questions or items to follow up on
   - Tone and style of communication
   - Recruiter's specific interests or concerns

5. **Personal Pitch Preparation**
   - Key talking points tailored to position
   - Relevant achievements and experiences to highlight
   - Skills alignment with job requirements
   - Prepared answers for common questions
   - Concise 30-second, 1-minute, and 2-minute pitches
   - Transition statements between topics
   - Recovery phrases for difficult questions

6. **Questions to Ask**
   - Role-specific technical questions
   - Team structure and dynamics
   - Project and technology questions
   - Growth and development opportunities
   - Visa sponsorship and timeline questions (if applicable)
   - Next steps in the interview process
   - Hiring timeline and decision process
   - Remote work and flexibility policies

7. **Practical Preparation**
   - Call logistics and technical requirements
   - Recommended environment setup
   - Note-taking strategy
   - Follow-up plan and timeline
   - Contingency plans for technical issues
   - Discussion pacing recommendations
   - Voice and presentation tips

8. **Compensation Research** (if enabled)
   - Salary range for similar positions
   - Company-specific compensation patterns
   - Benefits package overview
   - Negotiation strategy points
   - Timing considerations for discussions
   - Total compensation framework
   - Equity and bonus information

9. **Mock Call Dialogue** (if enabled)
   - Simulated conversation script
   - Common recruiter questions and ideal responses
   - Difficult questions and suggested answers
   - Natural conversation flow examples
   - Time management guidance
   - Active listening prompts

10. **Follow-up Template** (if enabled)
    - Customizable thank-you email
    - Key discussion points to reference
    - Expression of continued interest
    - Next steps reminder
    - Timeline for follow-up
    - Additional information sharing
    - Professional closing
