#!/usr/bin/env bash
# Description: Customize desktop environment settings

# Function to set GNOME theme
desktop_set_theme() {
    if ! python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['desktop']['theme']['enabled'])" | grep -q "True"; then
        log "INFO" "Skipping theme setup (disabled in config)"
        return 0
    fi
    
    local theme=$(python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['desktop']['theme']['name'])")
    
    log "INFO" "Setting GNOME theme to $theme"
    gsettings set org.gnome.desktop.interface gtk-theme "$theme"
    gsettings set org.gnome.desktop.wm.preferences theme "$theme"
    
    update_progress
}

# Function to set icon theme
desktop_set_icons() {
    if ! python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['desktop']['icons']['enabled'])" | grep -q "True"; then
        log "INFO" "Skipping icon theme setup (disabled in config)"
        return 0
    fi
    
    local icons=$(python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['desktop']['icons']['name'])")
    
    log "INFO" "Setting icon theme to $icons"
    gsettings set org.gnome.desktop.interface icon-theme "$icons"
    
    update_progress
}

# Function to set cursor theme
desktop_set_cursor() {
    if ! python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['desktop']['cursor']['enabled'])" | grep -q "True"; then
        log "INFO" "Skipping cursor theme setup (disabled in config)"
        return 0
    fi
    
    local cursor=$(python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['desktop']['cursor']['name'])")
    local size=$(python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['desktop']['cursor']['size'])")
    
    log "INFO" "Setting cursor theme to $cursor (size: $size)"
    gsettings set org.gnome.desktop.interface cursor-theme "$cursor"
    gsettings set org.gnome.desktop.interface cursor-size "$size"
    
    update_progress
}

# Function to configure dock settings
desktop_configure_dock() {
    if ! python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['desktop']['dock']['enabled'])" | grep -q "True"; then
        log "INFO" "Skipping dock configuration (disabled in config)"
        return 0
    fi
    
    log "INFO" "Configuring dock settings"
    
    # Position (left, right, bottom)
    local position=$(python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['desktop']['dock']['position'])")
    gsettings set org.gnome.shell.extensions.dash-to-dock dock-position "$position"
    
    # Auto-hide
    local autohide=$(python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['desktop']['dock']['autohide'])")
    if [ "$autohide" = "True" ]; then
        gsettings set org.gnome.shell.extensions.dash-to-dock autohide true
    else
        gsettings set org.gnome.shell.extensions.dash-to-dock autohide false
    fi
    
    # Icon size
    local icon_size=$(python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['desktop']['dock']['icon_size'])")
    gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size "$icon_size"
    
    update_progress
}

# Function to configure desktop background
desktop_set_background() {
    if ! python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['desktop']['background']['enabled'])" | grep -q "True"; then
        log "INFO" "Skipping background configuration (disabled in config)"
        return 0
    fi
    
    local background=$(python3 -c "import yaml, os; print(os.path.expanduser(yaml.safe_load(open('$CONFIG_FILE'))['desktop']['background']['path']))")
    
    log "INFO" "Setting desktop background to $background"
    gsettings set org.gnome.desktop.background picture-uri "file://$background"
    gsettings set org.gnome.desktop.background picture-uri-dark "file://$background"
    
    update_progress
}

# Main function for this module
desktop_main() {
    log "INFO" "Starting desktop customization module..."
    
    desktop_set_theme
    desktop_set_icons
    desktop_set_cursor
    desktop_configure_dock
    desktop_set_background
    
    log "SUCCESS" "Desktop customization module completed successfully"
}
