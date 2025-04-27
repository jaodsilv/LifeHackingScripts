/**
 * Resume Management System
 * Shared utilities for web interface components
 */

// File handling utilities
const FileUtils = {
    /**
     * Read a file as JSON
     * @param {File} file - The file to read
     * @returns {Promise<object>} - The parsed JSON object
     */
    readFileAsJson: function(file) {
        return new Promise((resolve, reject) => {
            const reader = new FileReader();
            reader.onload = function(e) {
                try {
                    const data = JSON.parse(e.target.result);
                    resolve(data);
                } catch (error) {
                    reject(new Error('Error parsing JSON file: ' + error.message));
                }
            };
            reader.onerror = function(e) {
                reject(new Error('Error reading file'));
            };
            reader.readAsText(file);
        });
    },
    
    /**
     * Clean a branch name for use in filenames
     * @param {string} branchName - The branch name to clean
     * @returns {string} - The cleaned branch name
     */
    getCleanFileName: function(branchName) {
        if (!branchName) return '';
        return branchName.replace(/[\/\\]/g, '_').replace(/[^a-zA-Z0-9_]/g, '');
    }
};

// UI utilities
const UIUtils = {
    /**
     * Show a loading indicator
     * @param {HTMLElement} container - The container element
     * @param {HTMLElement} loader - The loader element
     */
    showLoading: function(container, loader) {
        if (container) container.style.display = 'none';
        if (loader) loader.style.display = 'flex';
    },
    
    /**
     * Hide a loading indicator
     * @param {HTMLElement} loader - The loader element
     * @param {HTMLElement} content - The content element to show
     */
    hideLoading: function(loader, content) {
        if (loader) loader.style.display = 'none';
        if (content) content.style.display = 'block';
    },
    
    /**
     * Format a date string
     * @param {string} dateStr - The date string to format
     * @returns {string} - The formatted date
     */
    formatDate: function(dateStr) {
        if (!dateStr) return 'N/A';
        try {
            const date = new Date(dateStr);
            return date.toLocaleDateString();
        } catch (e) {
            return dateStr;
        }
    },
    
    /**
     * Create a difference indicator
     * @param {number} diff - The difference value
     * @param {string} unit - The unit to display (default: '%')
     * @returns {object} - Object with text, class, and arrow properties
     */
    createDiffIndicator: function(diff, unit = '%') {
        if (diff === null || diff === undefined) {
            return {
                text: 'N/A',
                class: 'diff-neutral',
                arrow: ''
            };
        }
        
        if (diff > 0) {
            return {
                text: `+${diff}${unit}`,
                class: 'diff-positive',
                arrow: '↑'
            };
        } else if (diff < 0) {
            return {
                text: `${diff}${unit}`,
                class: 'diff-negative',
                arrow: '↓'
            };
        } else {
            return {
                text: 'No change',
                class: 'diff-neutral',
                arrow: ''
            };
        }
    }
};

// Chart utilities
const ChartUtils = {
    /**
     * Get color for progress bar based on score
     * @param {number} score - The score value
     * @returns {string} - The CSS class name
     */
    getAlignmentClass: function(score) {
        if (score >= 80) return 'good';
        if (score >= 60) return 'medium';
        return 'poor';
    },
    
    /**
     * Format a section name for display
     * @param {string} sectionName - The raw section name
     * @returns {string} - The formatted section name
     */
    formatSectionName: function(sectionName) {
        if (!sectionName) return '';
        return sectionName.split('_')
            .map(word => word.charAt(0).toUpperCase() + word.slice(1))
            .join(' ');
    },
    
    /**
     * Create a radar chart
     * @param {string} elementId - The ID of the canvas element
     * @param {object} data - The chart data
     * @returns {Chart} - The created chart
     */
    createRadarChart: function(elementId, data) {
        const ctx = document.getElementById(elementId).getContext('2d');
        return new Chart(ctx, {
            type: 'radar',
            data: data,
            options: {
                scales: {
                    r: {
                        angleLines: {
                            display: true
                        },
                        suggestedMin: 0,
                        suggestedMax: 100
                    }
                }
            }
        });
    },
    
    /**
     * Create a bar chart
     * @param {string} elementId - The ID of the canvas element
     * @param {object} data - The chart data
     * @param {object} options - Additional chart options
     * @returns {Chart} - The created chart
     */
    createBarChart: function(elementId, data, options = {}) {
        const ctx = document.getElementById(elementId).getContext('2d');
        return new Chart(ctx, {
            type: 'bar',
            data: data,
            options: {
                scales: {
                    y: {
                        beginAtZero: true,
                        max: 100,
                        ...options.scales?.y
                    }
                },
                ...options
            }
        });
    }
};

