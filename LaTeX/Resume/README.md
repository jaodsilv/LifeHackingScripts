# Versioning Map For my CV and Resumes
## CurriculumVitae
./CurriculumVitae - Should contain ALL possible versions within it. A Union of all other versions with even extra content, like the expanded Internships experience and the full Technical Skills.
Number of pages is not limited.

## Resume
Shortened version with up to 2 pages.

### Proposed Versions
The goal of each version is to be used as base for tailoring to a specific job post.
There are three tailoring dimensions.

1. Aimed Positions
2. Is the company an AI company or is the team an AI team? (AI or Non-AI)
3. Company Culture relating to Mental Health and Neurodiversity (Mental Health and Neurodiversity Friendly or Not)

#### Positions
1. Senior Backend Software Engineer
2. Senior Data Software Engineer
3. Senior Distributed Systems Software Engineer
4. Senior Infrastructure Software Engineer
With a Resume for each of these positions and for each combination of these three positions.

5. Backend + Data Version
6. Backend + Distributed Systems Version
7. Backend + Infrastructure Version
8. Data + Distributed Systems Version
9. Data + Infrastructure Version
10. Distributed Systems + Infrastructure Version
11. Backend + Data + Distributed Systems Version
12. Backend + Data + Infrastructure Version
13. Backend + Distributed Systems + Infrastructure Version
14. Data + Distributed Systems + Infrastructure Version
15. Backend + Data + Distributed Systems + Infrastructure Version

### Folder Naming
Versions will be hosted on folders named following the REGEX (Backend)?-?(Data)?-(DistributedSystems)?-?(Infra)?(-AI)?
Neurodiversity will be present within each version folder as a commented bullet point (That will be only difference between the versions).

### Progress
#### Ready Versions
- "Backend Software Engineer" + "Infrastructure Software Engineer"
- "Backend Software Engineer" + AI

#### In Progress Versions

#### Planned Versions

#### Base
Backend
Data
Distributed Systems
Infra
Backend-Data
Backend-DistributedSystems
Data-DistributedSystems
Data-Infra
DistributedSystems-Infra
Backend-Data-DistributedSystems
Backend-Data-Infra
Backend-DistributedSystems-Infra
Data-DistributedSystems-Infra
Backend-Data-DistributedSystems-Infra

#### Base AI
Data-AI
DistributedSystems-AI
Infra-AI
Backend-Data-AI
Backend-DistributedSystems-AI
Backend-Infra-AI
Data-DistributedSystems-AI
Data-Infra-AI
DistributedSystems-Infra-AI
Backend-Data-DistributedSystems-AI
Backend-Data-Infra-AI
Backend-DistributedSystems-Infra-AI
Data-DistributedSystems-Infra-AI
Backend-Data-DistributedSystems-Infra-AI

### Commands
#### [ ] "Backend Software Engineer"
[ ] `sort_items_within_categories job_title:"Backend Software Engineer" seniority_level:senior category:"Education->Bachelor's Degree->Relevant coursework(\newcommand{\RelevantCoursework} in main.tex file)" is_ai:false as_artifact:true`
[ ] `suggest_text_improvements job_title:"Backend Software Engineer" seniority_level:senior section:"Professional Summary" is_ai:false as_artifact:true`
[ ] `sort_bullets job_title:"Backend Software Engineer" seniority_level:senior section:"Professional Development->Microsoft Learning Paths" is_ai:false as_artifact:true`
[ ] `sort_items_within_categories job_title:"Backend Software Engineer" seniority_level:senior category:"Interests" is_ai:false as_artifact:true`
[ ] `sort_bullets job_title:"Backend Software Engineer" seniority_level:senior section:"Professional Experience->Google" is_ai:false as_artifact:true`

[ ] `sort_bullets job_title:"Backend Software Engineer" seniority_level:senior section:"Professional Experience->Microsoft" is_ai:false as_artifact:true`
[ ] `suggest_text_improvements job_title:"Backend Software Engineer" seniority_level:senior section:"Professional Experience->Microsoft" is_ai:false as_artifact:true`


[ ] `sort_bullets job_title:"Backend Software Engineer" seniority_level:senior section:"Skills" is_ai:false as_artifact:true`
[ ] `suggest_text_improvements job_title:"Backend Software Engineer" seniority_level:senior section:"Skills" is_ai:false as_artifact:true notes:"Focus in the text itself and terminology. DO NOT sort anything yourself. Use the order above for the bullets and keep the original order within each category, this is to ease review."`
[ ] `sort_items_within_categories job_title:"Backend Software Engineer" seniority_level:senior section:"Skills" is_ai:false as_artifact:true`
[ ] `list_least_relevant_items job_title:"Backend Software Engineer" seniority_level:senior section:"Skills" is_ai:false as_artifact:true mode:merged n:40`

#### [ ] "Data Software Engineer"
[ ] `sort_items_within_categories job_title:"Data Software Engineer" seniority_level:senior category:"Education->Bachelor's Degree->Relevant coursework(\newcommand{\RelevantCoursework} in main.tex file)" is_ai:false as_artifact:true`
[ ] `suggest_text_improvements job_title:"Data Software Engineer" seniority_level:senior section:"Professional Summary" is_ai:false as_artifact:true`
[ ] `sort_bullets job_title:"Data Software Engineer" seniority_level:senior section:"Professional Development->Microsoft Learning Paths" is_ai:false as_artifact:true`
[ ] `sort_items_within_categories job_title:"Data Software Engineer" seniority_level:senior category:"Interests" is_ai:false as_artifact:true`
[ ] `sort_bullets job_title:"Data Software Engineer" seniority_level:senior section:"Professional Experience->Google" is_ai:false as_artifact:true`

[ ] `sort_bullets job_title:"Data Software Engineer" seniority_level:senior section:"Professional Experience->Microsoft" is_ai:false as_artifact:true`
[ ] `suggest_text_improvements job_title:"Data Software Engineer" seniority_level:senior section:"Professional Experience->Microsoft" is_ai:false as_artifact:true`


[ ] `sort_bullets job_title:"Data Software Engineer" seniority_level:senior section:"Skills" is_ai:false as_artifact:true`
[ ] `suggest_text_improvements job_title:"Data Software Engineer" seniority_level:senior section:"Skills" is_ai:false as_artifact:true notes:"Focus in the text itself and terminology. DO NOT sort anything yourself. Use the order above for the bullets and keep the original order within each category, this is to ease review."`
[ ] `sort_items_within_categories job_title:"Data Software Engineer" seniority_level:senior section:"Skills" is_ai:false as_artifact:true`
[ ] `list_least_relevant_items job_title:"Data Software Engineer" seniority_level:senior section:"Skills" is_ai:false as_artifact:true mode:merged n:40`

