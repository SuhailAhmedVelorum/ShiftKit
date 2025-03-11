#!/usr/bin/env bash
# Description: Configure security settings and install security tools

# Function to install security tools
security_install_tools() {
    log "INFO" "Installing security tools..."
    
    # Install common security tools
    sudo apt-get install -y fail2ban rkhunter chkrootkit clamav clamav-daemon auditd apparmor apparmor-utils
    
    update_progress
}

# Function to configure automatic updates
security_configure_updates() {
    if ! python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['security']['auto_updates']['enabled'])" | grep -q "True"; then
        log "INFO" "Skipping automatic updates configuration (disabled in config)"
        return 0
    fi
    
    log "INFO" "Configuring automatic security updates..."
    
    # Install unattended-upgrades
    sudo apt-get install -y unattended-upgrades apt-listchanges
    
    # Configure unattended-upgrades
    sudo tee /etc/apt/apt.conf.d/20auto-upgrades > /dev/null << EOF
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Unattended-Upgrade "1";
APT::Periodic::AutocleanInterval "7";
EOF
    
    # Configure which updates to install automatically
    sudo tee /etc/apt/apt.conf.d/50unattended-upgrades > /dev/null << EOF
Unattended-Upgrade::Allowed-Origins {
    "\${distro_id}:\${distro_codename}";
    "\${distro_id}:\${distro_codename}-security";
    "\${distro_id}ESMApps:\${distro_codename}-apps-security";
    "\${distro_id}ESM:\${distro_codename}-infra-security";
};
Unattended-Upgrade::Package-Blacklist {
};
Unattended-Upgrade::AutoFixInterruptedDpkg "true";
Unattended-Upgrade::MinimalSteps "true";
Unattended-Upgrade::InstallOnShutdown "false";
Unattended-Upgrade::Remove-Unused-Dependencies "true";
Unattended-Upgrade::Automatic-Reboot "false";
EOF
    
    # Enable and start the service
    sudo systemctl enable unattended-upgrades
    sudo systemctl restart unattended-upgrades
    
    update_progress
}

# Function to configure fail2ban
security_configure_fail2ban() {
    if ! python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['security']['fail2ban']['enabled'])" | grep -q "True"; then
        log "INFO" "Skipping fail2ban configuration (disabled in config)"
        return 0
    fi
    
    log "INFO" "Configuring fail2ban..."
    
    # Create fail2ban configuration
    sudo tee /etc/fail2ban/jail.local > /dev/null << EOF
[DEFAULT]
bantime = 1h
findtime = 10m
maxretry = 5

[sshd]
enabled = true
port = ssh
filter = sshd
logpath = /var/log/auth.log
maxretry = 3
EOF
    
    # Enable and restart fail2ban
    sudo systemctl enable fail2ban
    sudo systemctl restart fail2ban
    
    update_progress
}

# Function to configure SSH
security_configure_ssh() {
    if ! python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['security']['ssh']['enabled'])" | grep -q "True"; then
        log "INFO" "Skipping SSH configuration (disabled in config)"
        return 0
    fi
    
    log "INFO" "Configuring SSH security settings..."
    
    # Create a backup of the SSH config file
    sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup
    
    # Configure SSH
    local port=$(python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['security']['ssh']['port'])")
    local permit_root=$(python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['security']['ssh']['permit_root_login'])")
    local password_auth=$(python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['security']['ssh']['password_authentication'])")
    
    # Update SSH configuration
    sudo sed -i "s/^#Port 22/Port $port/" /etc/ssh/sshd_config
    
    if [ "$permit_root" = "True" ]; then
        sudo sed -i "s/^#PermitRootLogin prohibit-password/PermitRootLogin yes/" /etc/ssh/sshd_config
    else
        sudo sed -i "s/^#PermitRootLogin prohibit-password/PermitRootLogin no/" /etc/ssh/sshd_config
    fi
    
    if [ "$password_auth" = "True" ]; then
        sudo sed -i "s/^#PasswordAuthentication yes/PasswordAuthentication yes/" /etc/ssh/sshd_config
    else
        sudo sed -i "s/^#PasswordAuthentication yes/PasswordAuthentication no/" /etc/ssh/sshd_config
    fi
    
    # Restart SSH service
    sudo systemctl restart ssh
    
    update_progress
}

