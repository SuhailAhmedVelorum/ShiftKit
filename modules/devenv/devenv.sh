#!/usr/bin/env bash
# Description: Set up development environments and tools

# Function to install development tools
devenv_install_tools() {
    log "INFO" "Installing common development tools..."
    
    # Install common development tools
    local dev_tools="perl zsh"
    sudo apt-get install -y $dev_tools
    
    update_progress
}

# Function to set up Python development environment
devenv_setup_python() {
    if ! python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['devenv']['python']['enabled'])" | grep -q "True"; then
        log "INFO" "Skipping Python development environment setup (disabled in config)"
        return 0
    fi
    
    log "INFO" "Setting up Python development environment..."
    
    # Install Python tools
    sudo apt-get install -y python3-dev python3-pip python3-venv
    
    # Install virtualenvwrapper
    pip3 install virtualenvwrapper
    
    # Add virtualenvwrapper to bashrc if not already there
    if ! grep -q "virtualenvwrapper.sh" "$HOME/.bashrc"; then
        cat >> "$HOME/.bashrc" << EOF

# Virtualenvwrapper settings
export WORKON_HOME=\$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
source \$(which virtualenvwrapper.sh)
EOF
    fi
    
    # Install common Python packages
    pip3 install --user pytest black flake8 mypy ipython jupyter
    
    update_progress
}


# Function to set up Docker
devenv_setup_docker() {
    if ! python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['devenv']['docker']['enabled'])" | grep -q "True"; then
        log "INFO" "Skipping Docker setup (disabled in config)"
        return 0
    fi
    
    log "INFO" "Setting up Docker..."
    
    # Install dependencies
    sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
    
    # Add Docker's official GPG key
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    
    # Add Docker repository
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    
    # Update package database
    sudo apt-get update
    
    # Install Docker
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io
    
    # Add user to docker group
    sudo usermod -aG docker "$USER"
    
    # Install Docker Compose
    sudo curl -L "https://github.com/docker/compose/releases/download/v2.16.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    
    update_progress
}

# Function to set up VS Code
devenv_setup_vscode() {
    if ! python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['devenv']['vscode']['enabled'])" | grep -q "True"; then
        log "INFO" "Skipping VS Code setup (disabled in config)"
        return 0
    fi
    
    log "INFO" "Setting up Visual Studio Code..."
    
    # Install VS Code if not already installed
    if ! command -v code &> /dev/null; then
        wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
        sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
        sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
        rm -f packages.microsoft.gpg
        sudo apt-get update
        sudo apt-get install -y code
    fi
    
    # Install VS Code extensions
    local extensions=$(python3 -c "
import yaml, json
config = yaml.safe_load(open('$CONFIG_FILE'))
if 'vscode' in config['devenv'] and 'extensions' in config['devenv']['vscode']:
    print(' '.join(config['devenv']['vscode']['extensions']))
else:
    print('')
")
    
    if [ -n "$extensions" ]; then
        log "INFO" "Installing VS Code extensions..."
        for ext in $extensions; do
            code --install-extension "$ext"
        done
    fi
    
    update_progress
}

# Function to set up Git configuration
devenv_setup_git() {
    if ! python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['devenv']['git']['enabled'])" | grep -q "True"; then
        log "INFO" "Skipping Git configuration (disabled in config)"
        return 0
    fi
    
    log "INFO" "Setting up Git configuration..."
    
    # Get Git configuration from config
    local git_name=$(python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['devenv']['git'].get('name', ''))")
    local git_email=$(python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['devenv']['git'].get('email', ''))")
    local git_editor=$(python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['devenv']['git'].get('editor', 'vim'))")
    
    # Configure Git if name and email are provided
    if [ -n "$git_name" ] && [ -n "$git_email" ]; then
        git config --global user.name "$git_name"
        git config --global user.email "$git_email"
    fi
    
    # Configure Git editor
    git config --global core.editor "$git_editor"
    
    # Configure default branch name
    git config --global init.defaultBranch main
    
    # Create a global gitignore file
    cat > "$HOME/.gitignore_global" << EOF
# Global .gitignore file
.DS_Store
.vscode/
.idea/
*.swp
*.swo
*~
.env
node_modules/
__pycache__/
*.py[cod]
*$py.class
EOF
    
    git config --global core.excludesfile "$HOME/.gitignore_global"
    
    update_progress
}

# Main function for this module
devenv_main() {
    log "INFO" "Starting development environment module..."
    
    devenv_install_tools
    devenv_setup_python
    devenv_setup_docker
    devenv_setup_vscode
    devenv_setup_git
    
    log "SUCCESS" "Development environment module completed successfully"
}
