#!/usr/bin/env bash
# Description: Restore configuration files and settings


# Function to create backup directory
configs_create_backup_dir() {
    local backup_dir=$(python3 -c "import yaml, os; print(os.path.expanduser(yaml.safe_load(open('$CONFIG_FILE'))['settings']['backup_dir']))")
    
    if [ ! -d "$backup_dir" ]; then
        log "INFO" "Creating backup directory: $backup_dir"
        mkdir -p "$backup_dir"
    fi
}

# Function to backup existing configuration files
configs_backup_existing() {
    if ! python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['settings']['backup_configs'])" | grep -q "True"; then
        log "INFO" "Skipping configuration backup (disabled in config)"
        return 0
    fi
    
    local backup_dir=$(python3 -c "import yaml, os; print(os.path.expanduser(yaml.safe_load(open('$CONFIG_FILE'))['settings']['backup_dir']))")
    local timestamp=$(date +"%Y%m%d_%H%M%S")
    local backup_path="${backup_dir}/backup_${timestamp}"
    
    log "INFO" "Backing up existing configurations to $backup_path"
    mkdir -p "$backup_path"
    
    # Backup .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        cp "$HOME/.bashrc" "$backup_path/.bashrc"
    fi
    
    # Backup other configuration files as needed
    # Example: cp "$HOME/.config/some_config" "$backup_path/some_config"
    
    update_progress
}

# Function to restore bashrc
configs_restore_bashrc() {
    if ! python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['configs']['bashrc']['enabled'])" | grep -q "True"; then
        log "INFO" "Skipping bashrc restoration (disabled in config)"
        return 0
    fi
    
    local source=$(python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['configs']['bashrc']['source'])")
    local target=$(python3 -c "import yaml, os; print(os.path.expanduser(yaml.safe_load(open('$CONFIG_FILE'))['configs']['bashrc']['target']))")
    
    log "INFO" "Restoring bashrc configuration..."
    
    if [ -f "$SCRIPT_DIR/$source" ]; then
        cp "$SCRIPT_DIR/$source" "$target"
        log "SUCCESS" "Restored bashrc configuration"
    else
        log "ERROR" "Source bashrc file not found: $SCRIPT_DIR/$source"
    fi
    
    update_progress
}

# Function to set up tiling manager
configs_setup_tiling_manager() {
    if ! python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['configs']['tiling_manager']['enabled'])" | grep -q "True"; then
        log "INFO" "Skipping tiling manager setup (disabled in config)"
        return 0
    fi
    
    local name=$(python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['configs']['tiling_manager']['name'])")
    local source=$(python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['configs']['tiling_manager']['source'])")
    
    log "INFO" "Setting up tiling manager: $name"
    
    case "$name" in
        "pop-shell")
            # Install Pop Shell if not already installed
            if ! dpkg -l | grep -q "gnome-shell-extension-pop-shell"; then
                sudo apt-get install -y gnome-shell-extension-pop-shell
            fi
            
            # Restore configuration if available
            if [ -d "$SCRIPT_DIR/$source" ]; then
                mkdir -p "$HOME/.config/pop-shell"
                cp -r "$SCRIPT_DIR/$source/"* "$HOME/.config/pop-shell/"
            fi
            
            # Enable the extension
            gnome-extensions enable pop-shell@system76.com
            ;;
            
        "i3")
            # Install i3 if not already installed
            if ! dpkg -l | grep -q "i3"; then
                sudo apt-get install -y i3
            fi
            
            # Restore configuration if available
            if [ -d "$SCRIPT_DIR/$source" ]; then
                mkdir -p "$HOME/.config/i3"
                cp -r "$SCRIPT_DIR/$source/"* "$HOME/.config/i3/"
            fi
            ;;
            
        *)
            log "WARNING" "Unknown tiling manager: $name"
            ;;
    esac
    
    update_progress
}

# Function to restore rice (theme, icons, fonts)
configs_restore_rice() {
    if ! python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['configs']['rice']['enabled'])" | grep -q "True"; then
        log "INFO" "Skipping rice restoration (disabled in config)"
        return 0
    fi
    
    log "INFO" "Restoring theme, icons, and fonts..."
    
    # Theme
    local theme_source=$(python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['configs']['rice']['theme'])")
    if [ -d "$SCRIPT_DIR/$theme_source" ]; then
        mkdir -p "$HOME/.themes"
        cp -r "$SCRIPT_DIR/$theme_source/"* "$HOME/.themes/"
        
        # Apply theme using gsettings
        local theme_name=$(basename "$SCRIPT_DIR/$theme_source")
        gsettings set org.gnome.desktop.interface gtk-theme "$theme_name"
        gsettings set org.gnome.desktop.wm.preferences theme "$theme_name"
    fi
    
    # Icons
    local icons_source=$(python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['configs']['rice']['icons'])")
    if [ -d "$SCRIPT_DIR/$icons_source" ]; then
        mkdir -p "$HOME/.icons"
        cp -r "$SCRIPT_DIR/$icons_source/"* "$HOME/.icons/"
        
        # Apply icons using gsettings
        local icons_name=$(basename "$SCRIPT_DIR/$icons_source")
        gsettings set org.gnome.desktop.interface icon-theme "$icons_name"
    fi
    
    # Fonts
    local fonts_source=$(python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['configs']['rice']['fonts'])")
    if [ -d "$SCRIPT_DIR/$fonts_source" ]; then
        mkdir -p "$HOME/.local/share/fonts"
        cp -r "$SCRIPT_DIR/$fonts_source/"* "$HOME/.local/share/fonts/"
        
        # Update font cache
        fc-cache -f -v
    fi
    
    update_progress
}

# Main function for this module
configs_main() {
    log "INFO" "Starting configs module..."
    
    configs_create_backup_dir
    configs_backup_existing
    configs_restore_bashrc
    configs_setup_tiling_manager
    configs_restore_rice
    
    log "SUCCESS" "Configs module completed successfully"
}