#### [ ] "Distributed Systems Software Engineer"
[ ] `sort_items_within_categories job_title:"Distributed Systems Software Engineer" seniority_level:senior category:"Education->Bachelor's Degree->Relevant coursework(\newcommand{\RelevantCoursework} in main.tex file)" is_ai:false as_artifact:true`
[ ] `suggest_text_improvements job_title:"Distributed Systems Software Engineer" seniority_level:senior section:"Professional Summary" is_ai:false as_artifact:true`
[ ] `sort_bullets job_title:"Distributed Systems Software Engineer" seniority_level:senior section:"Professional Development->Microsoft Learning Paths" is_ai:false as_artifact:true`
[ ] `sort_items_within_categories job_title:"Distributed Systems Software Engineer" seniority_level:senior category:"Interests" is_ai:false as_artifact:true`
[ ] `sort_bullets job_title:"Distributed Systems Software Engineer" seniority_level:senior section:"Professional Experience->Google" is_ai:false as_artifact:true`

[ ] `sort_bullets job_title:"Distributed Systems Software Engineer" seniority_level:senior section:"Professional Experience->Microsoft" is_ai:false as_artifact:true`
[ ] `suggest_text_improvements job_title:"Distributed Systems Software Engineer" seniority_level:senior section:"Professional Experience->Microsoft" is_ai:false as_artifact:true`


[ ] `sort_bullets job_title:"Distributed Systems Software Engineer" seniority_level:senior section:"Skills" is_ai:false as_artifact:true`
[ ] `suggest_text_improvements job_title:"Distributed Systems Software Engineer" seniority_level:senior section:"Skills" is_ai:false as_artifact:true notes:"Focus in the text itself and terminology. DO NOT sort anything yourself. Use the order above for the bullets and keep the original order within each category, this is to ease review."`
[ ] `sort_items_within_categories job_title:"Distributed Systems Software Engineer" seniority_level:senior section:"Skills" is_ai:false as_artifact:true`
[ ] `list_least_relevant_items job_title:"Distributed Systems Software Engineer" seniority_level:senior section:"Skills" is_ai:false as_artifact:true mode:merged n:40`

#### [ ] "Infrastructure Software Engineer"
[ ] `sort_items_within_categories job_title:"Infrastructure Software Engineer" seniority_level:senior category:"Education->Bachelor's Degree->Relevant coursework(\newcommand{\RelevantCoursework} in main.tex file)" is_ai:false as_artifact:true`
[ ] `suggest_text_improvements job_title:"Infrastructure Software Engineer" seniority_level:senior section:"Professional Summary" is_ai:false as_artifact:true`
[ ] `sort_bullets job_title:"Infrastructure Software Engineer" seniority_level:senior section:"Professional Development->Microsoft Learning Paths" is_ai:false as_artifact:true`
[ ] `sort_items_within_categories job_title:"Infrastructure Software Engineer" seniority_level:senior category:"Interests" is_ai:false as_artifact:true`
[ ] `sort_bullets job_title:"Infrastructure Software Engineer" seniority_level:senior section:"Professional Experience->Google" is_ai:false as_artifact:true`

[ ] `sort_bullets job_title:"Infrastructure Software Engineer" seniority_level:senior section:"Professional Experience->Microsoft" is_ai:false as_artifact:true`
[ ] `suggest_text_improvements job_title:"Infrastructure Software Engineer" seniority_level:senior section:"Professional Experience->Microsoft" is_ai:false as_artifact:true`


[ ] `sort_bullets job_title:"Infrastructure Software Engineer" seniority_level:senior section:"Skills" is_ai:false as_artifact:true`
[ ] `suggest_text_improvements job_title:"Infrastructure Software Engineer" seniority_level:senior section:"Skills" is_ai:false as_artifact:true notes:"Focus in the text itself and terminology. DO NOT sort anything yourself. Use the order above for the bullets and keep the original order within each category, this is to ease review."`
[ ] `sort_items_within_categories job_title:"Infrastructure Software Engineer" seniority_level:senior section:"Skills" is_ai:false as_artifact:true`
[ ] `list_least_relevant_items job_title:"Infrastructure Software Engineer" seniority_level:senior section:"Skills" is_ai:false as_artifact:true mode:merged n:40`

#### [ ] "Backend Software Engineer" + "Data Software Engineer"
[ ] `sort_items_within_categories job_titles:["Backend Software Engineer", "Data Software Engineer"] seniority_level:senior category:"Education->Bachelor's Degree->Relevant coursework(\newcommand{\RelevantCoursework} in main.tex file)" is_ai:false as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Backend Software Engineer", "Data Software Engineer"] seniority_level:senior section:"Professional Summary" is_ai:false as_artifact:true`
[ ] `sort_bullets job_titles:["Backend Software Engineer", "Data Software Engineer"] seniority_level:senior section:"Professional Development->Microsoft Learning Paths" is_ai:false as_artifact:true`
[ ] `sort_items_within_categories job_titles:["Backend Software Engineer", "Data Software Engineer"] seniority_level:senior category:"Interests" is_ai:false as_artifact:true`
[ ] `sort_bullets job_titles:["Backend Software Engineer", "Data Software Engineer"] seniority_level:senior section:"Professional Experience->Google" is_ai:false as_artifact:true`

[ ] `sort_bullets job_titles:["Backend Software Engineer", "Data Software Engineer"] seniority_level:senior section:"Professional Experience->Microsoft" is_ai:false as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Backend Software Engineer", "Data Software Engineer"] seniority_level:senior section:"Professional Experience->Microsoft" is_ai:false as_artifact:true`


[ ] `sort_bullets job_titles:["Backend Software Engineer", "Data Software Engineer"] seniority_level:senior section:"Skills" is_ai:false as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Backend Software Engineer", "Data Software Engineer"] seniority_level:senior section:"Skills" is_ai:false as_artifact:true notes:"Focus in the text itself and terminology. DO NOT sort anything yourself. Use the order above for the bullets and keep the original order within each category, this is to ease review."`
[ ] `sort_items_within_categories job_titles:["Backend Software Engineer", "Data Software Engineer"] seniority_level:senior section:"Skills" is_ai:false as_artifact:true`
[ ] `list_least_relevant_items job_titles:["Backend Software Engineer", "Data Software Engineer"] seniority_level:senior section:"Skills" is_ai:false as_artifact:true mode:merged n:40`

#### [ ] "Backend Software Engineer" + "Distributed Systems Software Engineer"
[ ] `sort_items_within_categories job_titles:["Backend Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior category:"Education->Bachelor's Degree->Relevant coursework(\newcommand{\RelevantCoursework} in main.tex file)" is_ai:false as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Backend Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior section:"Professional Summary" is_ai:false as_artifact:true`
[ ] `sort_bullets job_titles:["Backend Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior section:"Professional Development->Microsoft Learning Paths" is_ai:false as_artifact:true`
[ ] `sort_items_within_categories job_titles:["Backend Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior category:"Interests" is_ai:false as_artifact:true`
[ ] `sort_bullets job_titles:["Backend Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior section:"Professional Experience->Google" is_ai:false as_artifact:true`

