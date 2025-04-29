# Job Positioning Commands
SCOPE: project

```
rank_job_positions
```
Ranks positions based on CV fit

```
job_analysis [options]
```
Compares CV against job descriptions:
- `job_description_url:$url` - Job posting URL
- `job_description:$text` - Job description text

```
keyword_extract [options]
```
Extracts key terms from job postings:
- `source:$text_or_url` - Source text or URL
- `count:$number` - Number of terms to extract (default: 15)
