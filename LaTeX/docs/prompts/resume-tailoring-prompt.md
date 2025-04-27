# Resume Tailoring Prompt for Cursor

```
I need you to help me tailor a resume for a specific job position in a systematic, step-by-step process that maintains absolute accuracy and veracity of information.

CONTEXT:
- I have a comprehensive CV (source of truth) in my main branch
- I've identified a resume branch (resume/backend_api_2023q2) that best matches the target position
- I need to systematically tailor this resume for the new position

JOB DESCRIPTION:
[PASTE JOB DESCRIPTION HERE]

FILES TO MODIFY:
- 1.Summary.tex (Professional Summary)
- 2.1.Microsoft.tex (Microsoft Experience)
- 2.2.Google.tex (Google Experience)
- 3.Education.tex (Education at USP)
- 4.Skills.tex (Technical Skills)
- 7.Interests.tex (Professional Interests)

CRITICAL REQUIREMENTS:
- NEVER invent or assume information not present in my CV
- Maintain absolute veracity in all content
- Do not hallucinate or exaggerate experiences, skills, or accomplishments
- Provide detailed rationale for all recommended changes
- Perform tailoring in four distinct phases for easier review

PHASE 1: CONTENT EXCLUSION
1. Analyze the job description to determine which existing content is LEAST relevant
2. Recommend specific content to exclude from the resume to meet the 2-page limit
3. For each recommended exclusion:
   - Identify the specific bullet point or paragraph
   - Provide explicit rationale linking to job requirements
   - Indicate level of confidence in the exclusion decision
4. Present all recommended exclusions in a clear list for review

Example format:
```
## Phase 1: Content Exclusion Recommendations

### 2.1.Microsoft.tex
1. **EXCLUDE**: "Led internal training sessions on legacy code maintenance..."
   - **Rationale**: The job focuses on new development rather than maintenance
   - **Confidence**: High - maintenance skills are not mentioned in job description

2. **EXCLUDE**: "Collaborated with UX team on frontend optimizations..."
   - **Rationale**: Position emphasizes backend skills with minimal frontend involvement
   - **Confidence**: Medium - some frontend knowledge may still be valuable
```

PHASE 2: CONTENT EDITING
1. Identify existing content that is relevant but needs refinement
2. Recommend specific edits to emphasize skills and experiences most relevant to the job
3. For each edit:
   - Show exact original text
   - Show proposed revised text
   - Provide explicit rationale linking to job requirements
4. Ensure all edited content remains 100% truthful and supported by the CV

Example format:
```
## Phase 2: Content Editing Recommendations

### 1.Summary.tex
1. **ORIGINAL**: "Experienced software engineer with expertise in distributed systems and data processing."
   **REVISED**: "Experienced backend software engineer specialized in distributed systems, API design, and high-throughput data processing."
   - **Rationale**: Job requires API design expertise which was present but not emphasized

### 2.2.Google.tex
1. **ORIGINAL**: "Developed microservices architecture for customer data platform."
   **REVISED**: "Architected RESTful microservices for customer data platform, ensuring scalability and compliance with security standards."
   - **Rationale**: Job emphasizes RESTful API development and security compliance
```

PHASE 3: CONTENT ADDITION
1. Identify content in the CV that is NOT in the current resume but is highly relevant to the job
2. Recommend specific content to add from the CV (NOT invented content)
3. For each addition:
   - Show exact text to add
   - Specify precise location for insertion
   - Provide explicit rationale linking to job requirements
4. Verify all additions exist verbatim in the CV

Example format:
```
## Phase 3: Content Addition Recommendations

### 4.Skills.tex
1. **ADD**: Under "API and Web Technologies" section, add "GraphQL schema design and implementation"
   - **Source**: Found in CV at line 157
   - **Rationale**: Job description specifically mentions GraphQL experience

### 2.1.Microsoft.tex
1. **ADD**: "Implemented rate limiting and authentication protocols for public-facing APIs."
   - **Source**: Found in CV under Microsoft experience, line 89
   - **Rationale**: Job requires experience with API security mechanisms
```

PHASE 4: CONTENT REORDERING
1. Analyze the job description priorities
2. Recommend reordering of bullet points to highlight most relevant experience first
3. For each section, recommend a new ordering of content
4. Provide clear rationale for the prioritization

Example format:
```
## Phase 4: Content Reordering Recommendations

### 2.1.Microsoft.tex
**Recommended order**:
1. "Designed and implemented scalable API gateway..."
2. "Led migration from monolithic architecture to microservices..."
3. "Optimized database queries for high-throughput applications..."

**Rationale**: The job places highest emphasis on API design and microservices architecture, followed by performance optimization.
```

VERIFICATION CHECKLIST:
- Confirm all content is factually accurate and present in the CV
- Verify no assumptions or fabrications were made
- Ensure the tailored resume will fit within 2 pages
- Check that all key job requirements are addressed

ADDITIONAL GUIDELINES:
- Maintain professional, concise language
- Emphasize quantifiable achievements where available in the CV
- Focus on recent and most relevant experience
- Preserve chronological order within each section
- Consider the 2-page limit in all recommendations
```