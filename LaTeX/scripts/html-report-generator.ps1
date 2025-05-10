# Script to generate HTML comparison reports for resume encodings
param (
    [Parameter(Mandatory=$false)]
    [string]$OutputDir = "analysis\reports\comparisons",
    
    [Parameter(Mandatory=$false)]
    [string[]]$Branches,
    
    [Parameter(Mandatory=$false)]
    [switch]$AllBranches,
    
    [Parameter(Mandatory=$false)]
    [switch]$CompareToMain,
    
    [Parameter(Mandatory=$false)]
    [switch]$TimelineMode,
    
    [Parameter(Mandatory=$false)]
    [string]$OutputFile,
    
    [Parameter(Mandatory=$false)]
    [switch]$Silent
)

# Configuration
$ENCODINGS_DIR = "analysis\encodings"
$INDEX_FILE = "analysis\index.json"
$TEMPLATE_FILE = "analysis\templates\report_template.html"
$TIMELINE_TEMPLATE_FILE = "analysis\templates\timeline_template.html"
$JD_DIR = "analysis\job_descriptions"
$REPORTS_INDEX_FILE = "analysis\reports\reports_index.json"

# Ensure directories exist
New-Item -ItemType Directory -Path $OutputDir -Force | Out-Null
New-Item -ItemType Directory -Path "analysis\templates" -Force | Out-Null

# Helper function to load index
function Load-Index {
    if (Test-Path $INDEX_FILE) {
        return Get-Content $INDEX_FILE | ConvertFrom-Json
    } else {
        if (-not $Silent) {
            Write-Host "Error: Index file not found at $INDEX_FILE" -ForegroundColor Red
        }
        exit 1
    }
}

# Helper function to load reports index
function Load-ReportsIndex {
    if (Test-Path $REPORTS_INDEX_FILE) {
        return Get-Content $REPORTS_INDEX_FILE | ConvertFrom-Json
    } else {
        return @{
            "reports" = @()
            "latest_by_branch" = @{}
            "significant_changes" = @()
            "last_updated" = (Get-Date -Format "yyyy-MM-dd")
        }
    }
}

# Helper function to save reports index
function Save-ReportsIndex {
    param($indexData)
    $indexData.last_updated = Get-Date -Format "yyyy-MM-dd"
    $indexData | ConvertTo-Json -Depth 4 | Set-Content $REPORTS_INDEX_FILE
}

# Helper function to check if a change is significant
function Is-SignificantChange {
    param($reportData)
    
    # Define thresholds for significant changes
    $SCORE_THRESHOLD = 5  # 5% difference in overall score is significant
    $JD_ALIGNMENT_THRESHOLD = 10  # 10% difference in JD alignment is significant
    $TAG_CHANGE_THRESHOLD = 2  # 2 or more tag changes is significant
    
    if ([Math]::Abs($reportData.avg_diff) -ge $SCORE_THRESHOLD) {
        return $true
    }
    
    if ($reportData.jd_alignment_diff -and [Math]::Abs($reportData.jd_alignment_diff) -ge $JD_ALIGNMENT_THRESHOLD) {
        return $true
    }
    
    if ($reportData.tags_added -and $reportData.tags_added.Count -ge $TAG_CHANGE_THRESHOLD) {
        return $true
    }
    
    if ($reportData.tags_removed -and $reportData.tags_removed.Count -ge $TAG_CHANGE_THRESHOLD) {
        return $true
    }
    
    return $false
}

