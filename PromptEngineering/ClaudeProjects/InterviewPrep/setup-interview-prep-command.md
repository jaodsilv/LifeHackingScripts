# `setup_interview_prep` Command Documentation
SCOPE: project

## Purpose
The `setup_interview_prep` command configures a customized preparation plan for technical interviews at specific companies or for particular assessment formats. This allows you to create targeted study plans beyond the default Anthropic preparation.

## Basic Syntax
```
setup_interview_prep company:<company_name> [position:<job_title>] [format:<assessment_type>] [timeline:<days>] [start_date:<YYYY-MM-DD>] [focus:<areas>] [experience:<level>] [recruiter_materials:<file_path>] [email_thread:<file_path>] [interview_datetime:<YYYY-MM-DD HH:MM>] [language:<programming_language>]
```

## Parameters

| Parameter | Description | Required | Example Values |
|-----------|-------------|----------|---------------|
| `company` | Target company name | Yes | `google`, `meta`, `amazon`, `microsoft` |
| `position` | Specific job role | No | `software_engineer`, `data_scientist` |
| `format` | Interview format | No | `codesignal`, `hackerrank`, `live_coding`, `system_design` |
| `timeline` | Preparation days | No | Any positive integer (default: 14) |
| `start_date` | When to begin | No | Date in YYYY-MM-DD format |
| `focus` | Specific areas to emphasize | No | `algorithms`, `system_design`, `behavioral`, `all` |
| `experience` | Your experience level | No | `entry`, `mid`, `senior`, `lead` |
| `intensity` | Study plan intensity | No | `light`, `moderate`, `intensive` (default: `moderate`) |
| `resources` | Study resources to include | No | `books`, `videos`, `practice`, `all` (default: `all`) |
| `weak_areas` | Areas needing focus | No | `ds_algo`, `system_design`, `communication` |
| `recruiter_materials` | Materials provided by recruiter | No | File path to PDF, document, or folder |
| `email_thread` | Email exchanges with recruiter | No | File path to email export or text file |
| `job_description` | Formal job description | No | File path or text content in quotes |
| `interview_instructions` | Specific interview instructions | No | File path or text content in quotes |
| `previous_feedback` | Feedback from prior interviews | No | File path or text content in quotes |
| `interview_panel` | Information about interviewers | No | File path to document or text content |
| `materials_source` | Source of attached materials | No | `file`, `text`, `url` (default: `file`) |
| `interview_datetime` | Scheduled interview date and time | No | `2025-04-15 14:30`, `tomorrow 9am` |
| `interview_duration` | Expected interview duration | No | `45min`, `1h`, `2h` (default: `1h`) |
| `timezone` | Timezone for interview time | No | `EST`, `PST`, `UTC` (default: local timezone) |
| `language` | Programming language for interview | No | `python`, `java`, `c++`, `javascript` (default: `python`) |
| `language_version` | Specific language version | No | `3.9`, `ES6`, `C++17` |

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

### Targeted prep for experienced engineer focusing on weak areas
```
setup_interview_prep company:meta position:senior_engineer experience:senior focus:system_design weak_areas:scalability,database_design
```

### Balanced preparation with specific intensity
```
setup_interview_prep company:google position:software_engineer intensity:moderate resources:practice,videos focus:algorithms,behavioral
```

### Preparation with recruiter-provided materials
```
setup_interview_prep company:apple position:ios_developer email_thread:recruiter_emails.txt job_description:"Senior iOS Developer with 5+ years experience building consumer apps"
```

### Complete preparation with all context
```
setup_interview_prep company:netflix position:senior_swe timeline:14 focus:system_design recruiter_materials:netflix_prep_docs/ email_thread:netflix_emails.eml job_description:netflix_job.pdf interview_instructions:"Prepare a 15-minute system design presentation" interview_panel:interviewers.txt
```

### Preparation with specific interview date
```
setup_interview_prep company:google position:software_engineer interview_datetime:"2025-05-12 10:00" timezone:PST interview_duration:2h
```

### Emergency preparation for imminent interview
```
setup_interview_prep company:microsoft position:frontend_developer interview_datetime:"tomorrow 2pm" intensity:intensive focus:algorithms,javascript
```

### Preparation with specific programming language
```
setup_interview_prep company:amazon position:backend_engineer language:java language_version:11 focus:algorithms,system_design
```

### Front-end focused preparation with JavaScript
```
setup_interview_prep company:meta position:frontend_engineer language:javascript language_version:ES6 focus:dom_manipulation,react
```

## Behavior

When executed, the command will:

1. Generate a customized preparation plan based on the specified company and format
2. Create a day-by-day schedule optimized for your parameters
3. Highlight company-specific focus areas and question patterns
4. Provide relevant resources and practice materials
5. Configure the `study_day` and `study_session` commands for this plan
6. Create a parallel tracking system for this specific preparation
7. Adjust difficulty based on your experience level
8. Balance content across focus areas
9. Prioritize weak areas for additional practice
10. Schedule regular mock interviews throughout the timeline
11. Analyze provided recruiter materials for specific preparation guidance
12. Extract key information from email threads and job descriptions
13. Identify specific interview focus areas based on all available context
14. Tailor your preparation to match explicit interview instructions
15. Customize practice based on interviewer backgrounds and specialties
16. Automatically adjust the preparation timeline based on interview date
17. Increase intensity as the interview date approaches
18. Schedule final review and rest periods before the interview
19. Provide day-of interview preparation guidance
20. Set calendar reminders for key preparation milestones
21. Tailor practice problems and examples to your specified programming language
22. Focus on language-specific best practices and idioms