[ ] `sort_bullets job_titles:["Backend Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior section:"Professional Experience->Microsoft" is_ai:false as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Backend Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior section:"Professional Experience->Microsoft" is_ai:false as_artifact:true`


[ ] `sort_bullets job_titles:["Backend Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior section:"Skills" is_ai:false as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Backend Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior section:"Skills" is_ai:false as_artifact:true notes:"Focus in the text itself and terminology. DO NOT sort anything yourself. Use the order above for the bullets and keep the original order within each category, this is to ease review."`
[ ] `sort_items_within_categories job_titles:["Backend Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior section:"Skills" is_ai:false as_artifact:true`
[ ] `list_least_relevant_items job_titles:["Backend Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior section:"Skills" is_ai:false as_artifact:true mode:merged n:40`

#### [X] "Backend Software Engineer" + "Infrastructure Software Engineer"
[x] `suggest_text_improvements job_titles:["Backend Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Summary" is_ai:false`
[x] `sort_items_within_categories job_titles:["Backend Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior category:"Education->Bachelor's Degree->Relevant coursework(\newcommand{\RelevantCoursework} in main.tex file)" is_ai:false`
[x] `sort_bullets job_titles:["Backend Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Development->Microsoft Learning Paths" is_ai:false`
[x] `sort_items_within_categories job_titles:["Backend Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior category:"Interests" is_ai:false`
[x] `sort_bullets job_titles:["Backend Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Experience->Google" is_ai:false`

[x] `sort_bullets job_titles:["Backend Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Experience->Microsoft" is_ai:false`
[x] `suggest_text_improvements job_titles:["Backend Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Experience->Microsoft" is_ai:false`

[x] `sort_bullets job_titles:["Backend Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Skills" is_ai:false`
[x] `sort_items_within_categories job_titles:["Backend Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior is_ai:false`
[x] `list_least_relevant_items job_titles:["Backend Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior mode:merged is_ai:false section:"Skills" n:40`
[x] `suggest_text_improvements job_titles:["Backend Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Skills" is_ai:false`

#### [ ] "Data Software Engineer" + "Distributed Systems Software Engineer"
[ ] `sort_items_within_categories job_titles:["Data Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior category:"Education->Bachelor's Degree->Relevant coursework(\newcommand{\RelevantCoursework} in main.tex file)" is_ai:false as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Data Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior section:"Professional Summary" is_ai:false as_artifact:true`
[ ] `sort_bullets job_titles:["Data Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior section:"Professional Development->Microsoft Learning Paths" is_ai:false as_artifact:true`
[ ] `sort_items_within_categories job_titles:["Data Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior category:"Interests" is_ai:false as_artifact:true`
[ ] `sort_bullets job_titles:["Data Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior section:"Professional Experience->Google" is_ai:false as_artifact:true`

[ ] `sort_bullets job_titles:["Data Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior section:"Professional Experience->Microsoft" is_ai:false as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Data Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior section:"Professional Experience->Microsoft" is_ai:false as_artifact:true`

[ ] `sort_bullets job_titles:["Data Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior section:"Skills" is_ai:false as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Data Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior section:"Skills" is_ai:false as_artifact:true notes:"Focus in the text itself and terminology. DO NOT sort anything yourself. Use the order above for the bullets and keep the original order within each category, this is to ease review."`
[ ] `sort_items_within_categories job_titles:["Data Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior section:"Skills" is_ai:false as_artifact:true`
[ ] `list_least_relevant_items job_titles:["Data Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior section:"Skills" is_ai:false as_artifact:true mode:merged n:40`

#### [ ] "Data Software Engineer" + "Infrastructure Software Engineer"
[ ] `sort_items_within_categories job_titles:["Data Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior category:"Education->Bachelor's Degree->Relevant coursework(\newcommand{\RelevantCoursework} in main.tex file)" is_ai:false as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Data Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Summary" is_ai:false as_artifact:true`
[ ] `sort_bullets job_titles:["Data Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Development->Microsoft Learning Paths" is_ai:false as_artifact:true`
[ ] `sort_items_within_categories job_titles:["Data Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior category:"Interests" is_ai:false as_artifact:true`
[ ] `sort_bullets job_titles:["Data Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Experience->Google" is_ai:false as_artifact:true`

[ ] `sort_bullets job_titles:["Data Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Experience->Microsoft" is_ai:false as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Data Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Experience->Microsoft" is_ai:false as_artifact:true`

[ ] `sort_bullets job_titles:["Data Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Skills" is_ai:false as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Data Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Skills" is_ai:false as_artifact:true notes:"Focus in the text itself and terminology. DO NOT sort anything yourself. Use the order above for the bullets and keep the original order within each category, this is to ease review."`
[ ] `sort_items_within_categories job_titles:["Data Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Skills" is_ai:false as_artifact:true`
[ ] `list_least_relevant_items job_titles:["Data Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Skills" is_ai:false as_artifact:true mode:merged n:40`


#### [ ] "Distributed Systems Software Engineer" + "Infrastructure Software Engineer"
[ ] `sort_items_within_categories job_titles:["Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior category:"Education->Bachelor's Degree->Relevant coursework(\newcommand{\RelevantCoursework} in main.tex file)" is_ai:false as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Summary" is_ai:false as_artifact:true`
[ ] `sort_bullets job_titles:["Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Development->Microsoft Learning Paths" is_ai:false as_artifact:true`
[ ] `sort_items_within_categories job_titles:["Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior category:"Interests" is_ai:false as_artifact:true`
[ ] `sort_bullets job_titles:["Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Experience->Google" is_ai:false as_artifact:true`

[ ] `sort_bullets job_titles:["Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Experience->Microsoft" is_ai:false as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Experience->Microsoft" is_ai:false as_artifact:true`

[ ] `sort_bullets job_titles:["Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Skills" is_ai:false as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Skills" is_ai:false as_artifact:true notes:"Focus in the text itself and terminology. DO NOT sort anything yourself. Use the order above for the bullets and keep the original order within each category, this is to ease review."`
[ ] `sort_items_within_categories job_titles:["Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Skills" is_ai:false as_artifact:true`
[ ] `list_least_relevant_items job_titles:["Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Skills" is_ai:false as_artifact:true mode:merged n:40`

