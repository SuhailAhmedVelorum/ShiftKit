#!/usr/bin/env bash
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