## Programming Language Customization

When a specific programming language is provided, the system will:

### Language-Specific Practice
- Generate code examples in your target language
- Recommend language-specific resources and documentation
- Focus on idiomatic patterns for the chosen language
- Highlight common pitfalls and best practices
- Provide language-specific time and space complexity considerations

### Implementation Techniques
- Emphasize built-in data structures and their performance characteristics
- Cover language-specific optimization techniques
- Address memory management considerations (if relevant)
- Focus on appropriate error handling approaches
- Demonstrate idiomatic solutions to common algorithm problems

### Language Version Features
- Target features available in the specified language version
- Highlight modern syntax and approaches
- Avoid deprecated patterns or methods
- Utilize version-specific standard library features
- Emphasize performance improvements in newer versions

### Company-Language Alignment
- Adjust for company preferences regarding the language
- Focus on how the company typically uses the language
- Highlight company-specific coding standards if known
- Address language-specific aspects of the company's technical stack
- Prepare for language-specific interview questions common at the company

## Interview Date Optimization

When an interview date is provided, the system will:

### Timeline Adjustment
- Calculate exact days remaining until interview
- Override the default timeline to match available preparation time
- Adjust daily study load based on time constraints
- Create a countdown-based preparation plan

### Intensity Progression
- Start with foundational concepts regardless of timeline
- Gradually increase practice intensity as interview approaches
- Schedule more mock interviews in the final days
- Allocate more time to weak areas as date approaches

### Pre-Interview Schedule
- Lighter review sessions on the day before interview
- Mental preparation exercises on interview eve
- Morning routine suggestions for interview day
- Reminder for interview logistics preparation

### Calendar Integration
- Set reminders for key preparation milestones
- Schedule buffer time before the interview
- Suggest optimal sleep schedule adjustment
- Provide time zone conversion if needed

## Recruiter Materials Analysis

When providing recruiter materials, the system will:

### Email Thread Analysis
- Extract key dates and logistics
- Identify specific topics mentioned by recruiters
- Note any preparation instructions or hints
- Recognize company values and priorities emphasized
- Track changes in process or expectations

### Job Description Analysis
- Identify required technical skills
- Note emphasized soft skills or values
- Extract team and project context
- Recognize desired experience levels
- Flag specific technologies for focused study

### Interview Instructions
- Prioritize explicit interview format details
- Prepare for any presentation requirements
- Identify time constraints for each segment
- Recognize preferred frameworks or approaches
- Allocate preparation time proportionally

### Interviewer Panel Information
- Research interviewer backgrounds when provided
- Identify specialized areas based on interviewer expertise
- Prepare for potential question styles based on roles
- Adjust technical vs. behavioral preparation ratio
- Incorporate relevant insights into mock interviews

## Company-Specific Customization Examples

The system contains specialized knowledge about interview patterns at major tech companies a research on the company might be required for other companies:

### Google
- Focus on algorithm efficiency and edge cases
- Clean, maintainable code with good variable naming
- Strong foundation in data structures
- System design for senior roles
- Leadership and culture fit assessment
- Problem-solving approach communication
- Code optimization techniques
- Testing strategies

### Amazon
- Leadership Principles integration
- Practical problem-solving emphasis
- OOP and scalable systems
- Behavioral STAR method
- Cost optimization considerations
- System resilience and recovery
- Service-oriented architecture
- Customer obsession demonstration

### Microsoft
- Coding fundamentals and debugging
- Problem-solving approach communication
- Design patterns and architecture
- Product-oriented thinking
- Team collaboration assessment
- API design principles
- Dependency management
- Technical learning mindset

### Meta
- Performance optimization
- Product-oriented thinking
- Ninja coding exercises
- Scale and efficiency handling
- Web/mobile technology proficiency
- User experience considerations
- Team impact assessment
- Fast paced decision-making

## Experience Level Adjustments

The study plan adapts based on your experience level:

### Entry Level
- Fundamental data structures and algorithms
- Basic system design concepts
- Core language proficiency
- Simple problem-solving patterns
- Behavioral question preparation

### Mid Level
- Medium complexity algorithms
- Component-level system design
- Language optimization techniques
- Full application architecture
- Leadership examples preparation

### Senior Level
- Complex algorithm optimization
- System-wide architecture design
- Scalability and performance focus
- Cross-functional leadership
- Team building and mentorship

### Lead Level
- Architectural trade-off discussions
- Enterprise-scale system design
- Technical vision communication
- Team structure and processes
- Strategic decision making

## Assessment Format Optimizations

### CodeSignal
- Timed practice with similar format
- Focus on completing all levels
- Efficient test case handling
- Input validation techniques
- Common problem patterns

### HackerRank / LeetCode / NeetCode
- Problem categories common on platform
- Time management techniques
- Input parsing practice
- Optimal test case construction
- Edge case identification

### Live Coding
- Verbalization practice
- Incremental development
- Handling interviewer hints
- Error recovery techniques
- Clear explanation methods
- Pseudocode to implementation

### System Design
- Component identification
- Scaling considerations
- Trade-off analysis
- Database selection criteria
- Load balancing approaches
- Caching strategies
- Failure handling

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
- `mock_interview` - Conduct a simulated interview for your target company
- `weak_areas` - Identify areas needing additional focus
- `company_research` - Get up-to-date information about the company