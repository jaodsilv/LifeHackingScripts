# Networking Commands
SCOPE: project

## `draft_reach_out` command
### Description
Generates a reaching out message or tips.

### Syntax
```
draft_reach_out [parameters]
```

### Parameters
| Parameter       | Description                              | Required | Example Values                                                                             | Default            |
|-----------------|----------------------------------------- |----------|--------------------------------------------------------------------------------------------|--------------------|
| `to`            | Recipient name.                          | Yes      | `Bob Marley`                                                                               | `None`             |
| `relationship`  | My relationship with the person.         | Yes*     | `Friend`, `Colleague`, `Dont Know`                                                         | `dont know`        |
| `reason`        | Reason for contact.                      | Yes      | `Reach out looking for job opportunities`                                                  | `job_oportunities` |
| `channel`       | Communication channel.                   | No       | `LinkedIn`, `WhatsApp`, `Email`                                                            | `LinkedIn`         |
| `company`       | Recipient's company                      | Yes*     | `Google`, `Amazon`, `Salesforce`                                                           | `None`             |
| `job_positions` | Positions of interest (comma-separated). | No       | `Senior Software Engineer`                                                                 | `None`             |
| `to_role`       | Recipient's job title.                   | No       | `Technical Recruiter`, `Recruiter Manager`                                                 | `None`             |
| `language`      | Message language.                        | No       | `English`, `Portuguese`                                                                    | `English`          |
| `tone`          | Tone style.                              | No       | `formal`, `casual`, `professional`                                                         | `professional`     |
| `mode`          | What you have to do.                     | No       | `writer`, `tips`                                                                           | `writer`           |
| `notes`         | Extra instructions.                      | No       | `My goal is to attract Recruiters`, `Follow the format "InfoA \| InfoB \| InfoC \| InfoD"` | `None`             |

\* At least one between `company` and `relationship` must be present.

## `draft_followup` command
### Description
Draft a follow-up email to a recruiter or other person for the <job_title> positions at <company_name>.
Mention the interview date, reiterate my enthusiasm, and, if it not the first email to that recruiter, subtly reference a topic we discussed.
Keep the tone professional and concise.
Use the current chat window for reviewing all messages received, I'll keep only 1 recruiter thread per chat.

### Syntax
```
draft_followup [parameters]
```

### Parameters
| Parameter               | Description                                | Required | Example Values                                                                             | Default        |
|-------------------------|--------------------------------------------|----------|--------------------------------------------------------------------------------------------|----------------|
| `company`               | Name of the company the person represents. | Yes*     | `Google`, `Anthropic`                                                                      | `Infer`        |
| `person_name`           | Name of the recruiter hiring manager.      | Yes*     | `Robert Downey Jr`                                                                         | `Infer`        |
| `person_title`          | Job title(s) of the person.                | Yes*     | `Hiring Manager`                                                                           | `Infer`        |
| `job_title`             | Job title(s) I'm interested.               | No       | `Software Engineer`, `["SWE", "Batman", "Joker"]`                                          | `Infer`        |
| `latest_email_received` | Latest email received from them.           | Yes*     | `Sunday, 24. Hi Joao, I have a job for you`                                                | `Infer`        |
| `latest_email_sent`     | Latest email sent to the person.           | No       | `Monday, 25. Hi Bob, I accept`                                                             | `Infer`        |
| `full_thread`           | Full thread of messages text.              | Yes*     | `[("Sunday, 24","Hi Joao, I have a job for you"), ("Monday, 25", "Hi Bob, I accept")]`     | `Infer`        |
| `channel`               | Communication channel.                     | No       | `LinkedIn`, `WhatsApp`, `Email`                                                            | `LinkedIn`     |
| `tone`                  | Tone style.                                | No       | `formal`, `casual`, `professional`                                                         | `professional` |
| `notes`                 | Extra instructions.                        | No**     | `My goal is to attract Recruiters`, `Follow the format "InfoA \| InfoB \| InfoC \| InfoD"` | `None`         |

\* Either the value must be present or it must be possible to infer from current chat context or from email messages. In the first message of the chat either `latest_email_received` or `full_thread` must be present.

** `notes` is not required but recommended.

## `improve_linkedin` command
### Description
Write Suggestions to improve linkedIn profile.
Write a LinkedIn headline for me based on my background as a Backend and Data Software Engineer. Focus on major achievements, industry keywords, and career goals. Use under 220 characters and keep ir results-driven. Example: 'Helping companies scale with AI-powered solutions| $1M revenue growth in SaaS | Business Strategist'.

### Syntax
```
improve_linkedin [parameters]
```

### Parameters
| Parameter       | Description                                                     | Required | Example Values                                                                             | Default   |
|-----------------|-----------------------------------------------------------------|----------|--------------------------------------------------------------------------------------------|-----------|
| `resume`        | Resume filename(s) to use.                                      | No       | `joao.resume.tex`, `[main.tex,1.summary.tex,2.1.Microsoft.tex]`                            | `*.tex`   |
| `cv`            | CV filename(s) to use. CV as an extended version of the Resume. | No       | `joao.cv.tex`, `[main.tex,1.summary.tex,2.1.Microsoft.tex]`                                | `None`    |
| `resume_source` | Source of the Resume.                                           | No       | `project`, `attachment`, `pasted`                                                          | `project` |
| `cv_source`     | Source of the CV.                                               | No       | `project`, `attachment`, `pasted`                                                          | `project` |
| `section`       | Section of the Linkedin Profile to improve.                     | No       | `headline`, `experience`, `work_at_microsoft`                                              | `all`     |
| `current`       | Current value for the given section.                            | No       | `Software Engineer with 9+ years of Experience`                                            | `None`    |
| `notes`         | Extra instructions.                                             | No       | `My goal is to attract Recruiters`, `Follow the format "InfoA \| InfoB \| InfoC \| InfoD"` | `None`    |
