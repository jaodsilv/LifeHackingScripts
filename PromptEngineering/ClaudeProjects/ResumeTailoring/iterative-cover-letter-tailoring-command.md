# Commands
SCOPE: project

```
prepare_cover_letter_step_by_step job_posting_filenames [source:(attachment|project)] [cv:cv_filename] [cv_source:(project|attachment)] [options]
```
Runs the command series below. Prepares cover letters for all job postings mentioned.
job_posting_filenames is a required comma separated list of filenames.
If source option is not given, defaults to 'attachment'.
if cv filename option is not given, defaults to ['main.tex', '\d\.(\d\.)?[a-zA-Z]+\.tex']
if cv_source option is not given, defaults to 'project'.
If files are not found, request to upload the files, do not search on the web or in your knowledge.

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
load_knowledge $cv from $cv_source
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

```
rank_job_positions $job_posts output:artifact
```

```python
job_posts.sort(key: lambda x: x.match_level)
```

```
wait_command next_step
```

# Step 5: Cover letters Plans
```python
print("# Step 5: Cover Letter Plans")
for i, job_post in enumerate(job_posts):
    print(f"## {i}. {job_post.title}")
    job_post.plan = $(print_coverletter_plan position:$job_post)

class Response:
    def __init__(self, index, approval, comments):
        self.index = index
        self.approval = approval
        self.comments = comments
```

```
wait_command response_map or next_step
```

# Step 5.1: Adjust Plans
```python
if context.command == "next_step"
    for i, job_post in enumerate(job_posts):
        responses[job_post] = Response(i, True, "")
    $(next_step)
    return

has_job_to_adjust = False

for job_post, response in responses:
    if not response.approval:
        if not has_job_to_adjust:
            has_job_to_adjust = True
            print("# Step 5.1: Adjust Plans")
        # Note that this index may have gaps, as only not approved plans are printed again.
        print(f"## {response.index}. {job_post.title}")
        job_post.plan = $(print_coverletter_plan position:$job_post comments:$response.comments)
if not has_job_to_adjust:
    $(next_step)
else:
    $(wait_command response_map or next_step)
    $(Go to "Step 5.1: Adjust Plans")
```

# Step 6: Write Cover Letters
```python
print("# Step 6: Write Cover Letters")
for i, job_post in enumerate(job_posts):
    print(f"## {response.index}. {job_post.title}")
    $(write_coverletter position:$job_post)
    if  i == 3:
        return
```