#### [ ] "Backend Software Engineer" + "Data Software Engineer" + "Distributed Systems Software Engineer"
[ ] `sort_items_within_categories job_titles:["Backend Software Engineer", "Data Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior category:"Education->Bachelor's Degree->Relevant coursework(\newcommand{\RelevantCoursework} in main.tex file)" is_ai:false as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Backend Software Engineer", "Data Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior section:"Professional Summary" is_ai:false as_artifact:true`
[ ] `sort_bullets job_titles:["Backend Software Engineer", "Data Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior section:"Professional Development->Microsoft Learning Paths" is_ai:false as_artifact:true`
[ ] `sort_items_within_categories job_titles:["Backend Software Engineer", "Data Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior category:"Interests" is_ai:false as_artifact:true`
[ ] `sort_bullets job_titles:["Backend Software Engineer", "Data Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior section:"Professional Experience->Google" is_ai:false as_artifact:true`

[ ] `sort_bullets job_titles:["Backend Software Engineer", "Data Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior section:"Professional Experience->Microsoft" is_ai:false as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Backend Software Engineer", "Data Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior section:"Professional Experience->Microsoft" is_ai:false as_artifact:true`


[ ] `sort_bullets job_titles:["Backend Software Engineer", "Data Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior section:"Skills" is_ai:false as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Backend Software Engineer", "Data Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior section:"Skills" is_ai:false as_artifact:true notes:"Focus in the text itself and terminology. DO NOT sort anything yourself. Use the order above for the bullets and keep the original order within each category, this is to ease review."`
[ ] `sort_items_within_categories job_titles:["Backend Software Engineer", "Data Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior section:"Skills" is_ai:false as_artifact:true`
[ ] `list_least_relevant_items job_titles:["Backend Software Engineer", "Data Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior section:"Skills" is_ai:false as_artifact:true mode:merged n:40`

#### [ ] "Backend Software Engineer" + "Data Software Engineer" + "Infrastructure Software Engineer"
[ ] `sort_items_within_categories job_titles:["Backend Software Engineer", "Data Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior category:"Education->Bachelor's Degree->Relevant coursework(\newcommand{\RelevantCoursework} in main.tex file)" is_ai:false as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Backend Software Engineer", "Data Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Summary" is_ai:false as_artifact:true`
[ ] `sort_bullets job_titles:["Backend Software Engineer", "Data Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Development->Microsoft Learning Paths" is_ai:false as_artifact:true`
[ ] `sort_items_within_categories job_titles:["Backend Software Engineer", "Data Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior category:"Interests" is_ai:false as_artifact:true`
[ ] `sort_bullets job_titles:["Backend Software Engineer", "Data Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Experience->Google" is_ai:false as_artifact:true`

[ ] `sort_bullets job_titles:["Backend Software Engineer", "Data Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Experience->Microsoft" is_ai:false as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Backend Software Engineer", "Data Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Experience->Microsoft" is_ai:false as_artifact:true`


[ ] `sort_bullets job_titles:["Backend Software Engineer", "Data Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Skills" is_ai:false as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Backend Software Engineer", "Data Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Skills" is_ai:false as_artifact:true notes:"Focus in the text itself and terminology. DO NOT sort anything yourself. Use the order above for the bullets and keep the original order within each category, this is to ease review."`
[ ] `sort_items_within_categories job_titles:["Backend Software Engineer", "Data Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Skills" is_ai:false as_artifact:true`
[ ] `list_least_relevant_items job_titles:["Backend Software Engineer", "Data Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Skills" is_ai:false as_artifact:true mode:merged n:40`

#### [ ] "Backend Software Engineer" + "Distributed Systems Software Engineer" + "Infrastructure Software Engineer"
[ ] `sort_items_within_categories job_titles:["Backend Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior category:"Education->Bachelor's Degree->Relevant coursework(\newcommand{\RelevantCoursework} in main.tex file)" is_ai:false as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Backend Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Summary" is_ai:false as_artifact:true`
[ ] `sort_bullets job_titles:["Backend Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Development->Microsoft Learning Paths" is_ai:false as_artifact:true`
[ ] `sort_items_within_categories job_titles:["Backend Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior category:"Interests" is_ai:false as_artifact:true`
[ ] `sort_bullets job_titles:["Backend Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Experience->Google" is_ai:false as_artifact:true`

[ ] `sort_bullets job_titles:["Backend Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Experience->Microsoft" is_ai:false as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Backend Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Experience->Microsoft" is_ai:false as_artifact:true`


[ ] `sort_bullets job_titles:["Backend Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Skills" is_ai:false as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Backend Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Skills" is_ai:false as_artifact:true notes:"Focus in the text itself and terminology. DO NOT sort anything yourself. Use the order above for the bullets and keep the original order within each category, this is to ease review."`
[ ] `sort_items_within_categories job_titles:["Backend Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Skills" is_ai:false as_artifact:true`
[ ] `list_least_relevant_items job_titles:["Backend Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Skills" is_ai:false as_artifact:true mode:merged n:40`

#### [ ] "Data Software Engineer" + "Distributed Systems Software Engineer" + "Infrastructure Software Engineer"
[ ] `sort_items_within_categories job_titles:["Data Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior category:"Education->Bachelor's Degree->Relevant coursework(\newcommand{\RelevantCoursework} in main.tex file)" is_ai:false as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Data Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Summary" is_ai:false as_artifact:true`
[ ] `sort_bullets job_titles:["Data Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Development->Microsoft Learning Paths" is_ai:false as_artifact:true`
[ ] `sort_items_within_categories job_titles:["Data Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior category:"Interests" is_ai:false as_artifact:true`
[ ] `sort_bullets job_titles:["Data Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Experience->Google" is_ai:false as_artifact:true`

[ ] `sort_bullets job_titles:["Data Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Experience->Microsoft" is_ai:false as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Data Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Experience->Microsoft" is_ai:false as_artifact:true`


[ ] `sort_bullets job_titles:["Data Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Skills" is_ai:false as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Data Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Skills" is_ai:false as_artifact:true notes:"Focus in the text itself and terminology. DO NOT sort anything yourself. Use the order above for the bullets and keep the original order within each category, this is to ease review."`
[ ] `sort_items_within_categories job_titles:["Data Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Skills" is_ai:false as_artifact:true`
[ ] `list_least_relevant_items job_titles:["Data Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Skills" is_ai:false as_artifact:true mode:merged n:40`

#### [ ] "Backend Software Engineer" + "Data Software Engineer" + "Distributed Systems Software Engineer" + "Infrastructure Software Engineer"
[ ] `sort_items_within_categories job_titles:["Backend Software Engineer", "Data Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior category:"Education->Bachelor's Degree->Relevant coursework(\newcommand{\RelevantCoursework} in main.tex file)" is_ai:false as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Backend Software Engineer", "Data Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Summary" is_ai:false as_artifact:true`
[ ] `sort_bullets job_titles:["Backend Software Engineer", "Data Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Development->Microsoft Learning Paths" is_ai:false as_artifact:true`
[ ] `sort_items_within_categories job_titles:["Backend Software Engineer", "Data Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior category:"Interests" is_ai:false as_artifact:true`
[ ] `sort_bullets job_titles:["Backend Software Engineer", "Data Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Experience->Google" is_ai:false as_artifact:true`

