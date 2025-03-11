#!/usr/bin/env bash
# Description: Custom user-specific configurations and installations

# Function to run custom scripts
custom_run_scripts() {
    local custom_scripts_dir="${SCRIPT_DIR}/custom_scripts"
    
    # Check if custom scripts directory exists
    if [ ! -d "$custom_scripts_dir" ]; then
        log "INFO" "No custom scripts directory found, skipping"
        return 0
    fi
    
    # Find all executable scripts in the directory
    local scripts=()
    while IFS= read -r -d '' script; do
        scripts+=("$script")
    done < <(find "$custom_scripts_dir" -type f -executable -print0 | sort -z)
    
    if [ ${#scripts[@]} -eq 0 ]; then
        log "INFO" "No custom scripts found, skipping"
        return 0
    fi  
    
    # Execute each script
    for script in "${scripts[@]}"; do
        local script_name=$(basename "$script")
        log "INFO" "Running custom script: $script_name"
        
        # Execute the script
        "$script"
        local status=$?
        
        if [ $status -eq 0 ]; then
            log "SUCCESS" "Custom script $script_name completed successfully"
        else
            log "ERROR" "Custom script $script_name failed with status $status"
        fi
        
        update_progress
    done
}

# Function to install custom packages
custom_install_packages() {
    if ! python3 -c "import yaml; config = yaml.safe_load(open('$CONFIG_FILE')); print('custom' in config and 'packages' in config['custom'])" | grep -q "True"; then
        log "INFO" "No custom packages defined, skipping"
        return 0
    fi
    
    local packages=$(python3 -c "
import yaml
config = yaml.safe_load(open('$CONFIG_FILE'))
if 'custom' in config and 'packages' in config['custom']:
    print(' '.join(config['custom']['packages']))
else:
    print('')
")
    
    if [ -z "$packages" ]; then
        log "INFO" "No custom packages defined, skipping"
        return 0
    fi
    
    log "INFO" "Installing custom packages..."
    
    for package in $packages; do
        log "INFO" "Installing custom package: $package"
        sudo apt-get install -y "$package"
        update_progress
    done
}

# Function to clone custom git repositories
custom_clone_repos() {
    if ! python3 -c "import yaml; config = yaml.safe_load(open('$CONFIG_FILE')); print('custom' in config and 'repositories' in config['custom'])" | grep -q "True"; then
        log "INFO" "No custom repositories defined, skipping"
        return 0
    fi
    
    local repos=$(python3 -c "
import yaml, json
config = yaml.safe_load(open('$CONFIG_FILE'))
if 'custom' in config and 'repositories' in config['custom']:
    print(json.dumps(config['custom']['repositories']))
else:
    print('[]')
")
    
    if [ "$repos" = "[]" ]; then
        log "INFO" "No custom repositories defined, skipping"
        return 0
    fi
    
    log "INFO" "Cloning custom repositories..."
    
    # Create directory for custom repositories
    local repos_dir="${HOME}/github"
    mkdir -p "$repos_dir"
    
    # Clone each repository
    local repo_count=$(echo "$repos" | python3 -c "import json, sys; print(len(json.load(sys.stdin)))")
    for i in $(seq 0 $((repo_count - 1))); do
        local repo_url=$(echo "$repos" | python3 -c "import json, sys; print(json.load(sys.stdin)[$i]['url'])")
        local repo_dir=$(echo "$repos" | python3 -c "import json, sys; print(json.load(sys.stdin)[$i].get('directory', ''))")
        local repo_branch=$(echo "$repos" | python3 -c "import json, sys; print(json.load(sys.stdin)[$i].get('branch', 'main'))")
        
        if [ -z "$repo_dir" ]; then
            # Extract repo name from URL
            repo_dir=$(basename "$repo_url" .git)
        fi
        
        local target_dir="${repos_dir}/${repo_dir}"
        
        log "INFO" "Cloning repository: $repo_url to $target_dir"
        
        if [ -d "$target_dir" ]; then
            log "WARNING" "Directory already exists: $target_dir, skipping"
        else
            git clone --branch "$repo_branch" "$repo_url" "$target_dir"
        fi
        
        update_progress
    done
}

# Function to run custom commands
custom_run_commands() {
    if ! python3 -c "import yaml; config = yaml.safe_load(open('$CONFIG_FILE')); print('custom' in config and 'commands' in config['custom'])" | grep -q "True"; then
        log "INFO" "No custom commands defined, skipping"
        return 0
    fi
    
    local commands=$(python3 -c "
import yaml, json
config = yaml.safe_load(open('$CONFIG_FILE'))
if 'custom' in config and 'commands' in config['custom']:
    print(json.dumps(config['custom']['commands']))
else:
    print('[]')
")
    
    if [ "$commands" = "[]" ]; then
        log "INFO" "No custom commands defined, skipping"
        return 0
    fi
    
    log "INFO" "Running custom commands..."
    
    # Run each command
    local cmd_count=$(echo "$commands" | python3 -c "import json, sys; print(len(json.load(sys.stdin)))")
    for i in $(seq 0 $((cmd_count - 1))); do
        local cmd=$(echo "$commands" | python3 -c "import json, sys; print(json.load(sys.stdin)[$i]['command'])")
        local desc=$(echo "$commands" | python3 -c "import json, sys; print(json.load(sys.stdin)[$i].get('description', 'Custom command'))")
        local dir=$(echo "$commands" | python3 -c "import json, sys; print(json.load(sys.stdin)[$i].get('directory', ''))")
        
        if [ -z "$dir" ]; then
            dir="$HOME"
        fi
        
        log "INFO" "Running command: $desc"
        
        # Change to the specified directory and run the command
        (cd "$dir" && eval "$cmd")
        
        update_progress
    done
}

# Main function for this module
custom_main() {
    log "INFO" "Starting custom module..."
    
    custom_install_packages
    custom_clone_repos
    custom_run_scripts
    custom_run_commands
    
    log "SUCCESS" "Custom module completed successfully"
}
