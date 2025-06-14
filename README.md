shiftkit/config.yaml                                                                                0000664 0001750 0001750 00000012773 15023605475 013543  0                                                                                                    ustar   nope                            nope                                                                                                                                                                                                                   # ShiftKit Configuration File

# Global settings
settings:
  log_level: INFO
  backup_configs: true
  backup_dir: ~/.shiftkit_backups
  sudo_timeout: 30  # Minutes to keep sudo alive

# Modules to execute (in order)
modules:
  - name: apt
    enabled: false
    description: Install packages from apt repositories
    
  - name: software
    enabled: false
    description: Install third-party software
    
  - name: configs
    enabled: false
    description: Restore configuration files
    
  - name: system
    enabled: false
    description: Configure system settings
    
  - name: drivers
    enabled: false
    description: Install and configure drivers
    
  - name: custom
    enabled: false
    description: User-specific customizations and installations
    
  - name: backup
    enabled: false
    description: Backup and restore important user data
    
  - name: devenv
    enabled: true
    description: Set up development environments and tools
    
  - name: desktop
    enabled: true
    description: Customize desktop environment settings
    
  - name: network
    enabled: true
    description: Configure network settings and VPN connections
    
  - name: security
    enabled: true
    description: Configure security settings and install security tools

# Module-specific configurations
apt:
  packages:
    - build-essential
    - git
    - curl
    - wget
    - vim
    - htop
    - tmux
    - zsh
    - ripgrep
    - fd-find
    - fzf
    - jq
    - neofetch
    - tldr
    - unzip
    - zip
    - gnome-tweaks
    - dconf-editor

software:
  steam:
    enabled: false
    method: custom
    url: "https://repo.steampowered.com/steam/archive/precise/steam_latest.deb"
    
  windsurf:
    enabled: false
    method: custom
    repo_url: "https://windsurf-stable.codeiumdata.com/wVxQEIWkwPUEAGf3"
    
  neovim:
    enabled: false
    method: build
    repo: "https://github.com/neovim/neovim.git"
    
  node:
    enabled: false
    method: nvm
    version: lts
    installer_url: "https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh"
    
  python:
    enabled: false
    method: build
    version: "latest"
    
  ghostty:
    enabled: false
    method: custom
    repo: "https://github.com/ghostty-org/ghostty"
    
  telegram:
    enabled: false
    method: flatpak
    
  solaar:
    enabled: false
    method: custom
    repo: "https://github.com/pwr-solar/solaar"

  #! Add these
  # gh, 

configs:
  bashrc:
    enabled: true
    source: "configs/bashrc"
    target: "~/.bashrc"
    
  tiling_manager:
    enabled: false
    name: "sway"
    source: "configs/sway"
    
  neovim:
    repo: "https://github.com/SuhailAhmedVelorum/nvim-config.git"

  rice:
    enabled: true
    theme: "configs/theme"
    icons: "configs/icons"
    fonts: "configs/fonts"

system:
  timeout:
    enabled: true
    value: 300  # seconds
    
  battery_percentage:
    enabled: true
    show: true
    
  hot_corner:
    enabled: true
    action: "show_applications"
    
  performance_mode:
    enabled: true
    mode: "performance"  # balanced, performance, power-save

drivers:
  fingerprint:
    enabled: false # Figure this shit out
    model: "goodix"
    device: "dell"

# Custom module configurations
custom:
  packages:
    - ffmpeg
    - vlc
    - cloudflared
    
  repositories:
    #- url: "https://github.com/example/dotfiles.git"
    #  directory: "dotfiles"
    #  branch: "main"
      
  commands:
    - command: "echo 'Custom command executed' > ~/custom_command_executed.txt"
      description: "Create a marker file to indicate custom commands ran"
    - command: "gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'"
      description: "Set dark mode as default"

# Backup module configurations
# !BROKEN
backup:
  enabled: false

  base_dir: "~/.shiftkit_backups"
  
  documents:
    enabled: true
    source_dir: "~/Documents"
  
  projects:
    enabled: true
    source_dir: "~/Projects"
  
  browser_data:
    enabled: true
    browser: "firefox"
  
  restore:
    enabled: false
    type: "documents"
    file: "~/.shiftkit_backups/documents/documents_backup.tar.gz"
    target_dir: "~/Restored"

# Development environment configurations
devenv:
  python:
    enabled: true

  docker:
    enabled: true
  
  vscode:
    enabled: true
    extensions:
      - "ms-python.python"
      - "ms-vscode.cpptools"
      - "ms-azuretools.vscode-docker"
      - "dbaeumer.vscode-eslint"
      - "esbenp.prettier-vscode"
      - "ms-vscode.cmake-tools"
  
  git:
    enabled: true
    name: "Suhail Ahmed"
    email: "suhailahmedvelorum@gmail.com"
    editor: "windsurf --wait"

# Desktop environment configurations
desktop:
  theme:
    enabled: true
    name: "Adwaita-dark"
  
  icons:
    enabled: true
    name: "Papirus-Dark"
  
  cursor:
    enabled: true
    name: "Adwaita"
    size: 24
  
  dock:
    enabled: true
    position: "BOTTOM"
    autohide: true
    icon_size: 48
  
  background:
    enabled: true
    path: "~/Pictures/Wallpapers/default.jpg"

# Network configuration
network:
  vpn:
    enabled: true
    type: "nordvpn"
  
  firewall:
    enabled: true
    allow_ports:
      - 22    # SSH
      - 80    # HTTP
      - 443   # HTTPS
  
  dns:
    enabled: true
    servers:
      - "1.1.1.1"
      - "8.8.8.8"

# Security configuration
security:
  auto_updates:
    enabled: true
  
  fail2ban:
    enabled: true
  
  ssh:
    enabled: true
    port: 22
    permit_root_login: false
    password_authentication: true
  
  firewall:
    enabled: true
    allow_ports:
      - 80    # HTTP
      - 443   # HTTPS
  
  audit:
    enabled: true
     shiftkit/configs/                                                                                   0000775 0001750 0001750 00000000000 15023573516 013030  5                                                                                                    ustar   nope                            nope                                                                                                                                                                                                                   shiftkit/configs/bashrc/                                                                            0000775 0001750 0001750 00000000000 15023573514 014270  5                                                                                                    ustar   nope                            nope                                                                                                                                                                                                                   shiftkit/configs/bashrc/bashrc                                                                      0000664 0001750 0001750 00000010542 15023573514 015457  0                                                                                                    ustar   nope                            nope                                                                                                                                                                                                                   # ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length
HISTSIZE=10000
HISTFILESIZE=20000

# check the window size after each command
shopt -s checkwinsize