[ ] `sort_bullets job_titles:["Backend Software Engineer", "Data Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Experience->Microsoft" is_ai:false as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Backend Software Engineer", "Data Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Experience->Microsoft" is_ai:false as_artifact:true`

[ ] `sort_bullets job_titles:["Backend Software Engineer", "Data Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Skills" is_ai:false as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Backend Software Engineer", "Data Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Skills" is_ai:false as_artifact:true notes:"Focus in the text itself and terminology. DO NOT sort anything yourself. Use the order above for the bullets and keep the original order within each category, this is to ease review."`
[ ] `sort_items_within_categories job_titles:["Backend Software Engineer", "Data Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Skills" is_ai:false as_artifact:true`
[ ] `list_least_relevant_items job_titles:["Backend Software Engineer", "Data Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Skills" is_ai:false as_artifact:true mode:merged n:40`

#### [X] "Backend Software Engineer" + AI
[X] `sort_bullets job_title:"Backend Software Engineer" seniority_level:senior section:"Education->Bachelor's Degree->Relevant coursework(\newcommand{\RelevantCoursework} in main.tex file)" is_ai:true as_artifact:true`
[X] `suggest_text_improvements job_title:"Backend Software Engineer" job_description:"Same as in $($(ResumeTailoring:001).p)" seniority_level:senior section:"Professional Summary" is_ai:true as_artifact:true`
[X] `sort_bullets job_title:"Backend Software Engineer" job_description:"Same as in $($(ResumeTailoring:001).p)" seniority_level:senior section:"Professional Development->Microsoft Learning Paths" is_ai:true as_artifact:true`
[X] `sort_items_within_categories job_title:"Backend Software Engineer" job_description:"Same as in $($(ResumeTailoring:001).p)" seniority_level:senior category:"Interests" is_ai:true as_artifact:true`
[X] `sort_bullets job_title:"Backend Software Engineer" job_description:"Same as in $($(ResumeTailoring:001).p)" seniority_level:senior section:"Professional Experience->Google" is_ai:true as_artifact:true`

[X] `sort_bullets job_title:"Backend Software Engineer" job_description:"Same as in $($(ResumeTailoring:001).p)" seniority_level:senior section:"Professional Experience->Microsoft" is_ai:true as_artifact:true`
[X] `suggest_text_improvements job_title:"Backend Software Engineer" job_description:"Same as in $($(ResumeTailoring:001).p)" seniority_level:senior section:"Professional Experience->Microsoft" is_ai:true as_artifact:true`

[X] `sort_bullets job_title:"Backend Software Engineer" job_description:"Same as in $($(ResumeTailoring:001).p)" seniority_level:senior section:"Skills" is_ai:true as_artifact:true`
[X] `suggest_text_improvements job_title:"Backend Software Engineer" job_description:"Same as in $($(ResumeTailoring:001).p)" seniority_level:senior section:"Skills" is_ai:true as_artifact:true notes:"Focus in the text itself and terminology. DO NOT sort anything yourself. Use the order above for the bullets and keep the original order within each category, this is to wease review."`
[X] `sort_items_within_categories job_title:"Backend Software Engineer" job_description:"Same as in $($(ResumeTailoring:001).p)" seniority_level:senior is_ai:true as_artifact:true section:"Skills"`
[X] `list_least_relevant_items job_title:"Backend Software Engineer" job_description:"Same as in $($(ResumeTailoring:001).p)" seniority_level:senior mode:merged is_ai:true as_artifact:true section:"Skills" n:40`

#### [ ] "Data Software Engineer" + AI
[ ] `sort_items_within_categories job_title:"Data Software Engineer" seniority_level:senior category:"Education->Bachelor's Degree->Relevant coursework(\newcommand{\RelevantCoursework} in main.tex file)" is_ai:true as_artifact:true`
[ ] `suggest_text_improvements job_title:"Data Software Engineer" seniority_level:senior section:"Professional Summary" is_ai:true as_artifact:true`
[ ] `sort_bullets job_title:"Data Software Engineer" seniority_level:senior section:"Professional Development->Microsoft Learning Paths" is_ai:true as_artifact:true`
[ ] `sort_items_within_categories job_title:"Data Software Engineer" seniority_level:senior category:"Interests" is_ai:true as_artifact:true`
[ ] `sort_bullets job_title:"Data Software Engineer" seniority_level:senior section:"Professional Experience->Google" is_ai:true as_artifact:true`

[ ] `sort_bullets job_title:"Data Software Engineer" seniority_level:senior section:"Professional Experience->Microsoft" is_ai:true as_artifact:true`
[ ] `suggest_text_improvements job_title:"Data Software Engineer" seniority_level:senior section:"Professional Experience->Microsoft" is_ai:true as_artifact:true`


[ ] `sort_bullets job_title:"Data Software Engineer" seniority_level:senior section:"Skills" is_ai:true as_artifact:true`
[ ] `suggest_text_improvements job_title:"Data Software Engineer" seniority_level:senior section:"Skills" is_ai:true as_artifact:true notes:"Focus in the text itself and terminology. DO NOT sort anything yourself. Use the order above for the bullets and keep the original order within each category, this is to ease review."`
[ ] `sort_items_within_categories job_title:"Data Software Engineer" seniority_level:senior section:"Skills" is_ai:true as_artifact:true`
[ ] `list_least_relevant_items job_title:"Data Software Engineer" seniority_level:senior section:"Skills" is_ai:true as_artifact:true mode:merged n:40`

#### [ ] "Distributed Systems Software Engineer" + AI
[ ] `sort_items_within_categories job_title:"Distributed Systems Software Engineer" seniority_level:senior category:"Education->Bachelor's Degree->Relevant coursework(\newcommand{\RelevantCoursework} in main.tex file)" is_ai:true as_artifact:true`
[ ] `suggest_text_improvements job_title:"Distributed Systems Software Engineer" seniority_level:senior section:"Professional Summary" is_ai:true as_artifact:true`
[ ] `sort_bullets job_title:"Distributed Systems Software Engineer" seniority_level:senior section:"Professional Development->Microsoft Learning Paths" is_ai:true as_artifact:true`
[ ] `sort_items_within_categories job_title:"Distributed Systems Software Engineer" seniority_level:senior category:"Interests" is_ai:true as_artifact:true`
[ ] `sort_bullets job_title:"Distributed Systems Software Engineer" seniority_level:senior section:"Professional Experience->Google" is_ai:true as_artifact:true`

[ ] `sort_bullets job_title:"Distributed Systems Software Engineer" seniority_level:senior section:"Professional Experience->Microsoft" is_ai:true as_artifact:true`
[ ] `suggest_text_improvements job_title:"Distributed Systems Software Engineer" seniority_level:senior section:"Professional Experience->Microsoft" is_ai:true as_artifact:true`


