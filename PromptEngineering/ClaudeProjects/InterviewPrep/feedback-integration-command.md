# `feedback_integration` Command Documentation
SCOPE: project

## Purpose
The `feedback_integration` command helps you incorporate feedback received from interviews, recruiters, or other sources into your application materials. It provides structured guidance on how to improve your CV, cover letters, and other application documents based on specific feedback.

## Basic Syntax
```
feedback_integration [options]
```

## Parameters

| Parameter | Description | Required | Example Values |
|-----------|-------------|----------|---------------|
| `feedback` | The feedback text to be integrated | Yes | `"Need more emphasis on leadership experience"` |
| `target` | Document to apply feedback to | Yes | `cv`, `letter`, `portfolio`, `interview_responses` |
| `priority` | How quickly to implement changes | No | `high`, `medium`, `low` (default: `medium`) |
| `format` | Output format for suggestions | No | `detailed`, `checklist`, `diff`, `action_items` (default: `detailed`) |
| `context` | Additional context about feedback | No | `"From Google recruiter call"` |
| `version` | Version of document to modify | No | `current`, `draft`, `previous` (default: `current`) |
| `interview_type` | Type of interview feedback | No | `recruiter`, `technical`, `behavioral`, `system_design` |
| `company` | Company providing feedback | No | `google`, `microsoft`, `amazon` |
| `tracking_id` | Link to specific interview | No | `interview_2024_03_15_google` |
| `improvement_areas` | Focus areas for improvement | No | `communication`, `technical_depth`, `leadership` |
| `timeline` | When to implement changes | No | `immediate`, `next_week`, `next_interview` |

## Examples

### Basic feedback integration for CV
```
feedback_integration feedback:"Need more emphasis on leadership experience" target:cv
```

### High priority feedback with context
```
feedback_integration feedback:"Add more technical details about cloud projects" target:cv priority:high context:"From AWS interview feedback" company:aws interview_type:technical
```

### Format as checklist with specific improvement areas
```
feedback_integration feedback:"Improve STAR format in experience section" target:letter format:checklist improvement_areas:communication,structure
```

### Interview response improvement
```
feedback_integration feedback:"Need more concrete examples in system design answers" target:interview_responses interview_type:system_design company:google tracking_id:interview_2024_03_15_google
```

## Behavior

When executed, the command will:

1. Analyze the provided feedback
2. Identify specific areas in the target document that need modification
3. Generate concrete suggestions for improvements
4. Provide examples of how to implement the changes
5. Create a prioritized action list
6. Track feedback implementation status
7. Link feedback to specific interview sessions
8. Generate practice exercises for improvement areas
9. Create a timeline for implementing changes
10. Suggest related interview preparation activities

## Feedback Categories

The command can handle various types of feedback:

### Content Feedback
- Missing information
- Unclear descriptions
- Inappropriate emphasis
- Technical accuracy
- STAR format implementation
- Example quality and relevance

### Format Feedback
- Structure issues
- Length concerns
- Style consistency
- Visual presentation
- Response organization
- Time management

### Impact Feedback
- Achievement quantification
- Value demonstration
- Relevance to role
- STAR format implementation
- Communication effectiveness
- Technical depth demonstration

### Interview-Specific Feedback
- Question understanding
- Response structure
- Technical accuracy
- Communication clarity
- Time management
- Follow-up questions

## Implementation Tracking

The system maintains a record of:
- Feedback received
- Implementation status
- Version history
- Impact assessment
- Interview performance correlation
- Improvement timeline
- Practice session results
- Related interview outcomes

## Related Commands

- `track_progress` - View feedback implementation status
- `export_feedback` - Generate feedback implementation report
- `compare_versions` - See changes between document versions
- `reset_feedback` - Clear feedback implementation status
- `practice_question` - Get practice questions for improvement areas
- `interview_roleplay` - Practice with specific feedback in mind
- `study_session` - Focus study on identified improvement areas 