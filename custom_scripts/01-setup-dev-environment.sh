#!/usr/bin/env bash
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