# make less more friendly for non-text input files
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi

# prompt color
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
	if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
		color_prompt=yes
	else
		color_prompt=
	fi
fi

if [ "$color_prompt" = yes ]; then
	PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
	PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$'
fi
unset color_prompt force_color_prompt



# enable color support of ls and grep
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# enable programmable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Aliases
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# User specific environment and startup programs
export PATH=$HOME/.local/bin:$PATH

# NVM setup
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Python virtualenv
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
source /usr/local/bin/virtualenvwrapper.sh 2>/dev/null || true

# Custom aliases
alias update='sudo apt update && sudo apt upgrade -y'
alias install='sudo apt install -y'
alias remove='sudo apt remove -y'
alias purge='sudo apt purge -y'
alias autoremove='sudo apt autoremove -y'
alias search='apt search'

# Git aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias gco='git checkout'
alias gb='git branch'

# Custom functions
mkcd() {
    mkdir -p "$1" && cd "$1"
}

extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

function telpush() {
	MSG="PING!!!"
	if [ -n "$1" ]; then
		MSG=$1
	fi
	curl -s -o /dev/null -X POST -H "Content-Type: application/json" -d "{\"chat_id\": \"5702377908\", \"text\": \"$MSG\", \"disable_notification\": false}" https://api.telegram.org/bot6483725739:AAH0NL5Kw2SjgsSD3454nBhkD8cnx3mkDYI/sendMessage
	echo "SENT MESSAGE!"
}
export -f telpush;

add_paths_to_bashrc() {
  local paths=(
    "/usr/local/bin/"
    "$HOME/.local/bin"
  )
  for p in "${paths[@]}"; do
    line="export PATH=$p:\$PATH"
    grep -qxF "$line" ~/.bashrc || echo "$line" >> ~/.bashrc
  done
}

# Python devenv setup

                                                                                                                                                              shiftkit/construct.sh                                                                               0000775 0001750 0001750 00000015024 15023604361 013756  0                                                                                                    ustar   nope                            nope                                                                                                                                                                                                                   #!/usr/bin/env bash
#
# ShiftKit - A modular Ubuntu system recovery and configuration tool
#

set -e

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="${SCRIPT_DIR}/config.yaml"
MODULES_DIR="${SCRIPT_DIR}/modules"
LOG_FILE="${SCRIPT_DIR}/shiftkit.log"

# ANSI color codes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Progress bar variables
PROGRESS_BAR_WIDTH=50
total_tasks=0
completed_tasks=0

# Function to display usage information
show_usage() {
    cat << EOF
Usage: $0 [options]

Options:
  --config <file>    Use a custom configuration file
  --module <module>  Run only specific module(s), comma-separated
  --list-modules     List available modules
  --help             Show this help message

Example:
  $0 --config custom_config.yaml
  $0 --module apt,software
EOF
}

# Function to log messages
log() {
    local level="$1"
    local message="$2"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    echo -e "[${timestamp}] [${level}] ${message}" >> "${LOG_FILE}"
    
    case "$level" in
        "INFO")
            echo -e "[${BLUE}INFO${NC}] $message"
            ;;
        "SUCCESS")
            echo -e "[${GREEN}SUCCESS${NC}] $message"
            ;;
        "WARNING")
            echo -e "[${YELLOW}WARNING${NC}] $message"
            ;;
        "ERROR")
            echo -e "[${RED}ERROR${NC}] $message"
            ;;
    esac
}

# Function to check for required dependencies
check_dependencies() {
    local deps=("curl" "wget" "git" "python3" "python3-pip" "python3-yaml")
    local missing=()
    
    log "INFO" "Checking for required dependencies..."
    
    for dep in "${deps[@]}"; do
        if ! command -v "$dep" &> /dev/null && ! dpkg -l | grep -q "$dep"; then
            missing+=("$dep")
        fi
    done
    
    if [ ${#missing[@]} -ne 0 ]; then
        log "WARNING" "Missing dependencies: ${missing[*]}"
        log "INFO" "Installing missing dependencies..."
        sudo apt-get update
        sudo apt-get install -y "${missing[@]}"
    fi
}

# Function to initialize progress bar
init_progress_bar() {
    # Count total tasks from all modules to be executed
    # total_tasks=$(python3 -c "import yaml; config = yaml.safe_load(open('$CONFIG_FILE')); print(sum([len(module['tasks']) for module in config['modules'] if module['enabled']]))")
    # This shit broken
    total_tasks=100
    completed_tasks=0
    
    echo ""
    echo "ShiftKit Installation Progress:"
    draw_progress_bar 0
}

# Function to update progress bar
update_progress() {
    completed_tasks=$((completed_tasks + 1))
    local percentage=$((completed_tasks * 100 / total_tasks))
    
    draw_progress_bar "$percentage"
}

# Function to draw progress bar
draw_progress_bar() {
    local percentage=$1
    local filled_length=$((percentage * PROGRESS_BAR_WIDTH / 100))
    local empty_length=$((PROGRESS_BAR_WIDTH - filled_length))
    
    # Create the progress bar
    local bar=$(printf "%${filled_length}s" | tr ' ' '#')
    local empty=$(printf "%${empty_length}s")
    
    # Print the progress bar
    printf "\r[${GREEN}${bar}${NC}${empty}] ${percentage}%% (${completed_tasks}/${total_tasks})\n"
    
    # Print newline if completed
    if [ "$percentage" -eq 100 ]; then
        echo ""
    fi
}

# Function to list available modules
list_modules() {
    log "INFO" "Available modules:"
    
    for module_dir in "${MODULES_DIR}"/*; do
        if [ -d "$module_dir" ]; then
            module_name=$(basename "$module_dir")
            module_description=$(grep -m 1 "# Description:" "${module_dir}/${module_name}.sh" | cut -d':' -f2- | sed 's/^ *//')
            echo -e "${GREEN}${module_name}${NC}: ${module_description:-No description available}"
        fi
    done
}

# Function to load and validate configuration
load_config() {
    if [ ! -f "$CONFIG_FILE" ]; then
        log "ERROR" "Configuration file not found: $CONFIG_FILE"
        exit 1
    fi
    
    # Validate YAML syntax using Python
    if ! python3 -c "import yaml; yaml.safe_load(open('$CONFIG_FILE'))"; then
        log "ERROR" "Invalid YAML syntax in configuration file"
        exit 1
    fi
    
    log "INFO" "Configuration loaded from $CONFIG_FILE"
}

# Function to execute a module
execute_module() {
    local module_name="$1"
    local module_dir="${MODULES_DIR}/${module_name}"
    local module_script="${module_dir}/${module_name}.sh"
    
    if [ ! -f "$module_script" ]; then
        log "ERROR" "Module script not found: $module_script"
        return 1
    fi
    
    log "INFO" "Executing module: $module_name"
    
    # Source the module script
    source "$module_script"
    
    # Execute the module's main function
    if declare -f "${module_name}_main" > /dev/null; then
        "${module_name}_main"
    else
        log "ERROR" "Module $module_name does not have a main function"
        return 1
    fi
    
    log "SUCCESS" "Module $module_name completed"
    return 0
}

# Parse command line arguments
CUSTOM_CONFIG=""
SPECIFIC_MODULES=""

while [[ $# -gt 0 ]]; do
    case "$1" in
        --config)
            CUSTOM_CONFIG="$2"
            shift 2
            ;;
        --module)
            SPECIFIC_MODULES="$2"
            shift 2
            ;;
        --list-modules)
            list_modules
            exit 0
            ;;
        --help)
            show_usage
            exit 0
            ;;
        *)
            log "ERROR" "Unknown option: $1"
            show_usage
            exit 1
            ;;
    esac
