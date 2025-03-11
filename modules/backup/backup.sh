#!/usr/bin/env bash
# Description: Backup and restore important user data

# Function to check the config to see if we should even run backup or not
backup_check_to_run() {
    if ! python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['backup']['enabled'])" | grep -q "True"; then
        log "INFO" "Skipping backup (disabled in config)"
        return 0
    fi
}

# Function to create backup directories
backup_create_dirs() {
    local backup_base_dir=$(python3 -c "import yaml, os; print(os.path.expanduser(yaml.safe_load(open('$CONFIG_FILE'))['backup']['base_dir']))")
    
    log "INFO" "Creating backup directories..."
    
    # Create main backup directory
    mkdir -p "$backup_base_dir"
    
    # Create subdirectories for different backup types
    mkdir -p "${backup_base_dir}/configs"
    mkdir -p "${backup_base_dir}/documents"
    mkdir -p "${backup_base_dir}/projects"
    mkdir -p "${backup_base_dir}/data"
    
    update_progress
}

# Function to backup user documents
backup_documents() {
    if ! python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['backup']['documents']['enabled'])" | grep -q "True"; then
        log "INFO" "Skipping documents backup (disabled in config)"
        return 0
    fi
    
    local backup_base_dir=$(python3 -c "import yaml, os; print(os.path.expanduser(yaml.safe_load(open('$CONFIG_FILE'))['backup']['base_dir']))")
    local documents_dir=$(python3 -c "import yaml, os; print(os.path.expanduser(yaml.safe_load(open('$CONFIG_FILE'))['backup']['documents']['source_dir']))")
    local timestamp=$(date +"%Y%m%d_%H%M%S")
    local backup_file="${backup_base_dir}/documents/documents_${timestamp}.tar.gz"
    
    log "INFO" "Backing up documents from $documents_dir to $backup_file"
    
    # Create tar archive of documents
    tar -czf "$backup_file" -C "$(dirname "$documents_dir")" "$(basename "$documents_dir")"
    
    update_progress
}

# Function to backup projects
backup_projects() {
    if ! python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['backup']['projects']['enabled'])" | grep -q "True"; then
        log "INFO" "Skipping projects backup (disabled in config)"
        return 0
    fi
    
    local backup_base_dir=$(python3 -c "import yaml, os; print(os.path.expanduser(yaml.safe_load(open('$CONFIG_FILE'))['backup']['base_dir']))")
    local projects_dir=$(python3 -c "import yaml, os; print(os.path.expanduser(yaml.safe_load(open('$CONFIG_FILE'))['backup']['projects']['source_dir']))")
    local timestamp=$(date +"%Y%m%d_%H%M%S")
    local backup_file="${backup_base_dir}/projects/projects_${timestamp}.tar.gz"
    
    log "INFO" "Backing up projects from $projects_dir to $backup_file"
    
    # Create tar archive of projects
    tar -czf "$backup_file" -C "$(dirname "$projects_dir")" "$(basename "$projects_dir")"
    
    update_progress
}

# Function to backup browser data
backup_browser_data() {
    if ! python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['backup']['browser_data']['enabled'])" | grep -q "True"; then
        log "INFO" "Skipping browser data backup (disabled in config)"
        return 0
    fi
    
    local backup_base_dir=$(python3 -c "import yaml, os; print(os.path.expanduser(yaml.safe_load(open('$CONFIG_FILE'))['backup']['base_dir']))")
    local browser=$(python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['backup']['browser_data']['browser'])")
    local timestamp=$(date +"%Y%m%d_%H%M%S")
    
    log "INFO" "Backing up $browser data"
    
    case "$browser" in
        "firefox")
            local firefox_dir="$HOME/.mozilla/firefox"
            local backup_file="${backup_base_dir}/data/firefox_${timestamp}.tar.gz"
            
            # Find the profile directory
            local profile_dir=$(find "$firefox_dir" -name "*.default*" -type d | head -n 1)
            
            if [ -n "$profile_dir" ]; then
                # Backup bookmarks, history, and passwords
                tar -czf "$backup_file" -C "$profile_dir" places.sqlite favicons.sqlite key4.db logins.json
                log "SUCCESS" "Firefox data backed up to $backup_file"
            else
                log "ERROR" "Firefox profile directory not found"
            fi
            ;;
            
        "chrome")
            local chrome_dir="$HOME/.config/google-chrome"
            local backup_file="${backup_base_dir}/data/chrome_${timestamp}.tar.gz"
            
            if [ -d "$chrome_dir" ]; then
                # Backup bookmarks and preferences
                tar -czf "$backup_file" -C "$chrome_dir/Default" "Bookmarks" "Preferences"
                log "SUCCESS" "Chrome data backed up to $backup_file"
            else
                log "ERROR" "Chrome data directory not found"
            fi
            ;;
            
        *)
            log "WARNING" "Unsupported browser: $browser"
            ;;
    esac
    
    update_progress
}

# Function to restore from backup
backup_restore() {
    if ! python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['backup']['restore']['enabled'])" | grep -q "True"; then
        log "INFO" "Skipping backup restoration (disabled in config)"
        return 0
    fi
    
    local backup_base_dir=$(python3 -c "import yaml, os; print(os.path.expanduser(yaml.safe_load(open('$CONFIG_FILE'))['backup']['base_dir']))")
    local restore_type=$(python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['backup']['restore']['type'])")
    local restore_file=$(python3 -c "import yaml, os; print(os.path.expanduser(yaml.safe_load(open('$CONFIG_FILE'))['backup']['restore']['file']))")
    local restore_target=$(python3 -c "import yaml, os; print(os.path.expanduser(yaml.safe_load(open('$CONFIG_FILE'))['backup']['restore']['target_dir']))")
    
    log "INFO" "Restoring $restore_type from $restore_file to $restore_target"
    
    # Create target directory if it doesn't exist
    mkdir -p "$restore_target"
    
    # Extract the backup archive
    tar -xzf "$restore_file" -C "$restore_target"
    
    update_progress
}

# Function to list available backups
backup_list() {
    local backup_base_dir=$(python3 -c "import yaml, os; print(os.path.expanduser(yaml.safe_load(open('$CONFIG_FILE'))['backup']['base_dir']))")
    
    log "INFO" "Available backups:"
    
    # List documents backups
    log "INFO" "Documents backups:"
    find "${backup_base_dir}/documents" -name "*.tar.gz" -type f | sort
    
    # List projects backups
    log "INFO" "Projects backups:"
    find "${backup_base_dir}/projects" -name "*.tar.gz" -type f | sort
    
    # List data backups
    log "INFO" "Data backups:"
    find "${backup_base_dir}/data" -name "*.tar.gz" -type f | sort
    
    update_progress
}

# Main function for this module
backup_main() {
    log "INFO" "Starting backup module..."

    backup_check_to_run
    backup_create_dirs
    backup_documents
    backup_projects
    backup_browser_data
    
    # Only run restore if specifically enabled
    if python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['backup']['restore']['enabled'])" | grep -q "True"; then
        backup_restore
    fi
    
    log "SUCCESS" "Backup module completed successfully"
}
