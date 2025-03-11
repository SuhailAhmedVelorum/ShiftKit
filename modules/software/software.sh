#!/usr/bin/env bash
# Description: Install third-party software applications

# Function to install Steam
software_install_steam() {
    if ! python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['software']['steam']['enabled'])" | grep -q "True"; then
        log "INFO" "Skipping Steam installation (disabled in config)"
        return 0
    fi
    
    log "INFO" "Installing Steam..."
    local download_url=$(python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['software']['steam']['url'])")
    
    # Create a temporary directory for the download
    local temp_dir=$(mktemp -d)
    
    # Download the installer
    curl -L "$download_url" -o "$temp_dir/steam_installer.deb"
    
    # Install the downloaded package
    sudo dpkg -i "$temp_dir/steam_installer.deb"
    
    # Clean up
    rm -rf "$temp_dir"
    
    update_progress
}

# Function to install Steam
software_install_windsurf() {
    if ! python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['software']['windsurf']['enabled'])" | grep -q "True"; then
        log "INFO" "Skipping Windsurf installation (disabled in config)"
        return 0
    fi
    
    log "INFO" "Installing Windsurf..."
    local repo_url=$(python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['software']['windsurf']['repo_url'])")
    local gpg_key="$repo_url/windsurf.gpg"
    local apt_url="$repo_url/apt"
    local gpg_key_local="/usr/share/keyrings/windsurf-stable-archive-keyring.gpg"

    curl -fsSL "$gpg_key" | sudo gpg --dearmor -o $gpg_key_local
    echo "deb [signed-by=$gpg_key_local arch=amd64] $apt_url stable main" | sudo tee /etc/apt/sources.list.d/windsurf.list > /dev/null
    sudo apt-get update
    sudo apt-get upgrade -y windsurf

    update_progress
}

# Function to install python (Build LTS from source)
software_build_python() {
    if ! python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['software']['python']['enabled'])" | grep -q "True"; then
        log "INFO" "Skipping Python installation (disabled in config)"
        return 0
    fi
    
    log "INFO" "Building Python from source..."
   
    sudo apt-get install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev
    version_script=$(cat <<'EOF'
import requests
import re
url="https://www.python.org/ftp/python/"
response = requests.get(url)
versions = re.findall(r'href="([\d\.]+)/"', response.text)
versions = [v for v in versions if v != '..']
versions = sorted(set(versions), key=lambda s: tuple(map(int, s.split('.'))))
latest_version = versions[-1]
files = requests.get(f"https://www.python.org/ftp/python/{latest_version}/").text
file = re.findall(r'href="Python-([\d]+\.[\d]+\.[\d]+(?:[abrc]\d+)?)\.tgz"', files)
file = file[-1]
print(f"https://www.python.org/ftp/python/{latest_version}/Python-{file}.tgz")
EOF
)
    # Download the latest version of Python
    download_url=$(python3 -c "$version_script")
    temp_dir=$(mktemp -d)
    wget "$download_url" -O "$temp_dir/Python.tgz"
    tar -xvf "$temp_dir/Python.tgz" -C "$temp_dir"
    cd $temp_dir/Python-*
    ./configure --enable-optimizations
    make -j $(nproc)
    sudo make altinstall
    sudo rm -rf "$temp_dir"

    local file=$(ls /usr/local/bin/python* | head -n1)
    local name=$(basename "$file")
    local pyver=${name#python}

    # Create symlinks
    local python3_target="/usr/local/bin/python${pyver}"
    local pip3_target="/usr/local/bin/pip${pyver}"

    # python3 symlink
    if [ ! -L /usr/local/bin/python3 ]; then
      sudo ln -s "$python3_target" /usr/local/bin/python3
      echo "Created symlink: /usr/local/bin/python3 -> $python3_target"
    else
      echo "Symlink /usr/local/bin/python3 already exists"
    fi

    # python symlink
    if [ ! -L /usr/local/bin/python ]; then
      sudo ln -s /usr/local/bin/python3 /usr/local/bin/python
      echo "Created symlink: /usr/local/bin/python -> /usr/local/bin/python3"
    else
      echo "Symlink /usr/local/bin/python already exists"
    fi

    # pip3 symlink
    if [ ! -L /usr/local/bin/pip3 ]; then
      sudo ln -s "$pip3_target" /usr/local/bin/pip3
      echo "Created symlink: /usr/local/bin/pip3 -> $pip3_target"
    else
      echo "Symlink /usr/local/bin/pip3 already exists"
    fi

    # pip symlink
    if [ ! -L /usr/local/bin/pip ]; then
      sudo ln -s /usr/local/bin/pip3 /usr/local/bin/pip
      echo "Created symlink: /usr/local/bin/pip -> /usr/local/bin/pip3"
    else
      echo "Symlink /usr/local/bin/pip already exists"
    fi

    update_progress
}

