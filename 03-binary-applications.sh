#!/bin/bash

# CachyOS Binary Applications Installation
# This script installs pre-compiled applications from AUR (-bin packages)

set -e  # Exit on any error

echo "Installing binary applications from AUR..."

if ! command -v paru &> /dev/null; then
    echo "Error: paru not found. Please install paru first."
    exit 1
fi

# Install pre-compiled binary packages
paru -S --needed --noconfirm \
    zen-browser-bin \
    brave-bin \
    obsidian

 