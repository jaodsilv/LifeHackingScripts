# Commands
SCOPE: project

```
prepare_resume_step_by_step [job_posting_filenames:(comma separated list of filenames)] [job_posting_source:(attachment|project|pasted|generic|job_description_parameter)] [base:resume_filenames] [base_source:(project|attachment)] [job_descriptions:(comma separated list of job descriptions)] [job_titles:(comma separated list of job titles)] [skip_to_step:step_number] [options]
```
* Runs the command series below. Prepares a single resume aimed for a set of job postings mentioned.
* Either job_posting_filenames or job_description or job_titles must be present.
* You must keep the ATS in mind at all times.
* If source option is not given, defaults to 'attachment'.
* if `base` resume filenames option is not given, defaults to ['main.tex', '\d\.(\d\.)?[a-zA-Z]+\.tex']
* if `base_source` option is not given, defaults to 'project'.
* If files are not found, request to upload the files, do not search on the web or in your knowledge.
* You should perform ONLY STEP 1 at the time of this command.
* Include a tracking of the steps performed in the command, something visual in the text body, not including it in the outputted artifacts.
    * This tracking should include:
        * Last Step Completed number and name.
        * Current step number and name.
        * Next step number and name.
        * A progress bar considering since step 1, even if we skip steps.

```
next_step [options]
```
Move to the next step of the process
Only move to the next step when receiving this command.

# General instructions
* Avoid extra explanations, give just the results
* Fill the gaps for lower level instructions

# Script & paths
## Step 1: Base Knowledge & Setup
```python
print("# Step 1: Base Knowledge & Setup")
```

```
load_knowledge $base from $base_source
```

```python
class JobPost:
    def __init__(self, raw_text):
        self.parsed_content = lazy_parse_job_postiong(raw_text)
        self.title = parsed_content["title"]
        self.raw = raw_text
        self.keywords = []
        self.min_requirements = []
        self.optional_requirements = []
        self.match_level = 0.0
        self.offer_range_min = 0
        self.offer_range_max = 0
        self.job_review = ""
        self.plan = ""

    def extract_keywords(self):
        self.keywords = $(extract_keywords $self.parsed_content)
        return self.keywords

    def extract_requirements(self):
        self.min_requirements = self.parsed_content.find_min_requirements()
        self.optional_requirements = self.parsed_content.find_optional_requirements()

    def compute_match_level(self, cv):
        self.match_level = self.compute_match(cv)

    def extract_pay_range(self):
        self.offer_range_min, self.offer_range_max = self.parsed_content.find_pay_range()

    def analyze_job(self, cv):
        self.extract_requirements()
        self.extract_pay_range()
        self.compute_match_level()
        self.job_review =  $(job_analysis job_description:$self)
        return self.job_review

job_posts=[]
for i, filename in enumerate(job_posting_filenames):
    job_posts[i] = $(load_knowledge $filename from $source)
```

```
wait_command next_step
```

# Step 2: Keyword Extraction
```python
print("# Step 2: Keyword Extraction")
for job_post in job_posts:
    print(f"## {job_post.title}")
    print(job_post.extract_keywords())
```

```
wait_command next_step
```

# Step 3: Job Analysis
```python
print("# Step 3: Job Analysis")
for job_post in job_posts:
    print(f"## {job_post.title}")
    print(job_post.analyze_job(cv))
```

```
wait_command next_step
```

# Step 4:Rank Positions 
```python
print("# Step 4: Ranking")
```
This will be a priority for tailoring the resume.

```
rank_job_positions $job_posts output:artifact
```

```python
job_posts.sort(key: lambda x: x.match_level)
```

```
wait_command next_step
```

# Step 5: Resume Tailoring - Adjusting Terminology
```python
print("Starting Resume Tailoring\n\n# Step 5: Resume Tailoring - Adjusting Terminology")
```

Scan through ALL the resume files and adjust the terminology to match the job posting.

# Step 6: Resume Tailoring - Sorting Languages
```python
print("# Step 6: Resume Tailoring - Sorting Languages")
```

```
sort_items_within_categories job_title:Infer seniority_level:senior category:"main.tex->\LanguagesOrderSummary" is_ai:infer as_artifact:true
```

```
sort_items_within_categories job_title:Infer seniority_level:senior category:"main.tex->\LanguagesOrderSkills" is_ai:infer as_artifact:true
```

```
wait_command response_map or next_step
```

# Step 7: Resume Tailoring - Sorting Coursework
```python
print("# Step 7: Resume Tailoring - Sorting Coursework")
```

```
sort_items_within_categories job_title:Infer seniority_level:senior category:"Education->Bachelor's Degree->Relevant coursework(\newcommand{\RelevantCoursework} in main.tex file)" is_ai:infer as_artifact:true
```
```
wait_command response_map or next_step
```

# Step 8: Resume Tailoring - Suggesting Professional Summary Improvements
```python
print("# Step 8: Resume Tailoring - Suggesting Professional Summary Improvements")
```

```
suggest_text_improvements job_title:Infer seniority_level:senior section:"Professional Summary" is_ai:infer as_artifact:true
```

```
wait_command response_map or next_step
```

# Step 9: Resume Tailoring - Sorting Professional Development
```python
print("# Step 9: Resume Tailoring - Sorting Professional Development Microsoft Learning Paths")
```

```
sort_bullets job_title:Infer seniority_level:senior section:"Professional Development->Microsoft Learning Paths" is_ai:infer as_artifact:true
```

```
wait_command response_map or next_step
```

