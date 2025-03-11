#!/usr/bin/env bash
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
