#!/bin/bash

# CachyOS Essential Tools Installation
# This script installs core development tools from official repositories

set -e  # Exit on any error

echo "=========================================="
echo "Installing Essential Development Tools"
echo "=========================================="

echo "Installing essential development tools..."

if ! command -v paru &> /dev/null; then
    echo "Error: paru not found. Please install paru first."
    exit 1
fi

# Update system first
paru -Syu --noconfirm

# Install all essential packages
paru -S --needed --noconfirm \
    nushell \
    fish \
    starship \
    ghostty \
    btop \
    git \
    neovim \
    go \
    rustup \
    uv \
    coreutils \
    ripgrep \
    jq \
    bat \
    eza \
    zoxide \
    direnv \
    xh \
    fzf \
    dust \
    duf \
    procs \
    fd \
    podman \
    tailscale \
    gitui

# Initialize rustup for current user
rustup default stable

 