# Function to configure firewall (UFW)
security_configure_firewall() {
    if ! python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['security']['firewall']['enabled'])" | grep -q "True"; then
        log "INFO" "Skipping firewall configuration (disabled in config)"
        return 0
    fi
    
    log "INFO" "Configuring firewall (UFW)..."
    
    # Install UFW if not already installed
    if ! command -v ufw &> /dev/null; then
        sudo apt-get install -y ufw
    fi
    
    # Reset UFW to default
    sudo ufw --force reset
    
    # Default policies
    sudo ufw default deny incoming
    sudo ufw default allow outgoing
    
    # Allow SSH
    local ssh_port=$(python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['security']['ssh']['port'])")
    sudo ufw allow "$ssh_port"/tcp
    
    # Get additional ports from config
    local ports=$(python3 -c "
import yaml
config = yaml.safe_load(open('$CONFIG_FILE'))
if 'firewall' in config['security'] and 'allow_ports' in config['security']['firewall']:
    print(' '.join(str(p) for p in config['security']['firewall']['allow_ports']))
else:
    print('')
")
    
    # Allow additional ports
    if [ -n "$ports" ]; then
        for port in $ports; do
            log "INFO" "Allowing port: $port"
            sudo ufw allow "$port"
        done
    fi
    
    # Enable UFW
    sudo ufw --force enable
    
    update_progress
}

# Function to configure system auditing
security_configure_audit() {
    if ! python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['security']['audit']['enabled'])" | grep -q "True"; then
        log "INFO" "Skipping audit configuration (disabled in config)"
        return 0
    fi
    
    log "INFO" "Configuring system auditing..."
    
    # Install auditd if not already installed
    if ! command -v auditd &> /dev/null; then
        sudo apt-get install -y auditd audispd-plugins
    fi
    
    # Configure basic audit rules
    sudo tee /etc/audit/rules.d/audit.rules > /dev/null << EOF
# Delete all previous rules
-D

# Set buffer size
-b 8192

# Failure Mode
-f 1

# Monitor for changes to system authentication files
-w /etc/passwd -p wa -k identity
-w /etc/group -p wa -k identity
-w /etc/shadow -p wa -k identity
-w /etc/gshadow -p wa -k identity

# Monitor for changes to system configuration files
-w /etc/ssh/sshd_config -p wa -k sshd
-w /etc/sudoers -p wa -k sudoers

# Monitor for changes to system startup files
-w /etc/init.d/ -p wa -k init
-w /etc/systemd/ -p wa -k systemd

# Monitor for changes to system log files
-w /var/log/auth.log -p wa -k auth_log
-w /var/log/syslog -p wa -k syslog

# Monitor for changes to the audit configuration
-w /etc/audit/ -p wa -k audit_config
-w /etc/libaudit.conf -p wa -k audit_config
-w /etc/audisp/ -p wa -k audit_config

# Monitor for changes to the cron configuration
-w /etc/crontab -p wa -k cron
-w /etc/cron.allow -p wa -k cron
-w /etc/cron.deny -p wa -k cron
-w /etc/cron.d/ -p wa -k cron
-w /etc/cron.daily/ -p wa -k cron
-w /etc/cron.hourly/ -p wa -k cron
-w /etc/cron.monthly/ -p wa -k cron
-w /etc/cron.weekly/ -p wa -k cron

# Monitor for changes to user home directories
-w /home/ -p wa -k home_changes

# Monitor for unsuccessful unauthorized access attempts
-a always,exit -F arch=b64 -S open -F exit=-EACCES -k access
-a always,exit -F arch=b64 -S open -F exit=-EPERM -k access
EOF
    
    # Enable and restart auditd
    sudo systemctl enable auditd
    sudo systemctl restart auditd
    
    update_progress
}

# Main function for this module
security_main() {
    log "INFO" "Starting security module..."
    
    security_install_tools
    security_configure_updates
    security_configure_fail2ban
    security_configure_ssh
    security_configure_firewall
    security_configure_audit
    
    log "SUCCESS" "Security module completed successfully"
}
