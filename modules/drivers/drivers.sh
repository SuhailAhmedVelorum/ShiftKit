#!/usr/bin/env bash
# Description: Install and configure hardware drivers

# Function to install fingerprint scanner driver
drivers_install_fingerprint() {
    if ! python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['drivers']['fingerprint']['enabled'])" | grep -q "True"; then
        log "INFO" "Skipping fingerprint driver installation (disabled in config)"
        return 0
    fi
    
    local model=$(python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['drivers']['fingerprint']['model'])")
    local device=$(python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['drivers']['fingerprint']['device'])")
    
    log "INFO" "Installing fingerprint driver for $model on $device..."
    
    # Install dependencies
    sudo apt-get install -y fprintd libpam-fprintd
    
    # For Goodix fingerprint readers on Dell laptops
    if [ "$model" = "goodix" ] && [ "$device" = "dell" ]; then
        # Create a temporary directory
        local temp_dir=$(mktemp -d)
        
        # Clone the goodix driver repository
        git clone https://gitlab.com/goodix/fingerprint-sensor-controller.git "$temp_dir/goodix-fp"
        
        # Build and install
        cd "$temp_dir/goodix-fp"
        ./autogen.sh
        ./configure
        make
        sudo make install
        
        # Enable the service
        sudo systemctl enable fingerprint-sensor-controller
        sudo systemctl start fingerprint-sensor-controller
        
        # Clean up
        rm -rf "$temp_dir"
        
        # Configure PAM to use fingerprint authentication
        if ! grep -q "auth sufficient pam_fprintd.so" /etc/pam.d/common-auth; then
            sudo sed -i '/^auth.*pam_unix.so/i auth sufficient pam_fprintd.so' /etc/pam.d/common-auth
        fi
    fi
    
    update_progress
}

# Function to install graphics drivers
drivers_install_graphics() {
    log "INFO" "Checking for graphics drivers..."
    
    # Check for NVIDIA
    if lspci | grep -i nvidia &> /dev/null; then
        log "INFO" "NVIDIA GPU detected, installing drivers..."
        sudo apt-get install -y nvidia-driver-535 nvidia-settings
    fi
    
    # Check for AMD
    if lspci | grep -i amd &> /dev/null; then
        log "INFO" "AMD GPU detected, installing drivers..."
        sudo apt-get install -y mesa-vulkan-drivers libvulkan1 mesa-vulkan-drivers:i386 libvulkan1:i386
    fi
    
    update_progress
}

# Function to install other hardware drivers
drivers_install_other() {
    log "INFO" "Installing additional hardware drivers..."
    
    # Run ubuntu-drivers to install recommended drivers
    if command -v ubuntu-drivers &> /dev/null; then
        log "INFO" "Installing recommended drivers..."
        sudo ubuntu-drivers autoinstall
    fi
    
    update_progress
}

# Main function for this module
drivers_main() {
    log "INFO" "Starting drivers module..."
    
    drivers_install_fingerprint
    drivers_install_graphics
    drivers_install_other
    
    log "SUCCESS" "Drivers module completed successfully"
}
