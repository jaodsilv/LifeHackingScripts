# Job Search Keywords Analysis Project

## Project Overview
This project analyzes job postings from specific companies to identify key skills and requirements for specific engineering roles. The goal is to create comprehensive data on keyword frequency across different job titles to guide career development and job application strategies.

## Base files to consider


## Methodology
- Follow a very precise and strict step-by-step process. AI here serves to fill the gaps of parsing and filling data from these job posts into our data structures.

- Web searches are performed for job postings from target companies in King and Snohomish Counties, Washington state or remote job postings from target companies in Washington state.

- Keywords are extracted from requirements sections, preferred qualifications, and introductory descriptions
- Blacklisted terms are excluded from analysis
- Similar terms are merged to prevent fragmentation
- You should finish all job Position Names for a specific company before moving to the next company.
- You must limit yourself to a single search for each job position-company pair, 1 search for 
- You should ignore any job position that is too far from 5 in the list, e.g., Hardware Engineering.
- You should be as strict as possible when choosing the terms for the searches to not induce posts with specific words, creating a vies in the fetched data.
- No analisys over the data is needed yet, only consuming the data and building the table.
- If searching for a position and another position appears in the search results that should be considered, but in the correct category.
- Once a keyword was presented in Newly Found Keywords list it should not be present again in the next iteration.
- Update keyword frequency data with new findings
- Merge similar keywords only when requested
- Avoid searching for positions from Google/Alphabet, Meta/Facebook, Microsoft and their direct subsidiaries
- Avoid Amazon Web Services positions while retaining other Amazon divisions
- Focus on extracting both technical skills and soft skills keywords
- If a keyword appears twice or more in the same post:
    - If the sentence is the same count only once, this might be just a copy-paste.
    - If the sentence is different count twice, as it shows how important it is to the job post.
- The final output should be an Artifact, concise and exact.
    - Wait for the command `print` to print the output. Do not print it at each iteration.
- I am being very precise with the wording on `print` vs other actions. Do not print what was not requested. Do everything to the letter.

### Job Position Categories
1. Senior Backend Software Engineer
2. Senior Software Engineer  
3. Senior Data Engineer
4. Senior Distributed Systems Engineer
5. Infrastructure Software Engineer
6. Others (variations of these positions, these should not be searched directly, but they should have their own column in the frequencies table)

### Job Posts Restrictions
- Only include Job Posts that require between 3 and 9 years of experience.
- Exclude Job Posts that require 10+ or more years of experience.
- Exclude Job Posts that require 2 or less years of experience.
- Only include job posts within the titles in "Job Posts Categories", accepting small variations.
- If a different Job Post is found within the results, ask before adding it to the table.
- It is ok to have 0 relevant results for a search query.

### Search Queries Restrictions
- Use neutral search terms to ensure unbiased results collection.
- For each unfinished company store the name of the positions and other information so you don't look twice in the same job post, e.g., if a job post was posted on LinkedIn and at the company's career page.
    - Once we have looked into all job posts for a single company you can drop this knowledge.
    - This knowledge should be stored on your side and not printed. This approach will enable you to effectively drop the knowledge when finished.

### Data Processing
- Extract keywords from:
    - Required qualifications
    - Preferred qualifications
    - Introductory role descriptions
    - Technical requirements
- Focus on correctness of the process rather than analyzing the data.

## Response Template
```
# Status
- Companies processed: [List of Companies Completed]
- Companies Ongoing: [List Of Companies Ongoing]
- Total Distinct Keywords found: total_count (table length)
- Total Distinct Keywords found THIs time: <NumberOfnewAndOldKeywordsFoundThisTime/>
- Search Queries used This time:
<BulletListOfQueriesUsedOnSearches>
</BulletListOfQueriesUsedOnSearches>
- Total Job Posts found: total_number
- Newly Found Keywords:
<BulletListOfNewlyFoundKeywords>
</BulletListOfNewlyFoundKeywords>

- Newly Found Job Posts Titles:
<BulletListOfNewlyFoundTitles>
</BulletListOfNewlyFoundTitles>


Type `continue` to continue searching
```
If no other command was passed other than `continue` Response should not contain nothing else besides the content of this template.

## Current Status
### Project Configuration
**Companies Per Search:** 1
**Job Position Names Per Search:** 1
**Searches Per Round:** 4
**Searches Per Company-JobPositionName pair:** 1, i.e., A job Position Name should not be searched twice for the same company.

### Progress
- **Companies Processed**: []
- **Companies In Progress**: [<Companies that had at least one search performed but not all 5 searches>] 

### Priority Queue
The following companies have been added to the priority queue for analysis:

