#!/bin/bash

# CachyOS Complete Installation Script
# This script runs all installation scripts in the correct order

set -e  # Exit on any error

echo "=========================================="
echo "CachyOS Complete Installation Script"
echo "=========================================="
echo ""
echo "This script will install all your preferred tools and applications."
echo "You can run individual scripts later if you prefer to install selectively."
echo ""

# Function to ask user confirmation
ask_confirmation() {
    local prompt="$1"
    while true; do
        read -p "$prompt (y/n): " yn
        case $yn in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

# Function to run script if it exists and user confirms
run_script() {
    local script="$1"
    local description="$2"
    
    if [ -f "$script" ]; then
        echo ""
        echo "=========================================="
        echo "$description"
        echo "=========================================="
        
        if ask_confirmation "Do you want to run $script?"; then
            echo "Running $script..."
            chmod +x "$script"
            "./$script"
            echo "$script completed!"
        else
            echo "Skipping $script"
        fi
    else
        echo "Warning: $script not found, skipping..."
    fi
}

# Make all scripts executable
echo "Making scripts executable..."
chmod +x *.sh 2>/dev/null || true

echo ""
echo "Installation will proceed in the following order:"
echo "1. Essential tools (from official repos)"
echo "3. Binary applications (pre-compiled AUR packages)"
echo "4. Special installations (Nix, Devbox, etc.)"
echo "5. Flatpak applications (sandboxed apps)"
echo "6. Font setup (Nerd Fonts + GeistMono configuration)"
echo "7. Catppuccin Mocha theme configuration"
echo "8. Shell functions & aliases (modern CLI shortcuts)"
echo ""
echo "You can skip any category you don't want."
echo ""

if ask_confirmation "Do you want to proceed with the installation?"; then
    echo "Starting installation process..."
    
    # Run each script in order
    run_script "01-essential-tools.sh" "Installing Essential Development Tools"
    run_script "03-binary-applications.sh" "Installing Binary Applications"
    run_script "04-special-installations.sh" "Running Special Installations"
    run_script "05-flatpak-apps.sh" "Installing Flatpak Applications"
    run_script "06-fonts-setup.sh" "Setting up Nerd Fonts and GeistMono"
    run_script "07-catppuccin-themes.sh" "Configuring Catppuccin Mocha Theme"
    run_script "08-shell-functions.sh" "Installing Shell Functions & Aliases"
    
    echo ""
    echo "=========================================="
    echo "Installation Process Complete!"
    echo "=========================================="
    echo ""
    echo "Summary of what was installed:"
    echo "✓ Essential development tools (if selected)"
    echo "✓ AUR applications (if selected)"
    echo "✓ Binary applications (if selected)"
    echo "✓ Special tools like Nix/Devbox (if selected)"
    echo "✓ Flatpak applications (if selected)"
    echo "✓ Nerd Fonts and GeistMono configuration (if selected)"
    echo "✓ Catppuccin Mocha theme across applications (if selected)"
    echo "✓ Shell functions & aliases for modern CLI experience (if selected)"
    echo ""
    echo "Next steps:"
    echo "1. Check manual-installations.md for remaining applications"
    echo "2. Configure your development environment"
    echo "3. Set up your preferred shell (fish/nushell)"
    echo "4. Configure Git and SSH keys"
    echo ""
    echo "Tools for managing your system:"
    echo "- Octopi: GUI package manager (enable AUR with alien icon)"
    echo "- CachyOS Hello: System management and package installation"
    echo "- paru: Command-line AUR helper"
    echo ""
    echo "Enjoy your CachyOS setup! 🚀"
    
else
    echo "Installation cancelled. You can run individual scripts later:"
    echo ""
    echo "Available scripts:"
    ls -1 *.sh | grep -E '^[0-9]' | while read script; do
        echo "  ./$script"
    done
    echo ""
    echo "For manual installations, check: manual-installations.md"
fi 