done

# Use custom config if provided
if [ -n "$CUSTOM_CONFIG" ]; then
    CONFIG_FILE="$CUSTOM_CONFIG"
fi

# Main execution
main() {
    log "INFO" "Starting ShiftKit..."
    
    # Check for dependencies
    check_dependencies
    
    # Create modules directory if it doesn't exist
    mkdir -p "$MODULES_DIR"
    
    # Load configuration
    load_config
    
    # Initialize progress bar
    init_progress_bar
    
    # Get modules to execute from config
    local modules_to_run=()
    
    if [ -n "$SPECIFIC_MODULES" ]; then
        # Split comma-separated modules
        IFS=',' read -ra modules_to_run <<< "$SPECIFIC_MODULES"
    else
        # Get modules from config file
        modules_to_run=($(python3 -c "
import yaml
config = yaml.safe_load(open('$CONFIG_FILE'))
modules = [m['name'] for m in config['modules'] if m['enabled']]
print(' '.join(modules))
"))
    fi
    
    # Execute each module in order
    for module in "${modules_to_run[@]}"; do
        execute_module "$module"
    done
    
    log "SUCCESS" "ShiftKit completed successfully!"
}

# Run the main function
main
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            shiftkit/custom_scripts/                                                                            0000775 0001750 0001750 00000000000 15023601727 014455  5                                                                                                    ustar   nope                            nope                                                                                                                                                                                                                   shiftkit/custom_scripts/01-setup-dev-environment.sh                                                 0000775 0001750 0001750 00000003175 15023460510 021507  0                                                                                                    ustar   nope                            nope                                                                                                                                                                                                                   #!/usr/bin/env bash
# Custom script to set up development environment

echo "Setting up development environment..."

# Create development directories
mkdir -p ~/Projects
mkdir -p ~/Workspace
mkdir -p ~/Scripts

# Install VS Code if not already installed
if ! command -v code &> /dev/null; then
    echo "Installing Visual Studio Code..."
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
    sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
    rm -f packages.microsoft.gpg
    sudo apt update
    sudo apt install -y code
fi

# Install some useful VS Code extensions
if command -v code &> /dev/null; then
    echo "Installing VS Code extensions..."
    code --install-extension ms-python.python
    code --install-extension ms-vscode.cpptools
    code --install-extension dbaeumer.vscode-eslint
    code --install-extension esbenp.prettier-vscode
    code --install-extension ms-azuretools.vscode-docker
fi

# Set up Git configuration
echo "Setting up Git configuration..."
git config --global core.editor "code --wait"
git config --global init.defaultBranch main

# Create a .gitignore_global file
cat > ~/.gitignore_global << EOF
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

git config --global core.excludesfile ~/.gitignore_global

echo "Development environment setup completed!"
exit 0
                                                                                                                                                                                                                                                                                                                                                                                                   shiftkit/modules/                                                                                   0000775 0001750 0001750 00000000000 15023460510 013035  5                                                                                                    ustar   nope                            nope                                                                                                                                                                                                                   shiftkit/modules/system/                                                                            0000775 0001750 0001750 00000000000 15023600400 014353  5                                                                                                    ustar   nope                            nope                                                                                                                                                                                                                   shiftkit/modules/system/system.sh                                                                   0000664 0001750 0001750 00000011000 15023600400 016223  0                                                                                                    ustar   nope                            nope                                                                                                                                                                                                                   #!/usr/bin/env bash
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
shiftkit/modules/custom/                                                                            0000775 0001750 0001750 00000000000 15023602266 014355  5                                                                                                    ustar   nope                            nope                                                                                                                                                                                                                   shiftkit/modules/custom/custom.sh                                                                   0000664 0001750 0001750 00000013441 15023602266 016226  0                                                                                                    ustar   nope                            nope                                                                                                                                                                                                                   #!/usr/bin/env bash
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
                                                                                                                                                                                                                               shiftkit/modules/apt/                                                                               0000775 0001750 0001750 00000000000 15023460510 013621  5                                                                                                    ustar   nope                            nope                                                                                                                                                                                                                   shiftkit/modules/apt/apt.sh                                                                         0000664 0001750 0001750 00000002613 15023460510 014743  0                                                                                                    ustar   nope                            nope                                                                                                                                                                                                                   #!/usr/bin/env bash
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
                                                                                                                     shiftkit/modules/software/                                                                          0000775 0001750 0001750 00000000000 15023575703 014702  5                                                                                                    ustar   nope                            nope                                                                                                                                                                                                                   shiftkit/modules/software/software.sh                                                               0000664 0001750 0001750 00000020333 15023575703 017071  0                                                                                                    ustar   nope                            nope                                                                                                                                                                                                                   #!/usr/bin/env bash
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
                                                                                                                                                                                                                                                                                                     shiftkit/modules/devenv/                                                                            0000775 0001750 0001750 00000000000 15023603126 014326  5                                                                                                    ustar   nope                            nope                                                                                                                                                                                                                   shiftkit/modules/devenv/devenv.sh                                                                   0000664 0001750 0001750 00000013261 15023603126 016154  0                                                                                                    ustar   nope                            nope                                                                                                                                                                                                                   #!/usr/bin/env bash
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
                                                                                                                                                                                                                                                                                                                                               shiftkit/modules/drivers/                                                                           0000775 0001750 0001750 00000000000 15023601055 014514  5                                                                                                    ustar   nope                            nope                                                                                                                                                                                                                   shiftkit/modules/drivers/drivers.sh                                                                 0000664 0001750 0001750 00000005755 15023460510 016541  0                                                                                                    ustar   nope                            nope                                                                                                                                                                                                                   #!/usr/bin/env bash
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
                   shiftkit/modules/security/                                                                          0000775 0001750 0001750 00000000000 15023460510 014704  5                                                                                                    ustar   nope                            nope                                                                                                                                                                                                                   shiftkit/modules/security/security.sh                                                               0000664 0001750 0001750 00000017674 15023460510 017126  0                                                                                                    ustar   nope                            nope                                                                                                                                                                                                                   #!/usr/bin/env bash
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
                                                                    shiftkit/modules/network/                                                                           0000775 0001750 0001750 00000000000 15023603724 014534  5                                                                                                    ustar   nope                            nope                                                                                                                                                                                                                   shiftkit/modules/network/network.sh                                                                 0000664 0001750 0001750 00000013743 15023603724 016571  0                                                                                                    ustar   nope                            nope                                                                                                                                                                                                                   #!/usr/bin/env bash
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
                             shiftkit/modules/backup/                                                                            0000775 0001750 0001750 00000000000 15023460510 014302  5                                                                                                    ustar   nope                            nope                                                                                                                                                                                                                   shiftkit/modules/backup/backup.sh                                                                   0000664 0001750 0001750 00000016143 15023460510 016110  0                                                                                                    ustar   nope                            nope                                                                                                                                                                                                                   #!/usr/bin/env bash
# Description: Backup and restore important user data

# Function to check the config to see if we should even run backup or not
backup_check_to_run() {
    if ! python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['backup']['enabled'])" | grep -q "True"; then
        log "INFO" "Skipping backup (disabled in config)"
        return 0
    fi
}

# Function to create backup directories
backup_create_dirs() {
    local backup_base_dir=$(python3 -c "import yaml, os; print(os.path.expanduser(yaml.safe_load(open('$CONFIG_FILE'))['backup']['base_dir']))")
    
    log "INFO" "Creating backup directories..."
    
    # Create main backup directory
    mkdir -p "$backup_base_dir"
    
    # Create subdirectories for different backup types
    mkdir -p "${backup_base_dir}/configs"
    mkdir -p "${backup_base_dir}/documents"
    mkdir -p "${backup_base_dir}/projects"
    mkdir -p "${backup_base_dir}/data"
    
    update_progress
}

# Function to backup user documents
backup_documents() {
    if ! python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['backup']['documents']['enabled'])" | grep -q "True"; then
        log "INFO" "Skipping documents backup (disabled in config)"
        return 0
    fi
    
    local backup_base_dir=$(python3 -c "import yaml, os; print(os.path.expanduser(yaml.safe_load(open('$CONFIG_FILE'))['backup']['base_dir']))")
    local documents_dir=$(python3 -c "import yaml, os; print(os.path.expanduser(yaml.safe_load(open('$CONFIG_FILE'))['backup']['documents']['source_dir']))")
    local timestamp=$(date +"%Y%m%d_%H%M%S")
    local backup_file="${backup_base_dir}/documents/documents_${timestamp}.tar.gz"
    
    log "INFO" "Backing up documents from $documents_dir to $backup_file"
    
    # Create tar archive of documents
    tar -czf "$backup_file" -C "$(dirname "$documents_dir")" "$(basename "$documents_dir")"
    
    update_progress
}

