#!/bin/bash

# CachyOS Special Installations
# This script handles tools that require non-standard installation methods

set -e  # Exit on any error

echo "Installing special tools..."

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

# Nix Package Manager Installation
if ask_confirmation "Install Nix package manager?"; then
    echo "Installing Nix..."
    curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
    echo "Nix installed!"
fi

# Devbox (requires Nix)
if command -v nix &> /dev/null; then
    if ask_confirmation "Install Devbox?"; then
        echo "Installing Devbox..."
        curl -fsSL https://get.jetpack.io/devbox | bash
        echo "Devbox installed!"
    fi
else
    echo "Nix not found. Skipping Devbox."
fi

# Enable Tailscale service
if ask_confirmation "Enable Tailscale service?"; then
    echo "Enabling Tailscale..."
    sudo systemctl enable tailscaled
    sudo systemctl start tailscaled
    echo "Tailscale enabled! Run 'sudo tailscale up' to connect."
fi

echo "Special installations completed!" 