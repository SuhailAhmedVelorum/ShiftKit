#!/usr/bin/env bash
# Description: Configure system settings

# Function to configure screen timeout
system_configure_timeout() {
    if ! python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['system']['timeout']['enabled'])" | grep -q "True"; then
        log "INFO" "Skipping timeout configuration (disabled in config)"
        return 0
    fi
    
    local timeout=$(python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['system']['timeout']['value'])")
    
    log "INFO" "Setting screen timeout to $timeout seconds..."
    
    # Set screen blank timeout
    gsettings set org.gnome.desktop.session idle-delay "$timeout"
    
    update_progress
}

# Function to configure battery percentage display
system_configure_battery_percentage() {
    if ! python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['system']['battery_percentage']['enabled'])" | grep -q "True"; then
        log "INFO" "Skipping battery percentage configuration (disabled in config)"
        return 0
    fi
    
    local show=$(python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['system']['battery_percentage']['show'])")
    
    log "INFO" "Setting battery percentage display: $show"
    
    if [ "$show" = "True" ]; then
        gsettings set org.gnome.desktop.interface show-battery-percentage true
    else
        gsettings set org.gnome.desktop.interface show-battery-percentage false
    fi
    
    update_progress
}

# Function to configure hot corner
system_configure_hot_corner() {
    if ! python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['system']['hot_corner']['enabled'])" | grep -q "True"; then
        log "INFO" "Skipping hot corner configuration (disabled in config)"
        return 0
    fi
    
    local action=$(python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['system']['hot_corner']['action'])")
    
    log "INFO" "Setting hot corner action: $action"
    
    # Enable hot corner
    gsettings set org.gnome.desktop.interface enable-hot-corners true
    
    # Set the action based on configuration
    case "$action" in
        "show_applications")
            gsettings set org.gnome.shell.keybindings toggle-application-view "['<Super>a', '<Alt>F1']"
            ;;
        "show_overview")
            gsettings set org.gnome.desktop.wm.keybindings show-desktop "['<Super>d']"
            ;;
        "disabled")
            gsettings set org.gnome.desktop.interface enable-hot-corners false
            ;;
        *)
            log "WARNING" "Unknown hot corner action: $action"
            ;;
    esac
    
    update_progress
}

# Function to configure performance mode
system_configure_performance_mode() {
    if ! python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['system']['performance_mode']['enabled'])" | grep -q "True"; then
        log "INFO" "Skipping performance mode configuration (disabled in config)"
        return 0
    fi
    
    local mode=$(python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['system']['performance_mode']['mode'])")
    
    log "INFO" "Setting performance mode: $mode"
    
    # Check if power-profiles-daemon is installed
    if ! command -v powerprofilesctl &> /dev/null; then
        sudo apt-get install -y power-profiles-daemon
    fi
    
    # Set the performance mode
    case "$mode" in
        "balanced")
            sudo powerprofilesctl set balanced
            ;;
        "performance")
            sudo powerprofilesctl set performance
            ;;
        "power-save")
            sudo powerprofilesctl set power-saver
            ;;
        *)
            log "WARNING" "Unknown performance mode: $mode"
            ;;
    esac
    
    update_progress
}

# Function to configure other system settings
system_configure_misc() {
    log "INFO" "Configuring miscellaneous system settings..."
    
    # Example: Disable automatic updates
    # sudo systemctl disable apt-daily.service
    # sudo systemctl disable apt-daily.timer
    # sudo systemctl disable apt-daily-upgrade.service
    # sudo systemctl disable apt-daily-upgrade.timer
    
    # Example: Set default applications
    # xdg-mime default org.gnome.Nautilus.desktop inode/directory
    
    update_progress
}

# Main function for this module
system_main() {
    log "INFO" "Starting system module..."
    
    system_configure_timeout
    system_configure_battery_percentage
    system_configure_hot_corner
    system_configure_performance_mode
    system_configure_misc
    
    log "SUCCESS" "System module completed successfully"
}