# Function to backup projects
backup_projects() {
    if ! python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['backup']['projects']['enabled'])" | grep -q "True"; then
        log "INFO" "Skipping projects backup (disabled in config)"
        return 0
    fi
    
    local backup_base_dir=$(python3 -c "import yaml, os; print(os.path.expanduser(yaml.safe_load(open('$CONFIG_FILE'))['backup']['base_dir']))")
    local projects_dir=$(python3 -c "import yaml, os; print(os.path.expanduser(yaml.safe_load(open('$CONFIG_FILE'))['backup']['projects']['source_dir']))")
    local timestamp=$(date +"%Y%m%d_%H%M%S")
    local backup_file="${backup_base_dir}/projects/projects_${timestamp}.tar.gz"
    
    log "INFO" "Backing up projects from $projects_dir to $backup_file"
    
    # Create tar archive of projects
    tar -czf "$backup_file" -C "$(dirname "$projects_dir")" "$(basename "$projects_dir")"
    
    update_progress
}

# Function to backup browser data
backup_browser_data() {
    if ! python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['backup']['browser_data']['enabled'])" | grep -q "True"; then
        log "INFO" "Skipping browser data backup (disabled in config)"
        return 0
    fi
    
    local backup_base_dir=$(python3 -c "import yaml, os; print(os.path.expanduser(yaml.safe_load(open('$CONFIG_FILE'))['backup']['base_dir']))")
    local browser=$(python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['backup']['browser_data']['browser'])")
    local timestamp=$(date +"%Y%m%d_%H%M%S")
    
    log "INFO" "Backing up $browser data"
    
    case "$browser" in
        "firefox")
            local firefox_dir="$HOME/.mozilla/firefox"
            local backup_file="${backup_base_dir}/data/firefox_${timestamp}.tar.gz"
            
            # Find the profile directory
            local profile_dir=$(find "$firefox_dir" -name "*.default*" -type d | head -n 1)
            
            if [ -n "$profile_dir" ]; then
                # Backup bookmarks, history, and passwords
                tar -czf "$backup_file" -C "$profile_dir" places.sqlite favicons.sqlite key4.db logins.json
                log "SUCCESS" "Firefox data backed up to $backup_file"
            else
                log "ERROR" "Firefox profile directory not found"
            fi
            ;;
            
        "chrome")
            local chrome_dir="$HOME/.config/google-chrome"
            local backup_file="${backup_base_dir}/data/chrome_${timestamp}.tar.gz"
            
            if [ -d "$chrome_dir" ]; then
                # Backup bookmarks and preferences
                tar -czf "$backup_file" -C "$chrome_dir/Default" "Bookmarks" "Preferences"
                log "SUCCESS" "Chrome data backed up to $backup_file"
            else
                log "ERROR" "Chrome data directory not found"
            fi
            ;;
            
        *)
            log "WARNING" "Unsupported browser: $browser"
            ;;
    esac
    
    update_progress
}