[ ] `sort_bullets job_title:"Distributed Systems Software Engineer" seniority_level:senior section:"Skills" is_ai:true as_artifact:true`
[ ] `suggest_text_improvements job_title:"Distributed Systems Software Engineer" seniority_level:senior section:"Skills" is_ai:true as_artifact:true notes:"Focus in the text itself and terminology. DO NOT sort anything yourself. Use the order above for the bullets and keep the original order within each category, this is to ease review."`
[ ] `sort_items_within_categories job_title:"Distributed Systems Software Engineer" seniority_level:senior section:"Skills" is_ai:true as_artifact:true`
[ ] `list_least_relevant_items job_title:"Distributed Systems Software Engineer" seniority_level:senior section:"Skills" is_ai:true as_artifact:true mode:merged n:40`

#### [ ] "Infrastructure Software Engineer" + AI
[ ] `sort_items_within_categories job_title:"Infrastructure Software Engineer" seniority_level:senior category:"Education->Bachelor's Degree->Relevant coursework(\newcommand{\RelevantCoursework} in main.tex file)" is_ai:true as_artifact:true`
[ ] `suggest_text_improvements job_title:"Infrastructure Software Engineer" seniority_level:senior section:"Professional Summary" is_ai:true as_artifact:true`
[ ] `sort_bullets job_title:"Infrastructure Software Engineer" seniority_level:senior section:"Professional Development->Microsoft Learning Paths" is_ai:true as_artifact:true`
[ ] `sort_items_within_categories job_title:"Infrastructure Software Engineer" seniority_level:senior category:"Interests" is_ai:true as_artifact:true`
[ ] `sort_bullets job_title:"Infrastructure Software Engineer" seniority_level:senior section:"Professional Experience->Google" is_ai:true as_artifact:true`

[ ] `sort_bullets job_title:"Infrastructure Software Engineer" seniority_level:senior section:"Professional Experience->Microsoft" is_ai:true as_artifact:true`
[ ] `suggest_text_improvements job_title:"Infrastructure Software Engineer" seniority_level:senior section:"Professional Experience->Microsoft" is_ai:true as_artifact:true`


[ ] `sort_bullets job_title:"Infrastructure Software Engineer" seniority_level:senior section:"Skills" is_ai:true as_artifact:true`
[ ] `suggest_text_improvements job_title:"Infrastructure Software Engineer" seniority_level:senior section:"Skills" is_ai:true as_artifact:true notes:"Focus in the text itself and terminology. DO NOT sort anything yourself. Use the order above for the bullets and keep the original order within each category, this is to ease review."`
[ ] `sort_items_within_categories job_title:"Infrastructure Software Engineer" seniority_level:senior section:"Skills" is_ai:true as_artifact:true`
[ ] `list_least_relevant_items job_title:"Infrastructure Software Engineer" seniority_level:senior section:"Skills" is_ai:true as_artifact:true mode:merged n:40`

#### [ ] "Backend Software Engineer" + "Data Software Engineer" + AI
[ ] `sort_items_within_categories job_titles:["Backend Software Engineer", "Data Software Engineer"] seniority_level:senior category:"Education->Bachelor's Degree->Relevant coursework(\newcommand{\RelevantCoursework} in main.tex file)" is_ai:true as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Backend Software Engineer", "Data Software Engineer"] seniority_level:senior section:"Professional Summary" is_ai:true as_artifact:true`
[ ] `sort_bullets job_titles:["Backend Software Engineer", "Data Software Engineer"] seniority_level:senior section:"Professional Development->Microsoft Learning Paths" is_ai:true as_artifact:true`
[ ] `sort_items_within_categories job_titles:["Backend Software Engineer", "Data Software Engineer"] seniority_level:senior category:"Interests" is_ai:true as_artifact:true`
[ ] `sort_bullets job_titles:["Backend Software Engineer", "Data Software Engineer"] seniority_level:senior section:"Professional Experience->Google" is_ai:true as_artifact:true`

[ ] `sort_bullets job_titles:["Backend Software Engineer", "Data Software Engineer"] seniority_level:senior section:"Professional Experience->Microsoft" is_ai:true as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Backend Software Engineer", "Data Software Engineer"] seniority_level:senior section:"Professional Experience->Microsoft" is_ai:true as_artifact:true`


[ ] `sort_bullets job_titles:["Backend Software Engineer", "Data Software Engineer"] seniority_level:senior section:"Skills" is_ai:true as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Backend Software Engineer", "Data Software Engineer"] seniority_level:senior section:"Skills" is_ai:true as_artifact:true notes:"Focus in the text itself and terminology. DO NOT sort anything yourself. Use the order above for the bullets and keep the original order within each category, this is to ease review."`
[ ] `sort_items_within_categories job_titles:["Backend Software Engineer", "Data Software Engineer"] seniority_level:senior section:"Skills" is_ai:true as_artifact:true`
[ ] `list_least_relevant_items job_titles:["Backend Software Engineer", "Data Software Engineer"] seniority_level:senior section:"Skills" is_ai:true as_artifact:true mode:merged n:40`

#### [ ] "Backend Software Engineer" + "Distributed Systems Software Engineer" + AI
[ ] `sort_items_within_categories job_titles:["Backend Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior category:"Education->Bachelor's Degree->Relevant coursework(\newcommand{\RelevantCoursework} in main.tex file)" is_ai:true as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Backend Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior section:"Professional Summary" is_ai:true as_artifact:true`
[ ] `sort_bullets job_titles:["Backend Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior section:"Professional Development->Microsoft Learning Paths" is_ai:true as_artifact:true`
[ ] `sort_items_within_categories job_titles:["Backend Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior category:"Interests" is_ai:true as_artifact:true`
[ ] `sort_bullets job_titles:["Backend Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior section:"Professional Experience->Google" is_ai:true as_artifact:true`

[ ] `sort_bullets job_titles:["Backend Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior section:"Professional Experience->Microsoft" is_ai:true as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Backend Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior section:"Professional Experience->Microsoft" is_ai:true as_artifact:true`


[ ] `sort_bullets job_titles:["Backend Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior section:"Skills" is_ai:true as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Backend Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior section:"Skills" is_ai:true as_artifact:true notes:"Focus in the text itself and terminology. DO NOT sort anything yourself. Use the order above for the bullets and keep the original order within each category, this is to ease review."`
[ ] `sort_items_within_categories job_titles:["Backend Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior section:"Skills" is_ai:true as_artifact:true`
[ ] `list_least_relevant_items job_titles:["Backend Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior section:"Skills" is_ai:true as_artifact:true mode:merged n:40`

