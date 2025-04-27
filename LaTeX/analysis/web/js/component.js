/**
 * Resume Management System
 * Shared header component for web interface
 */

class Header {
    /**
     * Create a header component
     * @param {string} title - The header title
     * @param {Array} actions - Array of action objects with label and href properties
     * @param {Array} labels - Optional array of label objects
     */
    constructor(title, actions = [], labels = []) {
        this.title = title;
        this.actions = actions;
        this.labels = labels;
    }
    
    /**
     * Render the header to a container element
     * @param {string} containerId - The ID of the container element
     */
    render(containerId) {
        const container = document.getElementById(containerId);
        if (!container) return;
        
        let html = `
            <div class="header-content">
                <h1>${this.title}</h1>
        `;
        
        // Add labels if provided
        if (this.labels && this.labels.length > 0) {
            html += '<div class="encoding-labels">';
            this.labels.forEach(label => {
                html += `
                    <div class="encoding-label ${label.className || ''}">${label.text}</div>
                `;
            });
            html += '</div>';
        }
        
        // Add actions
        if (this.actions && this.actions.length > 0) {
            html += '<div class="header-actions">';
            this.actions.forEach(action => {
                const className = action.className || 'btn-primary';
                const id = action.id || '';
                const disabled = action.disabled ? 'disabled' : '';
                
                if (action.href) {
                    html += `
                        <a href="${action.href}" class="btn ${className}" id="${id}" ${disabled}>${action.label}</a>
                    `;
                } else {
                    html += `
                        <button class="btn ${className}" id="${id}" ${disabled}>${action.label}</button>
                    `;
                }
            });
            html += '</div>';
        }
        
        html += '</div>';
        
        container.innerHTML = html;
        
        // Add event listeners
        this.actions.forEach(action => {
            if (action.id && action.onClick) {
                const element = document.getElementById(action.id);
                if (element) {
                    element.addEventListener('click', action.onClick);
                }
            }
        });
    }
    
    /**
     * Update the header title
     * @param {string} newTitle - The new title
     * @param {string} containerId - The ID of the container element
     */
    updateTitle(newTitle, containerId) {
        this.title = newTitle;
        this.render(containerId);
    }
    
    /**
     * Update the header labels
     * @param {Array} newLabels - Array of label objects
     * @param {string} containerId - The ID of the container element
     */
    updateLabels(newLabels, containerId) {
        this.labels = newLabels;
        this.render(containerId);
    }
    
    /**
     * Enable or disable an action button
     * @param {string} actionId - The ID of the action
     * @param {boolean} disabled - Whether to disable the button
     */
    setActionDisabled(actionId, disabled) {
        const action = this.actions.find(a => a.id === actionId);
        if (action) {
            action.disabled = disabled;
            
            const element = document.getElementById(actionId);
            if (element) {
                if (disabled) {
                    element.setAttribute('disabled', '');
                } else {
                    element.removeAttribute('disabled');
                }
            }
        }
    }
    
    /**
     * Create a browser header
     * @returns {Header} - A header instance for the browser
     */
    static createBrowserHeader() {
        return new Header('Resume Encoding Browser', [
            {
                label: 'Refresh',
                href: 'encoding_browser.html',
                className: 'btn-primary'
            }
        ]);
    }
    
    /**
     * Create a detail view header
     * @param {string} encodingName - The name of the encoding
     * @returns {Header} - A header instance for the detail view
     */
    static createDetailHeader(encodingName) {
        const title = encodingName ? `Encoding Details: ${encodingName}` : 'Encoding Details';
        
        return new Header(title, [
            {
                label: 'Back to Browser',
                href: 'encoding_browser.html',
                className: 'btn-primary'
            }
        ]);
    }
    
    /**
     * Create a comparison header
     * @param {string} encoding1Name - The name of the first encoding
     * @param {string} encoding2Name - The name of the second encoding
     * @returns {Header} - A header instance for the comparison view
     */
    static createComparisonHeader(encoding1Name, encoding2Name) {
        const labels = [];
        
        if (encoding1Name) {
            labels.push({
                text: encoding1Name,
                className: 'encoding1'
            });
        }
        
        if (encoding2Name) {
            labels.push({
                text: encoding2Name,
                className: 'encoding2'
            });
        }
        
        return new Header('Encoding Comparison', [
            {
                label: 'Back to Browser',
                href: 'encoding_browser.html',
                className: 'btn-primary'
            }
        ], labels);
    }
}

// Example usage:
// const header = Header.createBrowserHeader();
// header.render('headerContainer');
