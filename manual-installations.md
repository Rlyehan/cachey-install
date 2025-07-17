# Manual Installation Instructions

The following applications require manual installation or special handling that can't be automated via package managers.

## Cursor Code Editor

**Status**: Not available in official repos or AUR  
**Installation Method**: Manual download and setup

### Option 1: AppImage (Recommended)
1. Download the AppImage from [Cursor website](https://cursor.sh/)
2. Make it executable: `chmod +x cursor-*.AppImage`
3. Move to applications directory: `sudo mv cursor-*.AppImage /opt/cursor`
4. Create desktop entry manually or use the built-in installer

### Option 2: Manual Installation
1. Download the Linux package from [Cursor website](https://cursor.sh/)
2. Extract and follow the installation instructions
3. May require manual creation of desktop entries

**Note**: Cursor is based on VS Code but with AI features. Consider if VS Code + extensions might work for your needs.

---

## Steam (Alternative Installation)

**Status**: Available in official repos  
**Already handled**: In script `02-aur-applications.sh`

Steam is included in the AUR applications script, but you can also install it via:
- Official repos: `sudo pacman -S steam`
- Flatpak: `flatpak install flathub com.valvesoftware.Steam`

---

## Applications with Multiple Installation Options

### Tidal Player
- **Script option**: Flatpak (in `05-flatpak-apps.sh`)
- **Alternative**: Web app or browser-based usage
- **AUR option**: May have AUR packages but Flatpak is recommended

### Obsidian
- **Script option**: AUR (`03-binary-applications.sh`) or Flatpak (`05-flatpak-apps.sh`)
- **Alternative**: Direct download from [Obsidian website](https://obsidian.md/)

### Brave Browser
- **Script option**: AUR (`03-binary-applications.sh`) or Flatpak (`05-flatpak-apps.sh`)
- **Alternative**: Direct download from [Brave website](https://brave.com/)

---

## CachyOS Specific Tools

### GUI Package Managers
CachyOS comes with several package management tools:

1. **Octopi** - Pre-installed GUI package manager
   - Access: Look for "Octopi" in your applications menu
   - Features: Manages pacman and AUR packages
   - Enable AUR: Click the alien icon next to the search bar

2. **CachyOS Package Installer** - Built-in package installer
   - Access: CachyOS Hello → Apps/Tweaks → Install Apps
   - Features: Simplified package installation interface

3. **CachyOS Hello** - Welcome application
   - Access: Should auto-start or find in applications menu
   - Features: System management, package installation, tweaks

### System Update Recommendations
Instead of just `pacman -Syu`, consider:
- `paru` for system + AUR updates
- Use CachyOS Hello for system maintenance tasks
- Check the CachyOS forum for update-related issues

---

## Post-Installation Configuration

### Shell Setup
After installing shells like `fish` or `nushell`:
1. Set as default: `chsh -s /usr/bin/fish` (or `/usr/bin/nu` for nushell)
2. Configure starship prompt in your shell's config file
3. Set up shell-specific configurations

### Development Environment
1. Configure Git: `git config --global user.name "Your Name"`
2. Set up SSH keys for GitHub/GitLab
3. Configure your preferred shell and editor

### Container Setup
For Podman:
1. Enable rootless containers: `systemctl --user enable podman.socket`
2. Configure container registries if needed
3. Consider installing `podman-compose` for Docker Compose compatibility

---

## Troubleshooting

### AUR Package Issues
- Clear cache: `paru -Scc`
- Rebuild keyring: Use CachyOS Hello → Apps/Tweaks → Refresh Keyrings
- Check CachyOS forum for package-specific issues

### Flatpak Issues
- Update runtime: `flatpak update`
- Reset permissions: Use Flatseal (available as Flatpak)
- Check Flathub for application-specific issues

### System Issues
- Use CachyOS Hello for system maintenance
- Check the CachyOS wiki for troubleshooting guides
- Visit CachyOS Discord/Forum for community support 