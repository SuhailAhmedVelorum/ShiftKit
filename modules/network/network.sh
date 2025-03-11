#!/usr/bin/env bash
# Description: Configure network settings and VPN connections

# Function to install network tools
network_install_tools() {
    log "INFO" "Installing network tools..."
    
    # Install common network tools
    sudo apt-get install -y net-tools nmap traceroute whois dnsutils curl wget
    
    update_progress
}


# Function to configure VPN connections
network_configure_vpn() {
    if ! python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['network']['vpn']['enabled'])" | grep -q "True"; then
        log "INFO" "Skipping VPN configuration (disabled in config)"
        return 0
    fi
    
    log "INFO" "Configuring VPN connections..."
    
    # Get VPN type from config
    local vpn_type=$(python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['network']['vpn']['type'])")
    
    case "$vpn_type" in
        "openvpn")
            # Install OpenVPN
            sudo apt-get install -y openvpn network-manager-openvpn network-manager-openvpn-gnome
            
            # Get OpenVPN configuration
            local config_file=$(python3 -c "import yaml, os; print(os.path.expanduser(yaml.safe_load(open('$CONFIG_FILE'))['network']['vpn']['config_file']))")
            local connection_name=$(python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['network']['vpn']['connection_name'])")
            
            # Import OpenVPN configuration
            if [ -f "$config_file" ]; then
                log "INFO" "Importing OpenVPN configuration from $config_file"
                nmcli connection import type openvpn file "$config_file"
                
                # Rename the connection if needed
                if [ -n "$connection_name" ]; then
                    local imported_name=$(nmcli -g NAME connection show | grep -i "openvpn" | head -n 1)
                    if [ -n "$imported_name" ]; then
                        nmcli connection modify "$imported_name" connection.id "$connection_name"
                    fi
                fi
            else
                log "ERROR" "OpenVPN configuration file not found: $config_file"
            fi
            ;;
            
        "wireguard")
            # Install WireGuard
            sudo apt-get install -y wireguard resolvconf
            
            # Get WireGuard configuration
            local config_file=$(python3 -c "import yaml, os; print(os.path.expanduser(yaml.safe_load(open('$CONFIG_FILE'))['network']['vpn']['config_file']))")
            local connection_name=$(python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['network']['vpn']['connection_name'])")
            
            # Import WireGuard configuration
            if [ -f "$config_file" ]; then
                log "INFO" "Setting up WireGuard configuration from $config_file"
                sudo cp "$config_file" /etc/wireguard/wg0.conf
                sudo systemctl enable wg-quick@wg0
            else
                log "ERROR" "WireGuard configuration file not found: $config_file"
            fi
            ;;
            
        "nordvpn")
            # Install NordVPN
            sh <(wget -qO - https://downloads.nordcdn.com/apps/linux/install.sh) -p nordvpn-gui
            ;;
            
        *)
            log "WARNING" "Unsupported VPN type: $vpn_type"
            ;;
    esac
    
    update_progress
}

# Function to configure firewall
network_configure_firewall() {
    if ! python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['network']['firewall']['enabled'])" | grep -q "True"; then
        log "INFO" "Skipping firewall configuration (disabled in config)"
        return 0
    fi
    
    log "INFO" "Configuring firewall..."
    
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
    sudo ufw allow ssh
    
    # Get additional ports from config
    local ports=$(python3 -c "
import yaml
config = yaml.safe_load(open('$CONFIG_FILE'))
if 'firewall' in config['network'] and 'allow_ports' in config['network']['firewall']:
    print(' '.join(str(p) for p in config['network']['firewall']['allow_ports']))
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

# Function to configure DNS settings
network_configure_dns() {
    if ! python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['network']['dns']['enabled'])" | grep -q "True"; then
        log "INFO" "Skipping DNS configuration (disabled in config)"
        return 0
    fi
    
    log "INFO" "Configuring DNS settings..."
    
    # Get DNS servers from config
    local dns_servers=$(python3 -c "
import yaml
config = yaml.safe_load(open('$CONFIG_FILE'))
if 'dns' in config['network'] and 'servers' in config['network']['dns']:
    print(' '.join(config['network']['dns']['servers']))
else:
    print('')
")
    
    if [ -n "$dns_servers" ]; then
        # Create a backup of the resolv.conf file
        sudo cp /etc/resolv.conf /etc/resolv.conf.backup
        
        # Create a new resolv.conf file
        echo "# Generated by ShiftKit" | sudo tee /etc/resolv.conf > /dev/null
        
        # Add each DNS server
        for server in $dns_servers; do
            echo "nameserver $server" | sudo tee -a /etc/resolv.conf > /dev/null
        done
        
	sudo systemctl restart systemd-resolved
    fi
    
    update_progress
}

# Main function for this module
network_main() {
    log "INFO" "Starting network configuration module..."
    
    network_install_tools
    network_configure_vpn
    network_configure_firewall
    network_configure_dns
    
    log "SUCCESS" "Network configuration module completed successfully"
}