# Step 10: Resume Tailoring - Sorting Interests
```python
print("# Step 10: Resume Tailoring - Sorting Interests")
```

```
sort_items_within_categories job_title:Infer seniority_level:senior category:"Interests" is_ai:infer as_artifact:true
```

```
wait_command response_map or next_step
```

# Step 11: Resume Tailoring - Sorting Google Professional Experience
```python
print("# Step 11: Resume Tailoring - Sorting Professional Experience - Google")
```

```
sort_bullets job_title:Infer seniority_level:senior section:"Professional Experience->Google" is_ai:infer as_artifact:true
```

```
wait_command response_map or next_step
```

# Step 12: Resume Tailoring - Suggesting Text Improvements for Professional Experience - Microsoft
```python
print("# Step 12: Resume Tailoring - Suggesting Text Improvements for Professional Experience - Microsoft")
```

```
suggest_text_improvements job_title:Infer seniority_level:senior section:"Professional Experience->Microsoft" is_ai:infer as_artifact:true notes:"Focus in the text itself and terminology. DO NOT sort anything yourself. Use the order above for the bullets and keep the original order within each category, this is to ease review. I do not have more data with numbers other than what is already written, therefore you should not suggest any numbers."
```

# Step 13: Resume Tailoring - Sorting Professional Experience - Microsoft
```python
print("# Step 13: Resume Tailoring - Sorting Professional Experience - Microsoft")
```

```
sort_bullets job_title:Infer seniority_level:senior section:"Professional Experience->Microsoft" is_ai:infer as_artifact:true notes:"Do not forget to read and include comments present in the file. Include comments in the output regarding the priority used in this sorting."
```

```
wait_command response_map or next_step
```

# Step 14: Resume Tailoring - Sorting Skill Categories
```python
print("# Step 14: Resume Tailoring - Sorting Skill Categories")
```

```
sort_bullets job_title:Infer seniority_level:senior section:"Skills" is_ai:infer as_artifact:true notes:"Sort categories only, do not sort the items within each category."
```

```
wait_command response_map or next_step
```

# Step 15: Resume Tailoring - Suggesting Text Improvements for Skills
```python
print("# Step 15: Resume Tailoring - Suggesting Text Improvements for Skills")
```

```
suggest_text_improvements job_title:Infer seniority_level:senior section:"Skills" is_ai:infer as_artifact:true notes:"Focus in the text itself and terminology. DO NOT sort anything yourself. Use the order above for the bullets and keep the original order within each category, this is to ease review."
```

```
wait_command response_map or next_step
```

# Step 16: Resume Tailoring - Sorting Skills in each category
```python
print("# Step 16: Resume Tailoring - Sorting Skills in each category")
```

```
sort_items_within_categories job_title:Infer seniority_level:senior section:"Skills" is_ai:infer as_artifact:true
```

```
wait_command response_map or next_step
```

# Step 17: Resume Tailoring - Evaluate ATS Parseability
```python
print("# Step 17: Resume Tailoring - Evaluate ATS Parseability")
```

Check if the resume is fully parseable by ATS systems.
Focus on formatting, layout, etc. Avoid content.
Be very concise, no need for explanations. Just suggest the changes if any.

# Step 18: Resume Tailoring - List Least Relevant Skills
```python
print("# Step 18: Resume Tailoring - List Least Relevant Skills")
```

```
list_least_relevant_items job_title:Infer seniority_level:senior section:"Skills" is_ai:infer as_artifact:true mode:merged n:40
```

```
wait_command response_map or next_step
```

# Step 19: Resume Tailoring - Tailor to fit space
This is a two step process.
1. ask information about the current state of the resume
2. tailor to fit space

# Step 19.1: Resume Tailoring - Prompt for current state
```python
print("# Step 19: Resume Tailoring - Tailor to fit space")
print("## Step 19.1: Resume Tailoring - Prompt for current state")
print("Please provide information about the current state of the resume compiled from this tailoring process.")
```

```
wait_command response
```

# Step 19.2: Resume Tailoring - Tailor to fit space
```python
print("## Step 19.2: Resume Tailoring - Tailor to fit space")
```

```
tailor_to_fit_space source:context_window goal:fit_2_pages current_state:$response
```

```
wait_command response_map or next_step
```

# Step 20: Resume Tailoring - Count words and tailor for vocabulary adjustment
This is a two step process.
Count the words in the resume and tailor for vocabulary adjustment.
The goal is to avoid repeating the same words in the resume too much. Centain level of repetition is acceptable.

## Step 19.1: Resume Tailoring - Find words with repetitions
Finds words with repetitions in the Resume. Outputs a list of words and the number of times they appear in the Resume and in the same bullet when applicable.

```python
print("# Step 20: Resume Tailoring - Reducing Word Repetitions")
print("## Step 20.1: Resume Tailoring - Find words with repetitions")
```

```
find_repetitions job_title:Infer seniority_level:senior section:"all" is_ai:infer as_artifact:true max_length:1000 threshold:4 threshold_same_bullet:2
```

```
wait_command response_map or next_step
```

## Step 19.2: Resume Tailoring - Reduce word repetitions
This step is to reduce word repetitions in the Resume.

```python
print("## Step 20.2: Resume Tailoring - Reduce word repetitions")
```

```
suggest_text_improvements job_title:Infer seniority_level:senior section:"all" is_ai:infer as_artifact:true notes:"Focus in the text itself and terminology to reduce word repetitions. DO NOT sort anything yourself"
```

```
wait_command response_map
```
