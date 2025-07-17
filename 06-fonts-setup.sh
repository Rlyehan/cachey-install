#!/bin/bash

# CachyOS Font Setup Script
# This script installs Nerd Fonts and configures GeistMono as default monospace font

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

if ! command -v paru &> /dev/null; then
    echo "Error: paru not found. Please install paru first."
    exit 1
fi

# Install Nerd Fonts
paru -S --needed --noconfirm \
    nerd-fonts \
    otf-geist-mono-nerd \
    ttf-font-nerd

# Font configuration

# Create fontconfig directory if it doesn't exist
mkdir -p ~/.config/fontconfig

# Create font configuration
cat > ~/.config/fontconfig/fonts.conf << 'EOF'
<?xml version='1.0'?>
<!DOCTYPE fontconfig SYSTEM 'fonts.dtd'>
<fontconfig>
    <!-- Set GeistMono as default monospace font -->
    <alias>
        <family>monospace</family>
        <prefer>
            <family>GeistMono Nerd Font</family>
            <family>GeistMono Nerd Font Mono</family>
            <family>Noto Sans Mono</family>
            <family>Source Code Pro</family>
        </prefer>
    </alias>
    
    <!-- Optional: Set good defaults for other font families -->
    <alias>
        <family>sans-serif</family>
        <prefer>
            <family>Noto Sans</family>
            <family>DejaVu Sans</family>
        </prefer>
    </alias>
    
    <alias>
        <family>serif</family>
        <prefer>
            <family>Noto Serif</family>
            <family>DejaVu Serif</family>
        </prefer>
    </alias>
    
    <!-- Font rendering settings -->
    <match target="font">
        <edit name="antialias" mode="assign">
            <bool>true</bool>
        </edit>
    </match>
    
    <match target="font">
        <edit name="hinting" mode="assign">
            <bool>true</bool>
        </edit>
    </match>
    
    <match target="font">
        <edit name="hintstyle" mode="assign">
            <const>hintslight</const>
        </edit>
    </match>
    
    <match target="font">
        <edit name="rgba" mode="assign">
            <const>rgb</const>
        </edit>
    </match>
</fontconfig>
EOF

# Rebuild font cache
fc-cache -rv > /dev/null 2>&1

if ask_confirmation "Copy font config system-wide?"; then
    sudo cp ~/.config/fontconfig/fonts.conf /etc/fonts/local.conf
fi

echo "Font setup completed!" 