# Function to restore from backup
backup_restore() {
    if ! python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['backup']['restore']['enabled'])" | grep -q "True"; then
        log "INFO" "Skipping backup restoration (disabled in config)"
        return 0
    fi
    
    local backup_base_dir=$(python3 -c "import yaml, os; print(os.path.expanduser(yaml.safe_load(open('$CONFIG_FILE'))['backup']['base_dir']))")
    local restore_type=$(python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['backup']['restore']['type'])")
    local restore_file=$(python3 -c "import yaml, os; print(os.path.expanduser(yaml.safe_load(open('$CONFIG_FILE'))['backup']['restore']['file']))")
    local restore_target=$(python3 -c "import yaml, os; print(os.path.expanduser(yaml.safe_load(open('$CONFIG_FILE'))['backup']['restore']['target_dir']))")
    
    log "INFO" "Restoring $restore_type from $restore_file to $restore_target"
    
    # Create target directory if it doesn't exist
    mkdir -p "$restore_target"
    
    # Extract the backup archive
    tar -xzf "$restore_file" -C "$restore_target"
    
    update_progress
}

# Function to list available backups
backup_list() {
    local backup_base_dir=$(python3 -c "import yaml, os; print(os.path.expanduser(yaml.safe_load(open('$CONFIG_FILE'))['backup']['base_dir']))")
    
    log "INFO" "Available backups:"
    
    # List documents backups
    log "INFO" "Documents backups:"
    find "${backup_base_dir}/documents" -name "*.tar.gz" -type f | sort
    
    # List projects backups
    log "INFO" "Projects backups:"
    find "${backup_base_dir}/projects" -name "*.tar.gz" -type f | sort
    
    # List data backups
    log "INFO" "Data backups:"
    find "${backup_base_dir}/data" -name "*.tar.gz" -type f | sort
    
    update_progress
}

# Main function for this module
backup_main() {
    log "INFO" "Starting backup module..."

    backup_check_to_run
    backup_create_dirs
    backup_documents
    backup_projects
    backup_browser_data
    
    # Only run restore if specifically enabled
    if python3 -c "import yaml; print(yaml.safe_load(open('$CONFIG_FILE'))['backup']['restore']['enabled'])" | grep -q "True"; then
        backup_restore
    fi
    
    log "SUCCESS" "Backup module completed successfully"
}
                                                                                                                                                                                                                                                                                                                                                                                                                             shiftkit/modules/configs/                                                                           0000775 0001750 0001750 00000000000 15023600316 014465  5                                                                                                    ustar   nope                            nope                                                                                                                                                                                                                   shiftkit/modules/configs/configs.sh                                                                 0000664 0001750 0001750 00000016750 15023600172 016462  0                                                                                                    ustar   nope                            nope                                                                                                                                                                                                                   #!/usr/bin/env bash
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
    
    if [ -f "$SCRIPT_DIR/$source/bashrc" ]; then
        cp "$SCRIPT_DIR/$source/bashrc" "$target"
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
		"sway")
			# Install sway if not already installed
			pip3 install --user meson==0.55.3
			# Full deps
			sudo apt install -y wayland-protocols libwayland-dev libegl1-mesa-dev libgles2-mesa-dev libdrm-dev libgbm-dev libinput-dev libxkbcommon-dev \
        	    libgudev-1.0-dev libpixman-1-dev libsystemd-dev cmake libpng-dev libavutil-dev libavcodec-dev libavformat-dev ninja-build meson
			# Opt deps
			sudo apt install -y libxcb-composite0-dev libxcb-icccm4-dev libxcb-image0-dev libxcb-render0-dev libxcb-xfixes0-dev libxkbcommon-dev libxcb-xinput-dev \
        		libx11-xcb-dev

			# Clone wlroots
			temp_dir=$(mktemp -d)
			mkdir $temp_dir/sway-build
			cd $temp_dir/sway-build
			git clone https://github.com/swaywm/wlroots.git
			cd wlroots
			git checkout 0.12.0
			# Build wlroots
			meson build
			ninja -C build
			sudo ninja -C build install

			# Sway
			sudo apt install -y libjson-c-dev libpango1.0-dev libcairo2-dev libgdk-pixbuf2.0-dev scdoc
			cd $temp_dir/sway_build
			git clone https://github.com/swaywm/sway.git
			cd sway
			git checkout 1.5.1
			# Build Sway
			meson build
			ninja -C build
			sudo ninja -C build install
			
			# Environment
			echo "[Desktop Entry]
Name=Sway
Comment=An i3-compatible Wayland compositor
Exec=sway
Type=Application" > /usr/local/share/wayland-sessions/sway.desktop

			# Sway cfg
			mkdir ~/.config/sway
			cp /usr/local/etc/sway/config ~/.config/sway

			sudo apt install -y dmenu swaybg swayidle swaylock
			;;

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
                        shiftkit/modules/desktop/                                                                           0000775 0001750 0001750 00000000000 15023460510 014506  5                                                                                                    ustar   nope                            nope                                                                                                                                                                                                                   shiftkit/modules/desktop/desktop.sh                                                                 0000664 0001750 0001750 00000010165 15023460510 016516  0                                                                                                    ustar   nope                            nope                                                                                                                                                                                                                   #!/usr/bin/env bash
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
                                                                                                                                                                                                                                                                                                                                                                                                           shiftkit/shiftkit.log                                                                               0000664 0001750 0001750 00000030335 15023604374 013731  0                                                                                                    ustar   nope                            nope                                                                                                                                                                                                                   [2025-06-15 22:49:12] [INFO] Starting ShiftKit...