// Data processing utilities
const DataUtils = {
    /**
     * Find primary JD in an encoding
     * @param {object} encoding - The encoding object
     * @returns {object|null} - The primary JD or null
     */
    getPrimaryJd: function(encoding) {
        if (!encoding || !encoding.job_descriptions || !encoding.job_descriptions.length) {
            return null;
        }
        return encoding.job_descriptions.find(jd => jd.is_primary);
    },
    
    /**
     * Calculate difference between two encodings
     * @param {object} encoding1 - The first encoding
     * @param {object} encoding2 - The second encoding
     * @returns {object} - Difference metrics
     */
    calculateDifferences: function(encoding1, encoding2) {
        // Score difference
        const score1 = encoding1?.composite_scores?.weighted_average || 0;
        const score2 = encoding2?.composite_scores?.weighted_average || 0;
        const scoreDiff = score2 - score1;
        
        // Tags difference
        const tags1 = encoding1?.focus_tags || [];
        const tags2 = encoding2?.focus_tags || [];
        const commonTags = tags1.filter(tag => tags2.includes(tag));
        const uniqueTags1 = tags1.filter(tag => !tags2.includes(tag));
        const uniqueTags2 = tags2.filter(tag => !tags1.includes(tag));
        
        // JD alignment difference
        const primaryJd1 = this.getPrimaryJd(encoding1);
        const primaryJd2 = this.getPrimaryJd(encoding2);
        
        let jdAlignDiff = null;
        let samePrimaryJd = false;
        
        if (primaryJd1 && primaryJd2 && primaryJd1.jd_id === primaryJd2.jd_id) {
            jdAlignDiff = primaryJd2.alignment_score - primaryJd1.alignment_score;
            samePrimaryJd = true;
        }
        
        return {
            scoreDiff,
            tagDiff: tags2.length - tags1.length,
            jdAlignDiff,
            commonTags,
            uniqueTags1,
            uniqueTags2,
            samePrimaryJd
        };
    },
    
    /**
     * Check if changes are significant
     * @param {object} differences - The differences object from calculateDifferences
     * @returns {object} - Significance indicators and details
     */
    detectSignificantChanges: function(differences) {
        // Define thresholds
        const SCORE_THRESHOLD = 5;  // 5% difference in weighted score
        const JD_THRESHOLD = 10;    // 10% difference in JD alignment
        const TAG_THRESHOLD = 2;    // 2 or more tags added/removed
        
        // Check each threshold
        const isScoreSignificant = Math.abs(differences.scoreDiff) >= SCORE_THRESHOLD;
        const isJdSignificant = differences.jdAlignDiff !== null && 
                               Math.abs(differences.jdAlignDiff) >= JD_THRESHOLD;
        const isTagsAddedSignificant = differences.uniqueTags2.length >= TAG_THRESHOLD;
        const isTagsRemovedSignificant = differences.uniqueTags1.length >= TAG_THRESHOLD;
        
        // Overall significance
        const isSignificant = isScoreSignificant || isJdSignificant || 
                             isTagsAddedSignificant || isTagsRemovedSignificant;
        
        return {
            isSignificant,
            isScoreSignificant,
            isJdSignificant,
            isTagsAddedSignificant,
            isTagsRemovedSignificant,
            details: {
                scoreDiff: differences.scoreDiff,
                jdAlignDiff: differences.jdAlignDiff,
                tagsAdded: differences.uniqueTags2,
                tagsRemoved: differences.uniqueTags1
            }
        };
    }
};
