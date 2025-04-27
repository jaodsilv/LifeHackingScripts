# Automatic HTML Report Generation - Implementation Plan

## 1. Overview

This feature will enhance the resume management system by automating the generation of HTML comparison reports whenever new resume encodings are saved. This will enable:
- Immediate visualization of differences between resume versions
- Automatic comparison against the main branch
- Tracking of resume evolution over time
- Integration of job description alignment metrics in reports
- Creation of an organized report index for easy access

## 2. Component Modifications

### 2.1 Update `html-report-generator.ps1`

Enhance the existing report generator script to support:
- Silent/automated operation mode
- Improved integration with job description data
- Report indexing functionality
- Multiple comparison targets (main, previous, best match)
- Enhanced template with JD alignment visualization

### 2.2 Create `report-manager.ps1`

Create a new PowerShell script to manage report generation and organization:
- Report index creation and maintenance
- Auto-detection of significant resume changes
- Scheduled report generation capabilities
- Cleanup and archiving of older reports
- Report metadata management

### 2.3 Update `manage_encodings.ps1`

Modify the encoding management script to:
- Automatically trigger report generation after save operations
- Support direct access to relevant reports
- Enable configuration of report generation preferences

### 2.4 Create Report Index Structure

Implement a JSON-based report index:
```json
{
  "reports": [
    {
      "id": "main_vs_resume_data_engineer_20231015",
      "report_file": "reports/main_vs_resume_data_engineer_20231015.html",
      "branch1": "main",
      "branch2": "resume/data_engineer_2023q4",
      "timestamp": "2023-10-15 14:30:22",
      "significant_changes": true,
      "score_diff": 8,
      "primary_jd": "examplecorp_seniordata_20231001",
      "jd_alignment_diff": 15
    }
  ],
  "latest_by_branch": {
    "resume/data_engineer_2023q4": "main_vs_resume_data_engineer_20231015",
    "resume/frontend_dev_2023q4": "main_vs_resume_frontend_dev_20231012"
  },
  "significant_changes": [
    "main_vs_resume_data_engineer_20231015"
  ],
  "last_updated": "2023-10-15"
}
```

## 3. Implementation Details

### 3.1 Automated Operation Flow

1. User saves a new encoding or updates an existing one
2. System automatically:
   - Compares with main branch
   - Compares with previous version (if exists)
   - Compares with other specified targets
   - Generates appropriate reports
   - Updates the report index
   - Notifies user of significant findings

### 3.2 Report Template Enhancements

Update the HTML report template to include:
- Job description alignment comparison
- Skill gap visualization
- Interactive resume difference highlighting
- Timestamp and sequence information
- Links to related reports

### 3.3 Report Naming and Organization

Implement a consistent naming scheme:
- `[branch1]_vs_[branch2]_[timestamp].html` for standard reports
- `[branch]_evolution_[timestamp].html` for timeline reports
- `jd_[jd_id]_matches_[timestamp].html` for JD-focused reports

Organize reports in directories:
- `/analysis/reports/comparisons/` - Branch comparisons
- `/analysis/reports/timelines/` - Evolution over time
- `/analysis/reports/jd_matches/` - Job description matches

### 3.4 Configuration Options

Add configuration settings for auto-reporting:
- Target branches for comparison (default: main)
- Threshold for "significant change" notifications
- Report retention policy
- Default comparison metrics
- JD alignment inclusion

## 4. Implementation Steps

1. Create `report-manager.ps1` script
2. Update `html-report-generator.ps1` with new capabilities
3. Modify `manage_encodings.ps1` to trigger automatic reporting
4. Create enhanced report templates
5. Implement report indexing system
6. Add configuration settings for auto-reporting
7. Test integration with existing JD metadata feature

## 5. Command Reference

New commands to be implemented:

```powershell
# Generate reports automatically (from manage_encodings.ps1)
./manage_encodings.ps1 -Action save -BranchName "resume/data_engineer_2023q4" -AutoReport

# Manage reports directly
./report-manager.ps1 -Action list
./report-manager.ps1 -Action cleanup -RetentionDays 90
./report-manager.ps1 -Action regenerate -Branch "resume/data_engineer_2023q4"
./report-manager.ps1 -Action timeline -Branch "resume/data_engineer_2023q4"
```

## 6. Integration with JD Tracking

The automatic report generation will leverage the recently implemented job description tracking:
- Include JD alignment metrics in reports
- Highlight skill gaps identified through JD comparison
- Track improvement in JD alignment over time
- Generate specialized reports for specific job descriptions

## 7. Testing Plan

1. Test automatic report generation during encoding save
2. Verify report indexing functionality
3. Test report template enhancements
4. Validate JD information integration
5. Test multiple report types (comparison, timeline, JD-focused)
6. Verify significant change detection

## 8. Deliverables

1. Enhanced `html-report-generator.ps1` script
2. New `report-manager.ps1` script
3. Updated `manage_encodings.ps1` with auto-report functionality
4. Improved HTML report templates with JD integration
5. Documentation for the automatic reporting system