[2025-06-15 22:49:12] [INFO] Checking for required dependencies...
[2025-06-15 22:49:12] [INFO] Configuration loaded from /home/nope/Downloads/shiftkit/config.yaml
[2025-06-15 22:49:12] [INFO] Executing module: configs
[2025-06-15 22:49:12] [INFO] Starting configs module...
[2025-06-15 22:49:12] [INFO] Backing up existing configurations to /home/nope/.shiftkit_backups/backup_20250615_224912
[2025-06-15 22:49:12] [INFO] Restoring bashrc configuration...
[2025-06-15 22:49:12] [SUCCESS] Restored bashrc configuration
[2025-06-15 22:49:12] [INFO] Skipping tiling manager setup (disabled in config)
[2025-06-15 22:49:12] [INFO] Restoring theme, icons, and fonts...
[2025-06-15 22:49:13] [SUCCESS] Configs module completed successfully
[2025-06-15 22:49:13] [SUCCESS] Module configs completed
[2025-06-15 22:49:13] [INFO] Executing module: system
[2025-06-15 22:49:13] [INFO] Starting system module...
[2025-06-15 22:49:13] [INFO] Setting screen timeout to 300 seconds...
[2025-06-15 22:49:13] [INFO] Setting battery percentage display: True
[2025-06-15 22:49:13] [INFO] Setting hot corner action: show_applications
[2025-06-15 22:49:13] [INFO] Setting performance mode: balanced
[2025-06-15 22:49:29] [INFO] Starting ShiftKit...
[2025-06-15 22:49:29] [INFO] Checking for required dependencies...
[2025-06-15 22:49:29] [ERROR] Invalid YAML syntax in configuration file
[2025-06-15 22:51:34] [INFO] Starting ShiftKit...
[2025-06-15 22:51:34] [INFO] Checking for required dependencies...
[2025-06-15 22:51:34] [INFO] Configuration loaded from /home/nope/Downloads/shiftkit/config.yaml
[2025-06-15 22:51:34] [INFO] Executing module: system
[2025-06-15 22:51:34] [INFO] Starting system module...
[2025-06-15 22:51:34] [INFO] Setting screen timeout to 300 seconds...
[2025-06-15 22:51:35] [INFO] Setting battery percentage display: True
[2025-06-15 22:51:35] [INFO] Setting hot corner action: show_applications
[2025-06-15 22:51:35] [INFO] Setting performance mode: balanced
[2025-06-15 22:51:35] [INFO] Configuring miscellaneous system settings...
[2025-06-15 22:51:35] [SUCCESS] System module completed successfully
[2025-06-15 22:51:35] [SUCCESS] Module system completed
[2025-06-15 22:51:35] [INFO] Executing module: drivers
[2025-06-15 22:51:35] [INFO] Starting drivers module...
[2025-06-15 22:51:35] [INFO] Installing fingerprint driver for goodix on dell...
[2025-06-15 22:57:37] [INFO] Starting ShiftKit...
[2025-06-15 22:57:37] [INFO] Checking for required dependencies...
[2025-06-15 22:57:37] [INFO] Configuration loaded from /home/nope/Downloads/shiftkit/config.yaml
[2025-06-15 22:57:37] [INFO] Executing module: drivers
[2025-06-15 22:57:37] [INFO] Starting drivers module...
[2025-06-15 22:57:37] [INFO] Skipping fingerprint driver installation (disabled in config)
[2025-06-15 22:57:37] [INFO] Checking for graphics drivers...
[2025-06-15 22:57:37] [INFO] Installing additional hardware drivers...
[2025-06-15 22:57:37] [INFO] Installing recommended drivers...
[2025-06-15 22:57:53] [SUCCESS] Drivers module completed successfully
[2025-06-15 22:57:53] [SUCCESS] Module drivers completed
[2025-06-15 22:57:53] [INFO] Executing module: custom
[2025-06-15 22:58:37] [INFO] Starting ShiftKit...
[2025-06-15 22:58:37] [INFO] Checking for required dependencies...
[2025-06-15 22:58:37] [INFO] Configuration loaded from /home/nope/Downloads/shiftkit/config.yaml
[2025-06-15 22:58:37] [INFO] Executing module: drivers
[2025-06-15 22:58:37] [INFO] Starting drivers module...
[2025-06-15 22:58:38] [INFO] Skipping fingerprint driver installation (disabled in config)
[2025-06-15 22:58:38] [INFO] Checking for graphics drivers...
[2025-06-15 22:58:38] [INFO] Installing additional hardware drivers...
[2025-06-15 22:58:38] [INFO] Installing recommended drivers...
[2025-06-15 22:58:41] [SUCCESS] Drivers module completed successfully
[2025-06-15 22:58:41] [SUCCESS] Module drivers completed
[2025-06-15 22:58:41] [INFO] Executing module: custom
[2025-06-15 22:58:41] [INFO] Starting custom module...
[2025-06-15 22:58:41] [INFO] Installing custom packages...
[2025-06-15 22:58:41] [INFO] Installing custom package: ffmpeg
[2025-06-15 22:59:03] [INFO] Installing custom package: vlc
[2025-06-15 22:59:50] [INFO] Installing custom package: gimp
[2025-06-15 23:00:36] [INFO] Installing custom package: inkscape
[2025-06-15 23:01:51] [INFO] Installing custom package: audacity
[2025-06-15 23:02:18] [INFO] Cloning custom repositories...
[2025-06-15 23:02:18] [INFO] Cloning repository: https://github.com/example/dotfiles.git to /home/nope/Projects/dotfiles
[2025-06-15 23:07:12] [INFO] Starting ShiftKit...
[2025-06-15 23:07:12] [INFO] Checking for required dependencies...
[2025-06-15 23:07:12] [INFO] Configuration loaded from /home/nope/Downloads/shiftkit/config.yaml
[2025-06-15 23:07:12] [INFO] Executing module: drivers
[2025-06-15 23:07:12] [INFO] Starting drivers module...
[2025-06-15 23:07:12] [INFO] Skipping fingerprint driver installation (disabled in config)
[2025-06-15 23:07:12] [INFO] Checking for graphics drivers...
[2025-06-15 23:07:12] [INFO] Installing additional hardware drivers...
[2025-06-15 23:07:12] [INFO] Installing recommended drivers...
[2025-06-15 23:07:15] [SUCCESS] Drivers module completed successfully
[2025-06-15 23:07:15] [SUCCESS] Module drivers completed
[2025-06-15 23:07:15] [INFO] Executing module: custom
[2025-06-15 23:07:15] [INFO] Starting custom module...
[2025-06-15 23:07:15] [INFO] Installing custom packages...
[2025-06-15 23:07:15] [INFO] Installing custom package: ffmpeg
[2025-06-15 23:07:16] [INFO] Installing custom package: vlc
[2025-06-15 23:07:16] [INFO] Installing custom package: gimp
[2025-06-15 23:07:17] [INFO] Installing custom package: inkscape
[2025-06-15 23:07:17] [INFO] Installing custom package: audacity
[2025-06-15 23:07:18] [INFO] Cloning custom repositories...
[2025-06-15 23:07:18] [INFO] Running custom script: 01-setup-dev-environment.sh
[2025-06-15 23:09:10] [SUCCESS] Custom script 01-setup-dev-environment.sh completed successfully
[2025-06-15 23:09:11] [INFO] Running custom commands...
[2025-06-15 23:09:11] [INFO] Running command: Create a marker file to indicate custom commands ran
[2025-06-15 23:09:11] [INFO] Running command: Set dark mode as default
[2025-06-15 23:09:11] [SUCCESS] Custom module completed successfully
[2025-06-15 23:09:11] [SUCCESS] Module custom completed
[2025-06-15 23:09:11] [INFO] Executing module: backup
[2025-06-15 23:09:11] [INFO] Starting backup module...
[2025-06-15 23:09:11] [INFO] Skipping backup (disabled in config)
[2025-06-15 23:09:11] [INFO] Creating backup directories...
[2025-06-15 23:09:11] [INFO] Backing up documents from /home/nope/Documents to /home/nope/.shiftkit_backups/documents/documents_20250615_230911.tar.gz
[2025-06-15 23:09:11] [INFO] Backing up projects from /home/nope/Projects to /home/nope/.shiftkit_backups/projects/projects_20250615_230911.tar.gz
[2025-06-15 23:09:11] [INFO] Backing up firefox data
[2025-06-15 23:09:11] [ERROR] Firefox profile directory not found
[2025-06-15 23:09:11] [SUCCESS] Backup module completed successfully
[2025-06-15 23:09:11] [SUCCESS] Module backup completed
[2025-06-15 23:09:11] [INFO] Executing module: devenv
[2025-06-15 23:09:11] [INFO] Starting development environment module...
[2025-06-15 23:09:11] [INFO] Installing common development tools...
[2025-06-15 23:09:38] [INFO] Setting up Python development environment...
[2025-06-15 23:11:08] [INFO] Setting up Node.js development environment...
[2025-06-15 23:11:15] [INFO] Setting up Go development environment...
[2025-06-15 23:14:12] [INFO] Starting ShiftKit...
[2025-06-15 23:14:12] [INFO] Checking for required dependencies...
[2025-06-15 23:14:12] [INFO] Configuration loaded from /home/nope/Downloads/shiftkit/config.yaml
[2025-06-15 23:14:12] [INFO] Executing module: devenv
[2025-06-15 23:14:12] [INFO] Starting development environment module...
[2025-06-15 23:14:12] [INFO] Installing common development tools...
[2025-06-15 23:14:16] [INFO] Setting up Python development environment...
[2025-06-15 23:14:18] [INFO] Setting up Docker...
[2025-06-15 23:15:08] [INFO] Setting up Visual Studio Code...
[2025-06-15 23:15:08] [INFO] Installing VS Code extensions...
[2025-06-15 23:15:23] [INFO] Setting up Git configuration...
[2025-06-15 23:15:24] [SUCCESS] Development environment module completed successfully
[2025-06-15 23:15:24] [SUCCESS] Module devenv completed
[2025-06-15 23:15:24] [INFO] Executing module: desktop
[2025-06-15 23:15:24] [INFO] Starting desktop customization module...
[2025-06-15 23:15:24] [INFO] Setting GNOME theme to Adwaita-dark
[2025-06-15 23:15:24] [INFO] Setting icon theme to Papirus-Dark
[2025-06-15 23:15:24] [INFO] Setting cursor theme to Adwaita (size: 24)
[2025-06-15 23:15:24] [INFO] Configuring dock settings
[2025-06-15 23:15:25] [INFO] Setting desktop background to /home/nope/Pictures/Wallpapers/default.jpg
[2025-06-15 23:15:25] [SUCCESS] Desktop customization module completed successfully
[2025-06-15 23:15:25] [SUCCESS] Module desktop completed
[2025-06-15 23:15:25] [INFO] Executing module: network
[2025-06-15 23:15:25] [INFO] Starting network configuration module...
[2025-06-15 23:15:25] [INFO] Installing network tools...
[2025-06-15 23:15:41] [INFO] Configuring VPN connections...
[2025-06-15 23:16:58] [INFO] Configuring firewall...
[2025-06-15 23:16:58] [INFO] Allowing port: 22
[2025-06-15 23:16:58] [INFO] Allowing port: 80
[2025-06-15 23:16:58] [INFO] Allowing port: 443
[2025-06-15 23:16:59] [INFO] Configuring DNS settings...
[2025-06-15 23:20:32] [INFO] Starting ShiftKit...
[2025-06-15 23:20:32] [INFO] Checking for required dependencies...
[2025-06-15 23:20:32] [INFO] Configuration loaded from /home/nope/Downloads/shiftkit/config.yaml
[2025-06-15 23:20:32] [INFO] Executing module: network
[2025-06-15 23:20:32] [INFO] Starting network configuration module...
[2025-06-15 23:20:32] [INFO] Installing network tools...
[2025-06-15 23:20:33] [INFO] Configuring VPN connections...
[2025-06-15 23:20:39] [INFO] Configuring firewall...
[2025-06-15 23:20:40] [INFO] Allowing port: 22
[2025-06-15 23:20:40] [INFO] Allowing port: 80
[2025-06-15 23:20:40] [INFO] Allowing port: 443
[2025-06-15 23:20:41] [INFO] Configuring DNS settings...
[2025-06-15 23:20:41] [SUCCESS] Network configuration module completed successfully
[2025-06-15 23:20:41] [SUCCESS] Module network completed
[2025-06-15 23:20:41] [SUCCESS] ShiftKit completed successfully!
[2025-06-15 23:20:50] [INFO] Available modules:
[2025-06-15 23:21:38] [INFO] Starting ShiftKit...
[2025-06-15 23:21:38] [INFO] Checking for required dependencies...
[2025-06-15 23:21:39] [INFO] Configuration loaded from /home/nope/Downloads/shiftkit/config.yaml
[2025-06-15 23:21:39] [INFO] Executing module: security
[2025-06-15 23:21:39] [INFO] Starting security module...
[2025-06-15 23:21:39] [INFO] Installing security tools...
[2025-06-15 23:23:22] [INFO] Configuring automatic security updates...
[2025-06-15 23:23:29] [INFO] Configuring fail2ban...
[2025-06-15 23:23:31] [INFO] Configuring SSH security settings...
[2025-06-15 23:23:31] [INFO] Configuring firewall (UFW)...
[2025-06-15 23:23:32] [INFO] Allowing port: 80
[2025-06-15 23:23:32] [INFO] Allowing port: 443
[2025-06-15 23:23:33] [INFO] Configuring system auditing...
[2025-06-15 23:23:34] [SUCCESS] Security module completed successfully
[2025-06-15 23:23:34] [SUCCESS] Module security completed
[2025-06-15 23:23:34] [SUCCESS] ShiftKit completed successfully!
[2025-06-15 23:25:01] [INFO] Starting ShiftKit...
[2025-06-15 23:25:01] [INFO] Checking for required dependencies...
[2025-06-15 23:25:01] [INFO] Configuration loaded from /home/nope/Downloads/shiftkit/config.yaml
[2025-06-15 23:25:01] [INFO] Executing module: security
[2025-06-15 23:25:01] [INFO] Starting security module...
[2025-06-15 23:25:01] [INFO] Installing security tools...
[2025-06-15 23:25:01] [INFO] Configuring automatic security updates...
[2025-06-15 23:25:03] [INFO] Configuring fail2ban...
[2025-06-15 23:25:05] [INFO] Configuring SSH security settings...
[2025-06-15 23:25:05] [INFO] Configuring firewall (UFW)...
[2025-06-15 23:25:06] [INFO] Allowing port: 80
[2025-06-15 23:25:06] [INFO] Allowing port: 443
[2025-06-15 23:25:07] [INFO] Configuring system auditing...
[2025-06-15 23:25:08] [SUCCESS] Security module completed successfully
[2025-06-15 23:25:08] [SUCCESS] Module security completed
[2025-06-15 23:25:08] [SUCCESS] ShiftKit completed successfully!
                                                                                                                                                                                                                                                                                                   shiftkit/utils.sh                                                                                   0000775 0001750 0001750 00000013653 15023460510 013074  0                                                                                                    ustar   nope                            nope                                                                                                                                                                                                                   #!/usr/bin/env bash