# Function to install Neovim
software_install_neovim() {
    if ! python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['software']['neovim']['enabled'])" | grep -q "True"; then
        log "INFO" "Skipping Neovim installation (disabled in config)"
        return 0
    fi
    
    log "INFO" "Installing Neovim from source..."
    local repo=$(python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['software']['neovim']['repo'])")
    
    # Install dependencies
    sudo apt-get install -y ninja-build gettext cmake unzip curl
    
    # Create a temporary directory for the build
    local temp_dir=$(mktemp -d)
    
    # Clone the repository
    git clone "$repo" "$temp_dir/neovim"
    
    # Build and install
    cd "$temp_dir/neovim"
    make CMAKE_BUILD_TYPE=Release
    sudo make install
    
    # Clean up
    rm -rf "$temp_dir"
    
    update_progress
}

# Function to install Node.js using NVM
software_install_node() {
    if ! python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['software']['node']['enabled'])" | grep -q "True"; then
        log "INFO" "Skipping Node.js installation (disabled in config)"
        return 0
    fi
    
    log "INFO" "Installing Node.js using NVM..."
    local installer_url=$(python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['software']['node']['installer_url'])")
    # Download and install nvm:
    cd $SCRIPT_DIR
    curl -o- $installer_url | bash

    # in lieu of restarting the shell
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

    # Download and install Node.js:
    local version=$(python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['software']['node']['version'])")

    # Install Node.js
    if [ "$version" = "lts" ]; then
        nvm install --lts
        nvm use --lts
    else
        nvm install "$version"
        nvm use "$version"
    fi

    
    update_progress
}


# Function to install Ghostty
software_install_ghostty() {
    if ! python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['software']['ghostty']['enabled'])" | grep -q "True"; then
        log "INFO" "Skipping Ghostty installation (disabled in config)"
        return 0
    fi
    
    snap install ghostty --classic

    update_progress
}

# Function to install Telegram
software_install_telegram() {
    if ! python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['software']['telegram']['enabled'])" | grep -q "True"; then
        log "INFO" "Skipping Telegram installation (disabled in config)"
        return 0
    fi
    
    log "INFO" "Installing Telegram via Flatpak..."
    
    # Make sure flatpak is installed
    if ! command -v flatpak &> /dev/null; then
        sudo apt-get install -y flatpak
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    fi
    
    # Install Telegram
    flatpak install -y flathub org.telegram.desktop
    
    update_progress
}

# Function to install Solaar
software_install_solaar() {
    if ! python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['software']['solaar']['enabled'])" | grep -q "True"; then
        log "INFO" "Skipping Solaar installation (disabled in config)"
        return 0
    fi
    
    log "INFO" "Installing Solaar..."
    sudo apt-get install -y solaar
    update_progress
}

# Main function for this module
software_main() {
    log "INFO" "Starting software module..."
    
    software_install_steam
    software_install_windsurf
    software_install_neovim
    software_install_node
    software_build_python
    software_install_ghostty
    software_install_telegram
    software_install_solaar
    
    log "SUCCESS" "Software module completed successfully"
}
