#!/usr/bin/env bash
# Description: Install packages from apt repositories

# Function to add PPAs
apt_add_repositories() {
    log "INFO" "Adding additional repositories..."
    
    # Add any PPAs or third-party repositories here
    # Example: sudo add-apt-repository -y ppa:some/repository
}

# Function to update package lists
apt_update() {
    log "INFO" "Updating package lists..."
    sudo apt-get update
    update_progress
}

# Function to install packages
apt_install_packages() {
    local packages=$(python3 -c "
import yaml
config = yaml.safe_load(open('$CONFIG_FILE'))
packages = config['apt']['packages']
print(' '.join(packages))
")
    
    log "INFO" "Installing apt packages..."
    
    # Count number of packages for progress tracking
    local package_count=$(echo "$packages" | wc -w)
    local current=0
    
    for package in $packages; do
        log "INFO" "Installing package: $package"
        sudo apt-get install -y "$package"
        current=$((current + 1))
        update_progress
    done
}

# Function to clean up
apt_cleanup() {
    log "INFO" "Cleaning up apt cache..."
    sudo apt-get autoremove -y
    sudo apt-get clean
    update_progress
}

# Main function for this module
apt_main() {
    log "INFO" "Starting apt module..."
    
    apt_add_repositories
    apt_update
    apt_install_packages
    apt_cleanup
    
    log "SUCCESS" "Apt module completed successfully"
}