#
# ShiftKit - Utility functions
#

# Function to create a new module
create_module() {
    local module_name="$1"
    
    if [ -z "$module_name" ]; then
        echo "Error: Module name is required"
        echo "Usage: $0 create_module <module_name>"
        return 1
    fi
    
    local module_dir="modules/$module_name"
    local module_script="$module_dir/$module_name.sh"
    
    # Check if module already exists
    if [ -d "$module_dir" ]; then
        echo "Error: Module '$module_name' already exists"
        return 1
    fi
    
    # Create module directory
    mkdir -p "$module_dir"
    
    # Create module script
    cat > "$module_script" << EOF
#!/usr/bin/env bash
# Description: ${module_name^} module for ShiftKit

# Main function for this module
${module_name}_main() {
    log "INFO" "Starting ${module_name} module..."
    
    # Add your module functionality here
    
    log "SUCCESS" "${module_name^} module completed successfully"
}
EOF
    
    # Make script executable
    chmod +x "$module_script"
    
    echo "Module '$module_name' created successfully"
    echo "Edit $module_script to add your module functionality"
    
    # Update config.yaml to include the new module
    python3 -c "
import yaml
with open('config.yaml', 'r') as f:
    config = yaml.safe_load(f)

# Add the new module to the modules list
new_module = {
    'name': '$module_name',
    'enabled': False,
    'description': '${module_name^} module'
}

# Check if module already exists in config
if not any(m['name'] == '$module_name' for m in config['modules']):
    config['modules'].append(new_module)
    
    # Add empty section for module-specific config
    if '$module_name' not in config:
        config['$module_name'] = {}

    with open('config.yaml', 'w') as f:
        yaml.dump(config, f, default_flow_style=False)
    print('Config updated with new module')
else:
    print('Module already exists in config')
"
}

