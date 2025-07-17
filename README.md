# CachyOS Installation Scripts

This repository contains organized installation scripts for setting up a CachyOS system with your preferred tools and applications.

## Scripts Overview

### Core System Setup
- `01-essential-tools.sh` - Core development tools from official repos
- `02-aur-applications.sh` - Applications from AUR that need compilation
- `03-binary-applications.sh` - Pre-compiled applications from AUR (-bin packages)
- `04-special-installations.sh` - Tools requiring special installation methods

### Optional Installations
- `05-flatpak-apps.sh` - Sandboxed applications via Flatpak

### Theming and Fonts
- `06-fonts-setup.sh` - Install Nerd Fonts and configure GeistMono as default
- `07-catppuccin-themes.sh` - Configure Catppuccin Mocha theme across applications
- `08-shell-functions.sh` - Install shell functions & aliases for modern CLI experience

### Manual Installation List
- `manual-installations.md` - Applications requiring manual setup or GUI installers

## Usage

1. Make scripts executable: `chmod +x *.sh`
2. Run scripts in order: `./01-essential-tools.sh`
3. Check manual installations list for remaining items

## Notes

- Scripts use `paru` (pre-installed AUR helper on CachyOS)
- Some applications have multiple installation options - scripts use the recommended method
- Nix is installed separately as it's best not managed through pacman
- Some applications work better as Flatpaks for security/sandboxing

## CachyOS Specific Features

- **Optimized repositories**: Many AUR packages are pre-compiled in CachyOS repos
- **paru**: AUR helper pre-installed
- **Octopi**: GUI package manager available
- **CachyOS Package Installer**: GUI for basic package management 