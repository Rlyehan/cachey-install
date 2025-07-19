#!/bin/bash

# CachyOS Flatpak Applications Installation
# This script installs applications via Flatpak for better sandboxing

set -e  # Exit on any error



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

echo "Installing Flatpak applications..."

# Install Flatpak if not already installed
if ! command -v flatpak &> /dev/null; then
    if ! command -v paru &> /dev/null; then
        echo "Error: paru not found. Please install paru first."
        exit 1
    fi
    echo "Installing Flatpak..."
    paru -S --needed --noconfirm flatpak
fi

# Add Flathub repository
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo ""

# Install applications

if ask_confirmation "Install Tidal Player?"; then
    echo "Installing Tidal Player..."
    flatpak install -y flathub com.mastermindzh.tidal-hifi
else
    echo "Skipping Tidal Player."
fi