# Function to backup current configuration
backup_config() {
    local backup_dir="$HOME/.shiftkit_backups"
    local timestamp=$(date +"%Y%m%d_%H%M%S")
    local backup_path="${backup_dir}/backup_${timestamp}"
    
    # Create backup directory
    mkdir -p "$backup_path"
    
    echo "Backing up configurations to $backup_path"
    
    # Backup .bashrc
    if [ -f "$HOME/.bashrc" ]; then
        cp "$HOME/.bashrc" "$backup_path/"
        echo "Backed up .bashrc"
    fi
    
    # Backup other config files
    if [ -d "$HOME/.config" ]; then
        mkdir -p "$backup_path/.config"
        
        # Backup specific config directories
        for dir in "nvim" "i3" "pop-shell" "gtk-3.0" "gtk-4.0"; do
            if [ -d "$HOME/.config/$dir" ]; then
                cp -r "$HOME/.config/$dir" "$backup_path/.config/"
                echo "Backed up $dir configuration"
            fi
        done
    fi
    
    echo "Backup completed successfully"
}

# Function to import configuration from backup
import_config() {
    local backup_dir="$1"
    
    if [ -z "$backup_dir" ]; then
        echo "Error: Backup directory is required"
        echo "Usage: $0 import_config <backup_directory>"
        return 1
    fi
    
    if [ ! -d "$backup_dir" ]; then
        echo "Error: Backup directory does not exist: $backup_dir"
        return 1
    fi
    
    echo "Importing configurations from $backup_dir"
    
    # Create configs directory structure
    mkdir -p "configs/bashrc"
    mkdir -p "configs/pop-shell"
    mkdir -p "configs/theme"
    mkdir -p "configs/icons"
    mkdir -p "configs/fonts"
    
    # Import .bashrc if it exists
    if [ -f "$backup_dir/.bashrc" ]; then
        cp "$backup_dir/.bashrc" "configs/bashrc/bashrc"
        echo "Imported .bashrc"
    fi
    
    # Import other config files
    if [ -d "$backup_dir/.config" ]; then
        # Import specific config directories
        if [ -d "$backup_dir/.config/pop-shell" ]; then
            cp -r "$backup_dir/.config/pop-shell/"* "configs/pop-shell/"
            echo "Imported pop-shell configuration"
        fi
        
        if [ -d "$backup_dir/.config/gtk-3.0" ]; then
            mkdir -p "configs/theme/gtk-3.0"
            cp -r "$backup_dir/.config/gtk-3.0/"* "configs/theme/gtk-3.0/"
            echo "Imported GTK3 theme configuration"
        fi
    fi
    
    echo "Import completed successfully"
}

# Function to list available backups
list_backups() {
    local backup_dir="$HOME/.shiftkit_backups"
    
    if [ ! -d "$backup_dir" ]; then
        echo "No backups found"
        return 0
    fi
    
    echo "Available backups:"
    
    for backup in "$backup_dir"/backup_*; do
        if [ -d "$backup" ]; then
            local backup_name=$(basename "$backup")
            local backup_date=${backup_name#backup_}
            
            # Format date for display
            local formatted_date=$(date -d "${backup_date:0:8} ${backup_date:9:2}:${backup_date:11:2}:${backup_date:13:2}" "+%Y-%m-%d %H:%M:%S" 2>/dev/null)
            
            if [ -z "$formatted_date" ]; then
                echo "- $backup_name"
            else
                echo "- $backup_name ($formatted_date)"
            fi
        fi
    done
}

# Main function to handle utility commands
main() {
    local command="$1"
    shift
    
    case "$command" in
        create_module)
            create_module "$@"
            ;;
        backup)
            backup_config
            ;;
        import)
            import_config "$@"
            ;;
        list_backups)
            list_backups
            ;;
        *)
            echo "Usage: $0 <command> [options]"
            echo ""
            echo "Commands:"
            echo "  create_module <module_name>  Create a new module"
            echo "  backup                       Backup current configuration"
            echo "  import <backup_directory>    Import configuration from backup"
            echo "  list_backups                 List available backups"
            ;;
    esac
}

# Run main function with all arguments
main "$@"
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     