#### [ ] "Backend Software Engineer" + "Infrastructure Software Engineer" + AI
[ ] `sort_items_within_categories job_titles:["Backend Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior category:"Education->Bachelor's Degree->Relevant coursework(\newcommand{\RelevantCoursework} in main.tex file)" is_ai:true as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Backend Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Summary" is_ai:true as_artifact:true`
[ ] `sort_bullets job_titles:["Backend Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Development->Microsoft Learning Paths" is_ai:true as_artifact:true`
[ ] `sort_items_within_categories job_titles:["Backend Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior category:"Interests" is_ai:true as_artifact:true`
[ ] `sort_bullets job_titles:["Backend Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Experience->Google" is_ai:true as_artifact:true`

[ ] `sort_bullets job_titles:["Backend Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Experience->Microsoft" is_ai:true as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Backend Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Experience->Microsoft" is_ai:true as_artifact:true`


[ ] `sort_bullets job_titles:["Backend Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Skills" is_ai:true as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Backend Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Skills" is_ai:true as_artifact:true notes:"Focus in the text itself and terminology. DO NOT sort anything yourself. Use the order above for the bullets and keep the original order within each category, this is to ease review."`
[ ] `sort_items_within_categories job_titles:["Backend Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Skills" is_ai:true as_artifact:true`
[ ] `list_least_relevant_items job_titles:["Backend Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Skills" is_ai:true as_artifact:true mode:merged n:40`

#### [ ] "Data Software Engineer" + "Distributed Systems Software Engineer" + AI
[ ] `sort_items_within_categories job_titles:["Data Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior category:"Education->Bachelor's Degree->Relevant coursework(\newcommand{\RelevantCoursework} in main.tex file)" is_ai:true as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Data Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior section:"Professional Summary" is_ai:true as_artifact:true`
[ ] `sort_bullets job_titles:["Data Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior section:"Professional Development->Microsoft Learning Paths" is_ai:true as_artifact:true`
[ ] `sort_items_within_categories job_titles:["Data Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior category:"Interests" is_ai:true as_artifact:true`
[ ] `sort_bullets job_titles:["Data Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior section:"Professional Experience->Google" is_ai:true as_artifact:true`

[ ] `sort_bullets job_titles:["Data Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior section:"Professional Experience->Microsoft" is_ai:true as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Data Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior section:"Professional Experience->Microsoft" is_ai:true as_artifact:true`


[ ] `sort_bullets job_titles:["Data Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior section:"Skills" is_ai:true as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Data Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior section:"Skills" is_ai:true as_artifact:true notes:"Focus in the text itself and terminology. DO NOT sort anything yourself. Use the order above for the bullets and keep the original order within each category, this is to ease review."`
[ ] `sort_items_within_categories job_titles:["Data Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior section:"Skills" is_ai:true as_artifact:true`
[ ] `list_least_relevant_items job_titles:["Data Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior section:"Skills" is_ai:true as_artifact:true mode:merged n:40`

#### [ ] "Data Software Engineer" + "Infrastructure Software Engineer" + AI
[ ] `sort_items_within_categories job_titles:["Data Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior category:"Education->Bachelor's Degree->Relevant coursework(\newcommand{\RelevantCoursework} in main.tex file)" is_ai:true as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Data Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Summary" is_ai:true as_artifact:true`
[ ] `sort_bullets job_titles:["Data Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Development->Microsoft Learning Paths" is_ai:true as_artifact:true`
[ ] `sort_items_within_categories job_titles:["Data Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior category:"Interests" is_ai:true as_artifact:true`
[ ] `sort_bullets job_titles:["Data Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Experience->Google" is_ai:true as_artifact:true`

[ ] `sort_bullets job_titles:["Data Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Experience->Microsoft" is_ai:true as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Data Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Experience->Microsoft" is_ai:true as_artifact:true`


[ ] `sort_bullets job_titles:["Data Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Skills" is_ai:true as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Data Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Skills" is_ai:true as_artifact:true notes:"Focus in the text itself and terminology. DO NOT sort anything yourself. Use the order above for the bullets and keep the original order within each category, this is to ease review."`
[ ] `sort_items_within_categories job_titles:["Data Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Skills" is_ai:true as_artifact:true`
[ ] `list_least_relevant_items job_titles:["Data Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Skills" is_ai:true as_artifact:true mode:merged n:40`

#### [ ] "Distributed Systems Software Engineer" + "Infrastructure Software Engineer" + AI
[ ] `sort_items_within_categories job_titles:["Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior category:"Education->Bachelor's Degree->Relevant coursework(\newcommand{\RelevantCoursework} in main.tex file)" is_ai:true as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Summary" is_ai:true as_artifact:true`
[ ] `sort_bullets job_titles:["Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Development->Microsoft Learning Paths" is_ai:true as_artifact:true`
[ ] `sort_items_within_categories job_titles:["Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior category:"Interests" is_ai:true as_artifact:true`
[ ] `sort_bullets job_titles:["Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Experience->Google" is_ai:true as_artifact:true`

[ ] `sort_bullets job_titles:["Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Experience->Microsoft" is_ai:true as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Experience->Microsoft" is_ai:true as_artifact:true`


[ ] `sort_bullets job_titles:["Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Skills" is_ai:true as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Skills" is_ai:true as_artifact:true notes:"Focus in the text itself and terminology. DO NOT sort anything yourself. Use the order above for the bullets and keep the original order within each category, this is to ease review."`
[ ] `sort_items_within_categories job_titles:["Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Skills" is_ai:true as_artifact:true`
[ ] `list_least_relevant_items job_titles:["Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Skills" is_ai:true as_artifact:true mode:merged n:40`

#### [ ] "Backend Software Engineer" + "Data Software Engineer" + "Distributed Systems Software Engineer" + AI
[ ] `sort_items_within_categories job_titles:["Backend Software Engineer", "Data Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior category:"Education->Bachelor's Degree->Relevant coursework(\newcommand{\RelevantCoursework} in main.tex file)" is_ai:true as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Backend Software Engineer", "Data Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior section:"Professional Summary" is_ai:true as_artifact:true`
[ ] `sort_bullets job_titles:["Backend Software Engineer", "Data Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior section:"Professional Development->Microsoft Learning Paths" is_ai:true as_artifact:true`
[ ] `sort_items_within_categories job_titles:["Backend Software Engineer", "Data Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior category:"Interests" is_ai:true as_artifact:true`
[ ] `sort_bullets job_titles:["Backend Software Engineer", "Data Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior section:"Professional Experience->Google" is_ai:true as_artifact:true`

[ ] `sort_bullets job_titles:["Backend Software Engineer", "Data Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior section:"Professional Experience->Microsoft" is_ai:true as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Backend Software Engineer", "Data Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior section:"Professional Experience->Microsoft" is_ai:true as_artifact:true`