# Helper function to add a report to the index
function Add-ReportToIndex {
    param($branch1, $branch2, $reportFile, $comparisonData)
    
    $reportsIndex = Load-ReportsIndex
    
    # Clean branch names for the report ID
    $cleanName1 = $branch1 -replace "[\/\\]", "_" -replace "[^a-zA-Z0-9_]", ""
    $cleanName2 = $branch2 -replace "[\/\\]", "_" -replace "[^a-zA-Z0-9_]", ""
    $reportId = "${cleanName1}_vs_${cleanName2}"
    
    # Calculate score difference
    $scoreDiff = $comparisonData.branch2.weighted_score - $comparisonData.branch1.weighted_score
    
    # Identify tag changes
    $tagsAdded = @()
    $tagsRemoved = @()
    
    foreach ($tag in $comparisonData.branch2.focus_tags) {
        if ($comparisonData.branch1.focus_tags -notcontains $tag) {
            $tagsAdded += $tag
        }
    }
    
    foreach ($tag in $comparisonData.branch1.focus_tags) {
        if ($comparisonData.branch2.focus_tags -notcontains $tag) {
            $tagsRemoved += $tag
        }
    }
    
    # Calculate JD alignment difference if available
    $jdAlignmentDiff = $null
    if ($comparisonData.branch1.jd_alignment -and $comparisonData.branch2.jd_alignment) {
        $jdAlignmentDiff = $comparisonData.branch2.jd_alignment - $comparisonData.branch1.jd_alignment
    }
    
    # Create report metadata
    $reportInfo = @{
        "id" = $reportId
        "report_file" = $reportFile.Replace("analysis\", "")
        "branch1" = $branch1
        "branch2" = $branch2
        "timestamp" = $comparisonData.timestamp
        "score_diff" = $scoreDiff
        "avg_diff" = $comparisonData.avg_diff
        "tags_added" = $tagsAdded
        "tags_removed" = $tagsRemoved
    }
    
    # Add JD info if available
    if ($comparisonData.branch2.primary_jd) {
        $reportInfo["primary_jd"] = $comparisonData.branch2.primary_jd
    }
    
    if ($jdAlignmentDiff -ne $null) {
        $reportInfo["jd_alignment_diff"] = $jdAlignmentDiff
    }
    
    # Check if this is a significant change
    $reportInfo["significant_changes"] = Is-SignificantChange -reportData $reportInfo
    
    # Check if this report ID already exists
    $existingReport = $reportsIndex.reports | Where-Object { $_.id -eq $reportId }
    
    if ($existingReport) {
        # Update existing report
        foreach ($key in $reportInfo.PSObject.Properties.Name) {
            $existingReport.$key = $reportInfo.$key
        }
    } else {
        # Add new report
        $reportsIndex.reports += $reportInfo
    }
    
    # Update latest_by_branch
    $reportsIndex.latest_by_branch[$branch1] = $reportId
    $reportsIndex.latest_by_branch[$branch2] = $reportId
    
    # Update significant_changes list
    if ($reportInfo.significant_changes -and ($reportsIndex.significant_changes -notcontains $reportId)) {
        $reportsIndex.significant_changes += $reportId
    }
    
    # Save updated index
    Save-ReportsIndex -indexData $reportsIndex
    
    return $reportInfo
}

# Function to get branch encoding data
function Get-BranchEncoding {
    param($branchName)
    
    $index = Load-Index
    $entry = $index.encodings | Where-Object { $_.branch_name -eq $branchName }
    
    if (-not $entry) {
        if (-not $Silent) {
            Write-Host "Error: No encoding found for branch '$branchName'" -ForegroundColor Red
        }
        return $null
    }
    
    $filePath = "analysis\$($entry.encoding_file)"
    
    if (-not (Test-Path $filePath)) {
        if (-not $Silent) {
            Write-Host "Error: Encoding file not found: $filePath" -ForegroundColor Red
        }
        return $null
    }
    
    # Load the encoding data
    $encodingData = Get-Content $filePath | ConvertFrom-Json
    
    # Add branch metadata
    $encodingData | Add-Member -NotePropertyName "branch_name" -NotePropertyValue $branchName -Force
    $encodingData | Add-Member -NotePropertyName "weighted_score" -NotePropertyValue $entry.weighted_score -Force
    
    # Add JD info if available
    if ($entry.PSObject.Properties["primary_jd"]) {
        $encodingData | Add-Member -NotePropertyName "primary_jd" -NotePropertyValue $entry.primary_jd -Force
        $encodingData | Add-Member -NotePropertyName "jd_alignment" -NotePropertyValue $entry.jd_alignment -Force
    }
    
    return $encodingData
}

# Function to get JD data
function Get-JobDescription {
    param($jdId)
    
    $jdFile = Join-Path -Path $JD_DIR -ChildPath "$jdId.json"
    
    if (-not (Test-Path $jdFile)) {
        if (-not $Silent) {
            Write-Host "Warning: Job description file not found: $jdFile" -ForegroundColor Yellow
        }
        return $null
    }
    
    return Get-Content $jdFile | ConvertFrom-Json
}

# Function to create comparison data for two branches
function Create-ComparisonData {
    param($branch1Data, $branch2Data, $branch1Name, $branch2Name)
    
    $comparisonData = @{
        timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        branch1 = @{
            name = $branch1Name
            focus_tags = $branch1Data.focus_tags
            weighted_score = $branch1Data.composite_scores.weighted_average
        }
        branch2 = @{
            name = $branch2Name
            focus_tags = $branch2Data.focus_tags
            weighted_score = $branch2Data.composite_scores.weighted_average
        }
        sections = @()
        radar_data = @{
            labels = @()
            datasets = @(
                @{
                    label = $branch1Name
                    data = @()
                    backgroundColor = "rgba(54, 162, 235, 0.2)"
                    borderColor = "rgb(54, 162, 235)"
                    borderWidth = 1
                },
                @{
                    label = $branch2Name
                    data = @()
                    backgroundColor = "rgba(255, 99, 132, 0.2)"
                    borderColor = "rgb(255, 99, 132)"
                    borderWidth = 1
                }
            )
        }
        skill_data = @{
            labels = @()
            datasets = @(
                @{
                    label = $branch1Name
                    data = @()
                    backgroundColor = "rgba(54, 162, 235, 0.5)"
                    borderColor = "rgb(54, 162, 235)"
                    borderWidth = 1
                },
                @{
                    label = $branch2Name
                    data = @()
                    backgroundColor = "rgba(255, 99, 132, 0.5)"
                    borderColor = "rgb(255, 99, 132)"
                    borderWidth = 1
                }
            )
        }
        common_tags = @()
        unique_tags1 = @()
        unique_tags2 = @()
    }
    
    # Find common and unique tags
    foreach ($tag in $branch1Data.focus_tags) {
        if ($branch2Data.focus_tags -contains $tag) {
            $comparisonData.common_tags += $tag
        } else {
            $comparisonData.unique_tags1 += $tag
        }
    }
    
    foreach ($tag in $branch2Data.focus_tags) {
        if ($branch1Data.focus_tags -notcontains $tag) {
            $comparisonData.unique_tags2 += $tag
        }
    }
    
    # Process sections for composite scores
    $allSections = @($branch1Data.composite_scores.PSObject.Properties.Name) + @($branch2Data.composite_scores.PSObject.Properties.Name) | 
        Select-Object -Unique | 
        Where-Object { $_ -ne "weighted_average" }
    
    foreach ($section in $allSections) {
        $score1 = if ($branch1Data.composite_scores.PSObject.Properties[$section]) { $branch1Data.composite_scores.$section } else { 0 }
        $score2 = if ($branch2Data.composite_scores.PSObject.Properties[$section]) { $branch2Data.composite_scores.$section } else { 0 }
        $diff = $score2 - $score1
        
        $sectionDisplayName = $section -replace "_", " " -replace "\b[a-z]", { $_.Value.ToUpper() }
        
        $comparisonData.sections += @{
            name = $sectionDisplayName
            score1 = $score1
            score2 = $score2
            diff = $diff
        }
        
        # Add to radar chart data
        $comparisonData.radar_data.labels += $sectionDisplayName
        $comparisonData.radar_data.datasets[0].data += $score1
        $comparisonData.radar_data.datasets[1].data += $score2
    }
    
    # Process skills data - if available
    if ($branch1Data.detailed_scores.PSObject.Properties["technical_skills"] -and 
        $branch2Data.detailed_scores.PSObject.Properties["technical_skills"]) {
        
        $skills1 = $branch1Data.detailed_scores.technical_skills
        $skills2 = $branch2Data.detailed_scores.technical_skills
        
        $allSkills = @($skills1.PSObject.Properties.Name) + @($skills2.PSObject.Properties.Name) | Select-Object -Unique
        
        foreach ($skill in $allSkills) {
            $score1 = if ($skills1.PSObject.Properties[$skill]) { $skills1.$skill } else { 0 }
            $score2 = if ($skills2.PSObject.Properties[$skill]) { $skills2.$skill } else { 0 }
            
            $skillDisplayName = $skill -replace "_", " " -replace "\b[a-z]", { $_.Value.ToUpper() }
            
            $comparisonData.skill_data.labels += $skillDisplayName
            $comparisonData.skill_data.datasets[0].data += $score1
            $comparisonData.skill_data.datasets[1].data += $score2
        }
    }
    
    # Calculate weighted average difference
    $comparisonData.avg_diff = $comparisonData.branch2.weighted_score - $comparisonData.branch1.weighted_score
    
    # Add JD information if available
    $index = Load-Index
    $entry1 = $index.encodings | Where-Object { $_.branch_name -eq $branch1Name }
    $entry2 = $index.encodings | Where-Object { $_.branch_name -eq $branch2Name }
    
    if ($entry1.PSObject.Properties["primary_jd"]) {
        $comparisonData.branch1.primary_jd = $entry1.primary_jd
        $comparisonData.branch1.jd_alignment = $entry1.jd_alignment
        
        # Get JD details
        $jdData = Get-JobDescription -jdId $entry1.primary_jd
        if ($jdData) {
            $comparisonData.branch1.jd_details = @{
                company = $jdData.company
                position = $jdData.position
                key_skills = $jdData.key_skills
            }
        }
    }
    
    if ($entry2.PSObject.Properties["primary_jd"]) {
        $comparisonData.branch2.primary_jd = $entry2.primary_jd
        $comparisonData.branch2.jd_alignment = $entry2.jd_alignment
        
        # Get JD details
        $jdData = Get-JobDescription -jdId $entry2.primary_jd
        if ($jdData) {
            $comparisonData.branch2.jd_details = @{
                company = $jdData.company
                position = $jdData.position
                key_skills = $jdData.key_skills
            }
        }
        
        # Check for JD skill overlap
        if ($jdData -and $jdData.key_skills -and $comparisonData.branch2.jd_details) {
            $comparisonData.branch2.jd_details.matched_skills = @()
            $comparisonData.branch2.jd_details.missing_skills = @()
            
            foreach ($skill in $jdData.key_skills) {
                if ($branch2Data.focus_tags -contains $skill) {
                    $comparisonData.branch2.jd_details.matched_skills += $skill
                } else {
                    $comparisonData.branch2.jd_details.missing_skills += $skill
                }
            }
        }
    }
    
    # Calculate JD alignment difference if both have JD info
    if ($comparisonData.branch1.PSObject.Properties["jd_alignment"] -and 
        $comparisonData.branch2.PSObject.Properties["jd_alignment"]) {
        $comparisonData.jd_alignment_diff = $comparisonData.branch2.jd_alignment - $comparisonData.branch1.jd_alignment
    }
    
    return $comparisonData
}

# Function to generate HTML report
function Generate-HtmlReport {
    param($comparisonData, $outputFile)
    
    # Read HTML template 
    if (-not (Test-Path $TEMPLATE_FILE)) {
        # Create a default template if it doesn't exist
        $templateHtml = @"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Resume Comparison Report</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            color: #333;
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        h1, h2, h3 {
            color: #2c3e50;
        }
        .header {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 5px;
            margin-bottom: 20px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }
        .comparison-section {
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            margin-bottom: 20px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }
        .tag {
            display: inline-block;
            background-color: #e1f5fe;
            color: #0277bd;
            padding: 4px 8px;
            border-radius: 4px;
            margin-right: 5px;
            margin-bottom: 5px;
            font-size: 14px;
        }
        .tag.common {
            background-color: #e8f5e9;
            color: #2e7d32;
        }
        .tag.unique {
            background-color: #ffebee;
            color: #c62828;
        }
        .metrics-table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        .metrics-table th, .metrics-table td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
            text-align: left;
        }
        .metrics-table th {
            background-color: #f5f5f5;
        }
        .chart-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            margin-top: 20px;
        }
        .chart-box {
            flex: 1;
            min-width: 450px;
            background-color: white;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 1px 5px rgba(0,0,0,0.1);
        }
        .positive {
            color: #2e7d32;
        }
        .negative {
            color: #c62828;
        }
        .timestamp {
            font-size: 14px;
            color: #666;
            margin-top: 5px;
        }
        .jd-section {
            background-color: #f2f7ff;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            border-left: 4px solid #1565c0;
        }
        .jd-header {
            font-weight: bold;
            font-size: 16px;
            margin-bottom: 10px;
        }
        .progress-container {
            background-color: #e0e0e0;
            border-radius: 4px;
            height: 20px;
            margin: 10px 0;
        }
        .progress-bar {
            height: 100%;
            border-radius: 4px;
            text-align: center;
            line-height: 20px;
            color: white;
            font-size: 12px;
            font-weight: bold;
        }
        .progress-bar.good {
            background-color: #4caf50;
        }
        .progress-bar.medium {
            background-color: #ff9800;
        }
        .progress-bar.poor {
            background-color: #f44336;
        }
        .skill-list {
            display: flex;
            flex-wrap: wrap;
            gap: 5px;
            margin: 10px 0;
        }
        .skill-match {
            background-color: #e8f5e9;
            color: #2e7d32;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 14px;
        }
        .skill-missing {
            background-color: #ffebee;
            color: #c62828;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>Resume Comparison Report</h1>
        <p class="timestamp">Generated on {{timestamp}}</p>
        <div>
            <strong>{{branch1_name}}</strong> vs <strong>{{branch2_name}}</strong>
        </div>
    </div>

    <!-- JD Alignment Section -->
    <div class="comparison-section jd-section" id="jdSection" style="display:none;">
        <h2>Job Description Alignment</h2>
        <div id="jdContent">
            <!-- Will be populated based on JD data -->
        </div>
    </div>

    <div class="comparison-section">
        <h2>Focus Tags</h2>
        <div>
            <h3>{{branch1_name}} ({{branch1_score}}%)</h3>
            <div>
                {{#branch1_tags}}
                <span class="tag">{{.}}</span>
                {{/branch1_tags}}
            </div>
            
            <h3>{{branch2_name}} ({{branch2_score}}%)</h3>
            <div>
                {{#branch2_tags}}
                <span class="tag">{{.}}</span>
                {{/branch2_tags}}
            </div>
        </div>
        
        <div>
            <h3>Common Tags</h3>
            <div>
                {{#common_tags}}
                <span class="tag common">{{.}}</span>
                {{/common_tags}}
                {{^common_tags}}
                <p>No common tags found.</p>
                {{/common_tags}}
            </div>
            
            <h3>Unique to {{branch1_name}}</h3>
            <div>
                {{#unique_tags1}}
                <span class="tag unique">{{.}}</span>
                {{/unique_tags1}}
                {{^unique_tags1}}
                <p>No unique tags found.</p>
                {{/unique_tags1}}
            </div>
            
            <h3>Unique to {{branch2_name}}</h3>
            <div>
                {{#unique_tags2}}
                <span class="tag unique">{{.}}</span>
                {{/unique_tags2}}
                {{^unique_tags2}}
                <p>No unique tags found.</p>
                {{/unique_tags2}}
            </div>
        </div>
    </div>
    
    <div class="comparison-section">
        <h2>Content Coverage</h2>
        <table class="metrics-table">
            <thead>
                <tr>
                    <th>Section</th>
                    <th>{{branch1_name}}</th>
                    <th>{{branch2_name}}</th>
                    <th>Difference</th>
                </tr>
            </thead>
            <tbody>
                {{#sections}}
                <tr>
                    <td>{{name}}</td>
                    <td>{{score1}}%</td>
                    <td>{{score2}}%</td>
                    <td class="{{diff_class}}">{{diff_sign}}{{diff_abs}}%</td>
                </tr>
                {{/sections}}
                <tr style="font-weight: bold;">
                    <td>Weighted Average</td>
                    <td>{{branch1_score}}%</td>
                    <td>{{branch2_score}}%</td>
                    <td class="{{avg_diff_class}}">{{avg_diff_sign}}{{avg_diff_abs}}%</td>
                </tr>
            </tbody>
        </table>
    </div>
    
    <div class="comparison-section chart-container">
        <div class="chart-box">
            <h2>Content Coverage Comparison</h2>
            <canvas id="radarChart"></canvas>
        </div>
        
        <div class="chart-box">
            <h2>Technical Skills Comparison</h2>
            <canvas id="skillsChart"></canvas>
        </div>
    </div>
    
    <script>
        // Radar Chart Data
        const radarData = {{radar_data_json}};
        
        // Skills Chart Data
        const skillsData = {{skills_data_json}};
        
        // JD Data
        const jdData = {{jd_data_json}};
        
        // Initialize Charts
        document.addEventListener('DOMContentLoaded', function() {
            // Radar Chart
            const radarCtx = document.getElementById('radarChart').getContext('2d');
            new Chart(radarCtx, {
                type: 'radar',
                data: radarData,
                options: {
                    scales: {
                        r: {
                            min: 0,
                            max: 100,
                            ticks: {
                                stepSize: 20
                            }
                        }
                    }
                }
            });
            
            // Skills Chart
            const skillsCtx = document.getElementById('skillsChart').getContext('2d');
            new Chart(skillsCtx, {
                type: 'bar',
                data: skillsData,
                options: {
                    scales: {
                        y: {
                            min: 0,
                            max: 100
                        }
                    }
                }
            });
            
            // Populate JD section if data exists
            if (jdData && (jdData.branch1.primary_jd || jdData.branch2.primary_jd)) {
                document.getElementById('jdSection').style.display = 'block';
                const jdContent = document.getElementById('jdContent');
                let jdHtml = '';
                
                // Branch 2 JD (more recent/important)
                if (jdData.branch2.primary_jd) {
                    jdHtml += '<div class="jd-card">';
                    
                    if (jdData.branch2.jd_details) {
                        jdHtml += '<div class="jd-header">' + jdData.branch2.jd_details.company + ' - ' + 
                                  jdData.branch2.jd_details.position + '</div>';
                    } else {
                        jdHtml += '<div class="jd-header">Primary JD: ' + jdData.branch2.primary_jd + '</div>';
                    }
                    
                    // Progress bar
                    jdHtml += '<div class="progress-container">';
                    const barClass = jdData.branch2.jd_alignment >= 80 ? 'good' : 
                                    (jdData.branch2.jd_alignment >= 60 ? 'medium' : 'poor');
                    jdHtml += '<div class="progress-bar ' + barClass + '" style="width: ' + 
                              jdData.branch2.jd_alignment + '%">' + jdData.branch2.jd_alignment + '%</div>';
                    jdHtml += '</div>';
                    
                    // Skills
                    if (jdData.branch2.jd_details && jdData.branch2.jd_details.matched_skills) {
                        jdHtml += '<div><strong>Matched Skills:</strong></div>';
                        jdHtml += '<div class="skill-list">';
                        jdData.branch2.jd_details.matched_skills.forEach(skill => {
                            jdHtml += '<span class="skill-match">' + skill + '</span>';
                        });
                        jdHtml += '</div>';
                        
                        jdHtml += '<div><strong>Missing Skills:</strong></div>';
                        jdHtml += '<div class="skill-list">';
                        jdData.branch2.jd_details.missing_skills.forEach(skill => {
                            jdHtml += '<span class="skill-missing">' + skill + '</span>';
                        });
                        jdHtml += '</div>';
                    }
                    
                    // Alignment diff
                    if (jdData.jd_alignment_diff) {
                        const diffClass = jdData.jd_alignment_diff > 0 ? 'positive' : 'negative';
                        const diffSign = jdData.jd_alignment_diff > 0 ? '+' : '';
                        jdHtml += '<div style="margin-top: 10px;">';
                        jdHtml += 'Alignment change: <span class="' + diffClass + '">' + 
                                  diffSign + jdData.jd_alignment_diff + '%</span>';
                        jdHtml += '</div>';
                    }
                    
                    jdHtml += '</div>';
                }
                
                // Branch 1 JD (if different from branch 2)
                if (jdData.branch1.primary_jd && jdData.branch1.primary_jd !== jdData.branch2.primary_jd) {
                    jdHtml += '<div style="margin-top: 20px;">';
                    jdHtml += '<h3>' + jdData.branch1.name + ' JD Alignment:</h3>';
                    
                    if (jdData.branch1.jd_details) {
                        jdHtml += '<div class="jd-header">' + jdData.branch1.jd_details.company + ' - ' + 
                                  jdData.branch1.jd_details.position + '</div>';
                    } else {
                        jdHtml += '<div class="jd-header">Primary JD: ' + jdData.branch1.primary_jd + '</div>';
                    }
                    
                    // Progress bar
                    jdHtml += '<div class="progress-container">';
                    const barClass = jdData.branch1.jd_alignment >= 80 ? 'good' : 
                                    (jdData.branch1.jd_alignment >= 60 ? 'medium' : 'poor');
                    jdHtml += '<div class="progress-bar ' + barClass + '" style="width: ' + 
                              jdData.branch1.jd_alignment + '%">' + jdData.branch1.jd_alignment + '%</div>';
                    jdHtml += '</div>';
                    
                    jdHtml += '</div>';
                }
                
                jdContent.innerHTML = jdHtml;
            }
        });
    </script>
</body>
</html>
"@
        $templateHtml | Set-Content -Path $TEMPLATE_FILE -Force
    }
    
    $template = Get-Content -Path $TEMPLATE_FILE -Raw
    
    # Prepare the data for the template
    foreach ($section in $comparisonData.sections) {
        if ($section.diff -gt 0) {
            $section.diff_class = "positive"
            $section.diff_sign = "+"
        } elseif ($section.diff -lt 0) {
            $section.diff_class = "negative"
            $section.diff_sign = ""  # Negative sign is already included in the number
        } else {
            $section.diff_class = ""
            $section.diff_sign = ""
        }
        $section.diff_abs = [Math]::Abs($section.diff)
    }
    
    $avgDiff = $comparisonData.branch2.weighted_score - $comparisonData.branch1.weighted_score
    $avgDiffClass = if ($avgDiff -gt 0) { "positive" } elseif ($avgDiff -lt 0) { "negative" } else { "" }
    $avgDiffSign = if ($avgDiff -gt 0) { "+" } else { "" }
    
    # Create JD data object for passing to template
    $jdData = @{
        branch1 = @{
            name = $comparisonData.branch1.name
            primary_jd = $comparisonData.branch1.primary_jd
            jd_alignment = $comparisonData.branch1.jd_alignment
            jd_details = $comparisonData.branch1.jd_details
        }
        branch2 = @{
            name = $comparisonData.branch2.name
            primary_jd = $comparisonData.branch2.primary_jd
            jd_alignment = $comparisonData.branch2.jd_alignment
            jd_details = $comparisonData.branch2.jd_details
        }
    }
    
    if ($comparisonData.PSObject.Properties["jd_alignment_diff"]) {
        $jdData["jd_alignment_diff"] = $comparisonData.jd_alignment_diff
    }
    
    # Replace placeholders in the template
    $outputHtml = $template
    $outputHtml = $outputHtml.Replace("{{timestamp}}", $comparisonData.timestamp)
    $outputHtml = $outputHtml.Replace("{{branch1_name}}", $comparisonData.branch1.name)
    $outputHtml = $outputHtml.Replace("{{branch2_name}}", $comparisonData.branch2.name)
    $outputHtml = $outputHtml.Replace("{{branch1_score}}", $comparisonData.branch1.weighted_score)
    $outputHtml = $outputHtml.Replace("{{branch2_score}}", $comparisonData.branch2.weighted_score)
    $outputHtml = $outputHtml.Replace("{{avg_diff_class}}", $avgDiffClass)
    $outputHtml = $outputHtml.Replace("{{avg_diff_sign}}", $avgDiffSign)
    $outputHtml = $outputHtml.Replace("{{avg_diff_abs}}", [Math]::Abs($avgDiff))
    
    # Replace tag lists
    $branch1TagsHtml = ($comparisonData.branch1.focus_tags | ForEach-Object { "                <span class=`"tag`">$_</span>`n" }) -join ""
    $branch2TagsHtml = ($comparisonData.branch2.focus_tags | ForEach-Object { "                <span class=`"tag`">$_</span>`n" }) -join ""
    $commonTagsHtml = ($comparisonData.common_tags | ForEach-Object { "                <span class=`"tag common`">$_</span>`n" }) -join ""
    $uniqueTags1Html = ($comparisonData.unique_tags1 | ForEach-Object { "                <span class=`"tag unique`">$_</span>`n" }) -join ""
    $uniqueTags2Html = ($comparisonData.unique_tags2 | ForEach-Object { "                <span class=`"tag unique`">$_</span>`n" }) -join ""
    
    $outputHtml = $outputHtml.Replace("{{#branch1_tags}}", "").Replace("{{/branch1_tags}}", "")
    $outputHtml = $outputHtml.Replace("{{#branch2_tags}}", "").Replace("{{/branch2_tags}}", "")
    $outputHtml = $outputHtml.Replace("{{#common_tags}}", "").Replace("{{/common_tags}}", "")
    $outputHtml = $outputHtml.Replace("{{#unique_tags1}}", "").Replace("{{/unique_tags1}}", "")
    $outputHtml = $outputHtml.Replace("{{#unique_tags2}}", "").Replace("{{/unique_tags2}}", "")
    
    $outputHtml = $outputHtml.Replace("{{^common_tags}}", $comparisonData.common_tags.Count -eq 0 ? "" : "<!--").Replace("{{/common_tags}}", $comparisonData.common_tags.Count -eq 0 ? "" : "-->")
    $outputHtml = $outputHtml.Replace("{{^unique_tags1}}", $comparisonData.unique_tags1.Count -eq 0 ? "" : "<!--").Replace("{{/unique_tags1}}", $comparisonData.unique_tags1.Count -eq 0 ? "" : "-->")
    $outputHtml = $outputHtml.Replace("{{^unique_tags2}}", $comparisonData.unique_tags2.Count -eq 0 ? "" : "<!--").Replace("{{/unique_tags2}}", $comparisonData.unique_tags2.Count -eq 0 ? "" : "-->")
    
    $outputHtml = $outputHtml.Replace("<span class=`"tag`">{{.}}</span>", $branch1TagsHtml, 1)
    $outputHtml = $outputHtml.Replace("<span class=`"tag`">{{.}}</span>", $branch2TagsHtml, 1)
    $outputHtml = $outputHtml.Replace("<span class=`"tag common`">{{.}}</span>", $commonTagsHtml, 1)
    $outputHtml = $outputHtml.Replace("<span class=`"tag unique`">{{.}}</span>", $uniqueTags1Html, 1)
    $outputHtml = $outputHtml.Replace("<span class=`"tag unique`">{{.}}</span>", $uniqueTags2Html, 1)
    
    # Replace sections table
    $sectionsHtml = ""
    foreach ($section in $comparisonData.sections) {
        $diffClass = $section.diff_class
        $diffSign = $section.diff_sign
        $diffAbs = $section.diff_abs
        
        $sectionsHtml += @"
                <tr>
                    <td>$($section.name)</td>
                    <td>$($section.score1)%</td>
                    <td>$($section.score2)%</td>
                    <td class="$diffClass">$diffSign$diffAbs%</td>
                </tr>

"@
    }
    
    $outputHtml = $outputHtml.Replace("{{#sections}}", "").Replace("{{/sections}}", "")
    $templateOutput = @"
<tr>
    <td>{{name}}</td>
    <td>{{score1}}%</td>
    <td>{{score2}}%</td>
    <td class="{{diff_class}}">{{diff_sign}}{{diff_abs}}%</td>
</tr>
"@
    $outputHtml = $outputHtml.Replace($templateOutput, $sectionsHtml)
    
    # Replace chart data
    $radarDataJson = ConvertTo-Json -InputObject $comparisonData.radar_data -Depth 4 -Compress
    $skillsDataJson = ConvertTo-Json -InputObject $comparisonData.skill_data -Depth 4 -Compress
    $jdDataJson = ConvertTo-Json -InputObject $jdData -Depth 6 -Compress
    
    $outputHtml = $outputHtml.Replace("{{radar_data_json}}", $radarDataJson)
    $outputHtml = $outputHtml.Replace("{{skills_data_json}}", $skillsDataJson)
    $outputHtml = $outputHtml.Replace("{{jd_data_json}}", $jdDataJson)
    
    # Save the output HTML
    $outputHtml | Set-Content -Path $outputFile -Force
    
    if (-not $Silent) {
        Write-Host "Report generated: $outputFile" -ForegroundColor Green
    }
    
    return $true
}

# Function to generate timeline report
function Generate-TimelineReport {
    param($branch, $outputFile)
    
    # This is a simplified implementation - a more robust version would
    # analyze multiple versions of the same branch over time
    
    # For now, we'll just call the existing function with a special template
    # This would be enhanced in a real implementation
    
    # Load the latest encoding for this branch
    $branchData = Get-BranchEncoding -branchName $branch
    $mainData = Get-BranchEncoding -branchName "main"
    
    if (-not $branchData -or -not $mainData) {
        if (-not $Silent) {
            Write-Host "Error: Could not load required branch data." -ForegroundColor Red
        }
        return $false
    }
    
    # Create comparison data
    $comparisonData = Create-ComparisonData -branch1Data $mainData -branch2Data $branchData -branch1Name "main" -branch2Name $branch
    
    # Generate the report
    return Generate-HtmlReport -comparisonData $comparisonData -outputFile $outputFile
}

# Main execution
if ($TimelineMode) {
    # Handle timeline mode
    if ($Branches -and $Branches.Count -gt 0) {
        $branch = $Branches[0]  # Use first branch for timeline
        
        # Set output file
        $cleanName = $branch -replace "[\/\\]", "_" -replace "[^a-zA-Z0-9_]", ""
        $outputFile = if ($OutputFile) {
            Join-Path -Path $OutputDir -ChildPath $OutputFile
        } else {
            Join-Path -Path $OutputDir -ChildPath "${cleanName}_timeline.html"
        }
        
        $result = Generate-TimelineReport -branch $branch -outputFile $outputFile
        
        if ($result -and -not $Silent) {
            Write-Host "Timeline report generated: $outputFile" -ForegroundColor Green
        }
    } else {
        if (-not $Silent) {
            Write-Host "Error: No branch specified for timeline mode." -ForegroundColor Red
        }
    }
} else {
    # Regular comparison mode
    $index = Load-Index

    if ($AllBranches) {
        # Get all branches from the index
        $Branches = $index.encodings | ForEach-Object { $_.branch_name }
    }

    if ($Branches -and $Branches.Count -gt 0) {
        if ($CompareToMain) {
            # Compare each branch to main
            $mainData = Get-BranchEncoding -branchName "main"
            if (-not $mainData) {
                if (-not $Silent) {
                    Write-Host "Error: Could not load encoding data for main branch." -ForegroundColor Red
                }
                exit 1
            }
            
            foreach ($branch in $Branches) {
                $branchData = Get-BranchEncoding -branchName $branch
                if ($branchData) {
                    $comparisonData = Create-ComparisonData -branch1Data $mainData -branch2Data $branchData -branch1Name "main" -branch2Name $branch
                    
                    $cleanName = $branch -replace "[\/\\]", "_" -replace "[^a-zA-Z0-9_]", ""
                    $outputFile = if ($OutputFile -and $Branches.Count -eq 1) {
                        Join-Path -Path $OutputDir -ChildPath $OutputFile
                    } else {
                        Join-Path -Path $OutputDir -ChildPath "main_vs_$cleanName.html"
                    }
                    
                    $result = Generate-HtmlReport -comparisonData $comparisonData -outputFile $outputFile
                    
                    if ($result) {
                        # Add to report index
                        $reportInfo = Add-ReportToIndex -branch1 "main" -branch2 $branch -reportFile $outputFile -comparisonData $comparisonData
                        
                        # Notify about significant changes
                        if (-not $Silent -and $reportInfo.significant_changes) {
                            Write-Host "Significant changes detected in comparison!" -ForegroundColor Yellow
                        }
                    }
                }
            }
        } else {
            # Compare branches pairwise if more than one is provided
            if ($Branches.Count -gt 1) {
                for ($i = 0; $i -lt $Branches.Count - 1; $i++) {
                    for ($j = $i + 1; $j -lt $Branches.Count; $j++) {
                        $branch1 = $Branches[$i]
                        $branch2 = $Branches[$j]
                        
                        $branch1Data = Get-BranchEncoding -branchName $branch1
                        $branch2Data = Get-BranchEncoding -branchName $branch2
                        
                        if ($branch1Data -and $branch2Data) {
                            $comparisonData = Create-ComparisonData -branch1Data $branch1Data -branch2Data $branch2Data -branch1Name $branch1 -branch2Name $branch2
                            
                            $cleanName1 = $branch1 -replace "[\/\\]", "_" -replace "[^a-zA-Z0-9_]", ""
                            $cleanName2 = $branch2 -replace "[\/\\]", "_" -replace "[^a-zA-Z0-9_]", ""
                            
                            $outputFile = if ($OutputFile -and $i -eq 0 -and $j -eq 1) {
                                Join-Path -Path $OutputDir -ChildPath $OutputFile
                            } else {
                                Join-Path -Path $OutputDir -ChildPath "${cleanName1}_vs_${cleanName2}.html"
                            }
                            
                            $result = Generate-HtmlReport -comparisonData $comparisonData -outputFile $outputFile
                            
                            if ($result) {
                                # Add to report index
                                Add-ReportToIndex -branch1 $branch1 -branch2 $branch2 -reportFile $outputFile -comparisonData $comparisonData
                            }
                        }
                    }
                }
            } else {
                if (-not $Silent) {
                    Write-Host "Please provide more than one branch for comparison or use the -CompareToMain switch." -ForegroundColor Yellow
                    Write-Host "Example: .\html-report-generator.ps1 -Branches resume/branch1,resume/branch2" -ForegroundColor Yellow
                    Write-Host "Example: .\html-report-generator.ps1 -Branches resume/branch1 -CompareToMain" -ForegroundColor Yellow
                }
            }
        }
    } else {
        if (-not $Silent) {
            Write-Host "No branches specified for report generation. Use -Branches or -AllBranches parameter." -ForegroundColor Yellow
            Write-Host "Example: .\html-report-generator.ps1 -Branches resume/branch1,resume/branch2" -ForegroundColor Yellow
            Write-Host "Example: .\html-report-generator.ps1 -AllBranches -CompareToMain" -ForegroundColor Yellow
        }
    }
}

if (-not $Silent) {
    Write-Host "Report generation complete." -ForegroundColor Green
}