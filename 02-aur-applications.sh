#!/bin/bash

# CachyOS AUR Applications Installation (Source Compilation)
# This script installs applications from AUR that need to be compiled

set -e  # Exit on any error

echo "Installing AUR applications (compilation)..."

if ! command -v paru &> /dev/null; then
    echo "Error: paru not found. Please install paru first."
    exit 1
fi

# Install AUR packages that require compilation
paru -S --needed --noconfirm \
    steam

echo "AUR applications (compilation) completed!"

 