[ ] `sort_bullets job_titles:["Backend Software Engineer", "Data Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior section:"Skills" is_ai:true as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Backend Software Engineer", "Data Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior section:"Skills" is_ai:true as_artifact:true notes:"Focus in the text itself and terminology. DO NOT sort anything yourself. Use the order above for the bullets and keep the original order within each category, this is to ease review."`
[ ] `sort_items_within_categories job_titles:["Backend Software Engineer", "Data Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior section:"Skills" is_ai:true as_artifact:true`
[ ] `list_least_relevant_items job_titles:["Backend Software Engineer", "Data Software Engineer", "Distributed Systems Software Engineer"] seniority_level:senior section:"Skills" is_ai:true as_artifact:true mode:merged n:40`

#### [ ] "Backend Software Engineer" + "Data Software Engineer" + "Infrastructure Software Engineer" + AI
[ ] `sort_items_within_categories job_titles:["Backend Software Engineer", "Data Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior category:"Education->Bachelor's Degree->Relevant coursework(\newcommand{\RelevantCoursework} in main.tex file)" is_ai:true as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Backend Software Engineer", "Data Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Summary" is_ai:true as_artifact:true`
[ ] `sort_bullets job_titles:["Backend Software Engineer", "Data Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Development->Microsoft Learning Paths" is_ai:true as_artifact:true`
[ ] `sort_items_within_categories job_titles:["Backend Software Engineer", "Data Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior category:"Interests" is_ai:true as_artifact:true`
[ ] `sort_bullets job_titles:["Backend Software Engineer", "Data Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Experience->Google" is_ai:true as_artifact:true`

[ ] `sort_bullets job_titles:["Backend Software Engineer", "Data Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Experience->Microsoft" is_ai:true as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Backend Software Engineer", "Data Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Experience->Microsoft" is_ai:true as_artifact:true`


[ ] `sort_bullets job_titles:["Backend Software Engineer", "Data Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Skills" is_ai:true as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Backend Software Engineer", "Data Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Skills" is_ai:true as_artifact:true notes:"Focus in the text itself and terminology. DO NOT sort anything yourself. Use the order above for the bullets and keep the original order within each category, this is to ease review."`
[ ] `sort_items_within_categories job_titles:["Backend Software Engineer", "Data Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Skills" is_ai:true as_artifact:true`
[ ] `list_least_relevant_items job_titles:["Backend Software Engineer", "Data Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Skills" is_ai:true as_artifact:true mode:merged n:40`

#### [ ] "Backend Software Engineer" + "Distributed Systems Software Engineer" + "Infrastructure Software Engineer" + AI
[ ] `sort_items_within_categories job_titles:["Backend Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior category:"Education->Bachelor's Degree->Relevant coursework(\newcommand{\RelevantCoursework} in main.tex file)" is_ai:true as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Backend Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Summary" is_ai:true as_artifact:true`
[ ] `sort_bullets job_titles:["Backend Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Development->Microsoft Learning Paths" is_ai:true as_artifact:true`
[ ] `sort_items_within_categories job_titles:["Backend Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior category:"Interests" is_ai:true as_artifact:true`
[ ] `sort_bullets job_titles:["Backend Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Experience->Google" is_ai:true as_artifact:true`

[ ] `sort_bullets job_titles:["Backend Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Experience->Microsoft" is_ai:true as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Backend Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Experience->Microsoft" is_ai:true as_artifact:true`


[ ] `sort_bullets job_titles:["Backend Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Skills" is_ai:true as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Backend Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Skills" is_ai:true as_artifact:true notes:"Focus in the text itself and terminology. DO NOT sort anything yourself. Use the order above for the bullets and keep the original order within each category, this is to ease review."`
[ ] `sort_items_within_categories job_titles:["Backend Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Skills" is_ai:true as_artifact:true`
[ ] `list_least_relevant_items job_titles:["Backend Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Skills" is_ai:true as_artifact:true mode:merged n:40`

#### [ ] "Data Software Engineer" + "Distributed Systems Software Engineer" + "Infrastructure Software Engineer" + AI
[ ] `sort_items_within_categories job_titles:["Data Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior category:"Education->Bachelor's Degree->Relevant coursework(\newcommand{\RelevantCoursework} in main.tex file)" is_ai:true as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Data Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Summary" is_ai:true as_artifact:true`
[ ] `sort_bullets job_titles:["Data Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Development->Microsoft Learning Paths" is_ai:true as_artifact:true`
[ ] `sort_items_within_categories job_titles:["Data Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior category:"Interests" is_ai:true as_artifact:true`
[ ] `sort_bullets job_titles:["Data Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Experience->Google" is_ai:true as_artifact:true`

[ ] `sort_bullets job_titles:["Data Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Experience->Microsoft" is_ai:true as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Data Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Experience->Microsoft" is_ai:true as_artifact:true`


[ ] `sort_bullets job_titles:["Data Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Skills" is_ai:true as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Data Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Skills" is_ai:true as_artifact:true notes:"Focus in the text itself and terminology. DO NOT sort anything yourself. Use the order above for the bullets and keep the original order within each category, this is to ease review."`
[ ] `sort_items_within_categories job_titles:["Data Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Skills" is_ai:true as_artifact:true`
[ ] `list_least_relevant_items job_titles:["Data Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Skills" is_ai:true as_artifact:true mode:merged n:40`

#### [ ] "Backend Software Engineer" + "Data Software Engineer" + "Distributed Systems Software Engineer" + "Infrastructure Software Engineer" + AI
[ ] `sort_items_within_categories job_titles:["Backend Software Engineer", "Data Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior category:"Education->Bachelor's Degree->Relevant coursework(\newcommand{\RelevantCoursework} in main.tex file)" is_ai:true as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Backend Software Engineer", "Data Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Summary" is_ai:true as_artifact:true`
[ ] `sort_bullets job_titles:["Backend Software Engineer", "Data Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Development->Microsoft Learning Paths" is_ai:true as_artifact:true`
[ ] `sort_items_within_categories job_titles:["Backend Software Engineer", "Data Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior category:"Interests" is_ai:true as_artifact:true`
[ ] `sort_bullets job_titles:["Backend Software Engineer", "Data Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Experience->Google" is_ai:true as_artifact:true`

[ ] `sort_bullets job_titles:["Backend Software Engineer", "Data Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Experience->Microsoft" is_ai:true as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Backend Software Engineer", "Data Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Professional Experience->Microsoft" is_ai:true as_artifact:true`


[ ] `sort_bullets job_titles:["Backend Software Engineer", "Data Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Skills" is_ai:true as_artifact:true`
[ ] `suggest_text_improvements job_titles:["Backend Software Engineer", "Data Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Skills" is_ai:true as_artifact:true notes:"Focus in the text itself and terminology. DO NOT sort anything yourself. Use the order above for the bullets and keep the original order within each category, this is to ease review."`
[ ] `sort_items_within_categories job_titles:["Backend Software Engineer", "Data Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Skills" is_ai:true as_artifact:true`
[ ] `list_least_relevant_items job_titles:["Backend Software Engineer", "Data Software Engineer", "Distributed Systems Software Engineer", "Infrastructure Software Engineer"] seniority_level:senior section:"Skills" is_ai:true as_artifact:true mode:merged n:40`