44+. Other Companies in file top_all.txt
    - They are sorted by priority.
    - That file was intentially left out for now to save my usage quota.



### Blacklist
Keywords explicitly excluded from analysis:
- "Full-stack Development"
- "App Store Engineering"

### Custom Commands
1. `split_found`
    - **Required Options**: KeywordsTriplesList
    - **Description**: For keywords found in the latest search, splits the term into component parts and adds the counts to each target keyword.
    - **Example Usage**: `split_found [("TypeScript/JavaScript","TypeScript","JavaScript")]`
    - **Print**: Nothing, just a short confirmation.
2. `merge_keywords `
    - **Required Options**: 
        - `mode` - Mode or stage of the merge operation. Values can be: `specific`, `evaluate`, `eval_response`. Defaults to `specific`
    - **Non-Required Options**:
        - keywords_to_merge:$list|$value - If  `mode:specific` merge all those keywords into a single one. If `mode: evaluate`, evaluate those keywords for equality of meaning. If `mode:eval_response` merge per group in the previous evaluation.
    - **Description**: Merge keywords that has the same meaning.
    - **Additional Instructions**: 
        - If mode:eval_response without a previous evaluation or `mode:specific` without keywords_to_merge present are not possible.
        - If mode:evaluate without any keywords_to_merge, then evaluate over the entire table of found words.
        - If mode:evaluate with a single `keywords_to_merge`, then find keywords from the found keyords table that can possibly have the same meaning as that keyword.
        - Be specific in the meaning similarity/equality, e.g., "Microservices" and "Microservices Architecture" are ok to merge, but not "Service-oriented Architecture" not "Architecture Patterns".
        - The merged name in the table should be comma separated.
        - If `mode: evaluate` - Only evaluate for same meaning and present in a clear and concise way. Do not merge anything yet. Show merge options as a numbered list, including subitems and items in the same line This way it will be easier for me to approve or disapprove merges, e.g.,
            ```
            1. Architecture Patterns
                1. (1) "Microservices" and (2) "Microservice architecture"
                2. (1) "Service-oriented architecture" and (2) "SOA"
                3. (1) "Distributed systems" and (2) "Distributed computing"
            ```
    - **Examples Usage (1)**: `merge_keywwords [("AI","ML"),("GCP","Google Cloud Platform")]`
    - **Examples Usage (2)**: `merge_keywwords mode:evaluate`
    - **Examples Usage (3)**: `merge_keywwords mode:evaluate ["AI"]`
    - **Examples Usage (4)**: `merge_keywwords mode:eval_response [1.1,[1.2.1,1.2.3],[2.1,*2.2],*3, 4]`
    - **Special Note:**: `merge_keywords mode:evaluate` should return a numbered list with 3 levels of numbers. `*` works like in Python, exploding the content., let's say in example 4 that 3 has 2 elements and 4 has 2 elements. *3 means each grouop of 3 should be treated as a separate group and be merged within it's own, while 4 without *`4`* means everyone should be merged together. It is equivalent to *3 = [3.1],[3.2] or [3.1.1,3.1.2],[3.2.1,3.2.2], while 4 = [4.1,4.2] or [4.1.1,4.1.2,4.2.1,4.2.2].
3. `print_all`
    - **Description**: Print the entire frequency table as a single table.
    - **Example Usage**: `print_all`
4. `print_top_n`
    - **Required Options**: n
    - **Description**: Print the top `n` keywords for each of the first 5 frequency columns and 1 for the total, including the last column, i.e., print 6 2 column tables.
    - **Example Usage**: `print_top_n n:100`
5. `blacklist`
    - **Required Options**: list_of_skills
    - **Description**: Exclude from the counting and ignore new appearances for the keywords in the blacklist.
    - **Example Usage**: `blacklist list_of_skills:["Full-stack Development","App Store Engineering"]`
6. `add_to_priority`
    - **Required Options**: companies_list
    - **Description**: insert the companies in companies_list in the priority queue in the position suggested in the second element of the tuple in the list.
    - **Example Usage**: `add_to_priority companies_list:[("Valve",3),("Visa",8)]`

## Stored Data Structures:
1. Table with keyword - frequency. To save context space use a tab or comman separated value format when to print. Columns should be 
    `Name:string`
    `Senior Backend Software Engineer:int`
    `Senior Software Engineer:int`
    `Senior Data Engineer:int`
    `Senior Distributed Systems Engineer:int`
    `Infrastructure Software Engineer:int`
    `Others:int`
2. key-value table of job posts read from the current ongoing company, to avoid reading twice the same job post, Consider that a job post may be added to different platforms, and therefore can show more than once in the same search results list.

## Most important instructions:
**Follow the instructions to the letter**
**Ask for clarification is an instruction is not clear enough**