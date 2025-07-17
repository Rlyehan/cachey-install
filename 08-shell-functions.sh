#!/bin/bash

# CachyOS Shell Functions Setup Script
# This script installs useful shell functions and aliases inspired by Omarchy

set -e  # Exit on any error

echo "============================================="
echo "CachyOS Shell Functions & Aliases Setup"
echo "============================================="
echo ""
echo "Installing useful shell functions and aliases for:"
echo "- File compression/decompression"
echo "- System management shortcuts"
echo "- Development workflow helpers"
echo "- Git workflow improvements"
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

# Create shell functions directory
SHELL_FUNCTIONS_DIR="$HOME/.config/shell-functions"
mkdir -p "$SHELL_FUNCTIONS_DIR"

echo "Creating shell functions..."

# Create main shell functions file
cat > "$SHELL_FUNCTIONS_DIR/functions.sh" << 'EOF'
#!/bin/bash

# CachyOS Shell Functions - Inspired by Omarchy but tailored for our needs

# File compression and decompression
compress() {
    if [ $# -eq 0 ]; then
        echo "Usage: compress <file.tar.gz> [files...]"
        return 1
    fi
    
    local archive="$1"
    shift
    
    if [ $# -eq 0 ]; then
        echo "Error: No files to compress"
        return 1
    fi
    
    echo "Compressing files to $archive..."
    tar -czf "$archive" "$@"
    echo "✓ Compression complete"
}

decompress() {
    if [ $# -eq 0 ]; then
        echo "Usage: decompress <archive>"
        return 1
    fi
    
    local archive="$1"
    
    if [ ! -f "$archive" ]; then
        echo "Error: Archive $archive not found"
        return 1
    fi
    
    echo "Decompressing $archive..."
    case "$archive" in
        *.tar.gz|*.tgz)
            tar -xzf "$archive" ;;
        *.tar.bz2|*.tbz2)
            tar -xjf "$archive" ;;
        *.tar.xz|*.txz)
            tar -xJf "$archive" ;;
        *.zip)
            unzip "$archive" ;;
        *.7z)
            7z x "$archive" ;;
        *)
            echo "Error: Unsupported archive format"
            return 1
            ;;
    esac
    echo "✓ Decompression complete"
}

# System management shortcuts
update-system() {
    echo "Updating system packages..."
    sudo pacman -Syu --noconfirm
    echo "✓ System updated"
}

update-aur() {
    echo "Updating AUR packages..."
    if command -v paru &> /dev/null; then
        paru -Sua --noconfirm
    elif command -v yay &> /dev/null; then
        yay -Sua --noconfirm
    else
        echo "Error: No AUR helper found"
        return 1
    fi
    echo "✓ AUR packages updated"
}

update-all() {
    echo "Updating all packages..."
    update-system
    update-aur
    echo "✓ All packages updated"
}

# Development workflow helpers
dev-server() {
    local port=${1:-3000}
    echo "Starting development server on port $port..."
    
    if [ -f "package.json" ]; then
        npm run dev
    elif [ -f "Cargo.toml" ]; then
        cargo run
    elif [ -f "go.mod" ]; then
        go run .
    elif [ -f "main.py" ]; then
        python main.py
    else
        echo "No recognized project files found"
        return 1
    fi
}

# Git workflow improvements
git-sync() {
    echo "Syncing with remote repository..."
    git fetch origin
    git pull origin "$(git branch --show-current)"
    echo "✓ Repository synced"
}

git-cleanup() {
    echo "Cleaning up git repository..."
    git prune
    git gc
    echo "✓ Git repository cleaned"
}

# Docker helpers
docker-cleanup() {
    echo "Cleaning up Docker..."
    docker system prune -f
    echo "✓ Docker cleaned up"
}

# Directory navigation helpers
up() {
    local levels=${1:-1}
    local path=""
    for ((i=1; i<=levels; i++)); do
        path="../$path"
    done
    cd "$path"
}

# File finding helpers
ff() {
    if command -v fzf &> /dev/null; then
        find . -type f | fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'
    else
        echo "fzf not found. Install with: sudo pacman -S fzf"
        return 1
    fi
}

# System information
sysinfo() {
    echo "System Information:"
    echo "=================="
    echo "OS: $(uname -o)"
    echo "Kernel: $(uname -r)"
    echo "Uptime: $(uptime -p)"
    echo "Memory: $(free -h | grep '^Mem:' | awk '{print $3 "/" $2}')"
    echo "Disk Usage: $(df -h / | tail -1 | awk '{print $3 "/" $2 " (" $5 ")"}')"
    echo "CPU: $(lscpu | grep 'Model name:' | cut -d':' -f2 | xargs)"
}

# Network helpers
ports() {
    echo "Active network connections:"
    ss -tuln
}

# Process helpers
psg() {
    if [ $# -eq 0 ]; then
        echo "Usage: psg <process_name>"
        return 1
    fi
    ps aux | grep -v grep | grep "$1"
}

# Theme reload for terminal applications
reload-theme() {
    echo "Reloading terminal theme..."
    # Reload starship if it's running
    if command -v starship &> /dev/null; then
        export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
    fi
    
    # Reload shell
    if [ -n "$BASH_VERSION" ]; then
        source ~/.bashrc
    elif [ -n "$ZSH_VERSION" ]; then
        source ~/.zshrc
    fi
    
    echo "✓ Theme reloaded"
}

EOF

# Create aliases file
cat > "$SHELL_FUNCTIONS_DIR/aliases.sh" << 'EOF'
#!/bin/bash

# CachyOS Aliases - Modern CLI tools and shortcuts

# Modern CLI tool aliases
alias ll='eza -la --icons --git'
alias lt='eza --tree --icons'
alias la='eza -a --icons'
alias ls='eza --icons'
alias cat='bat --paging=never'
alias grep='rg'
alias find='fd'
alias du='dust'
alias df='duf'
alias ps='procs'
alias top='btop'
alias htop='btop'

# Git aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline'
alias gd='git diff'
alias gb='git branch'
alias gco='git checkout'
alias gm='git merge'
alias gf='git fetch'
alias gg='gitui'

# System aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias home='cd ~'
alias root='cd /'

# Package management
alias install='sudo pacman -S'
alias remove='sudo pacman -R'
alias search='pacman -Ss'
alias update='sudo pacman -Syu'
alias aur-install='paru -S'
alias aur-search='paru -Ss'

# Network
alias ping='ping -c 5'
alias myip='curl -s ifconfig.me && echo'
alias localip='ip route get 1.1.1.1 | grep -oP "src \K\S+"'

# File operations
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias mkdir='mkdir -pv'

# Docker shortcuts
alias d='docker'
alias dc='docker-compose'
alias dps='docker ps'
alias dimg='docker images'

# Development
alias serve='python -m http.server'
alias py='python'
alias pip='python -m pip'
alias venv='python -m venv'

# Editor shortcuts
alias v='nvim'
alias vim='nvim'
alias nano='nvim'
alias code='cursor'

# System monitoring
alias meminfo='free -m -l -t'
alias cpuinfo='lscpu'
alias diskinfo='df -h'

EOF

# Add shell integration
echo "Setting up shell integration..."

# Add to bashrc if it exists
if [ -f "$HOME/.bashrc" ]; then
    if ! grep -q "shell-functions" "$HOME/.bashrc"; then
        echo "" >> "$HOME/.bashrc"
        echo "# CachyOS Shell Functions" >> "$HOME/.bashrc"
        echo "source \"$SHELL_FUNCTIONS_DIR/functions.sh\"" >> "$HOME/.bashrc"
        echo "source \"$SHELL_FUNCTIONS_DIR/aliases.sh\"" >> "$HOME/.bashrc"
        echo "✓ Added to ~/.bashrc"
    fi
fi

# Add to zshrc if it exists
if [ -f "$HOME/.zshrc" ]; then
    if ! grep -q "shell-functions" "$HOME/.zshrc"; then
        echo "" >> "$HOME/.zshrc"
        echo "# CachyOS Shell Functions" >> "$HOME/.zshrc"
        echo "source \"$SHELL_FUNCTIONS_DIR/functions.sh\"" >> "$HOME/.zshrc"
        echo "source \"$SHELL_FUNCTIONS_DIR/aliases.sh\"" >> "$HOME/.zshrc"
        echo "✓ Added to ~/.zshrc"
    fi
fi

# Add to fish config if it exists
if [ -d "$HOME/.config/fish" ]; then
    mkdir -p "$HOME/.config/fish/functions"
    
    # Create fish-compatible functions
    cat > "$HOME/.config/fish/functions/compress.fish" << 'EOF'
function compress
    if test (count $argv) -eq 0
        echo "Usage: compress <file.tar.gz> [files...]"
        return 1
    end
    
    set archive $argv[1]
    set files $argv[2..-1]
    
    echo "Compressing files to $archive..."
    tar -czf $archive $files
    echo "✓ Compression complete"
end
EOF

    cat > "$HOME/.config/fish/functions/decompress.fish" << 'EOF'
function decompress
    if test (count $argv) -eq 0
        echo "Usage: decompress <archive>"
        return 1
    end
    
    set archive $argv[1]
    
    if not test -f $archive
        echo "Error: Archive $archive not found"
        return 1
    end
    
    echo "Decompressing $archive..."
    switch $archive
        case "*.tar.gz" "*.tgz"
            tar -xzf $archive
        case "*.tar.bz2" "*.tbz2"
            tar -xjf $archive
        case "*.tar.xz" "*.txz"
            tar -xJf $archive
        case "*.zip"
            unzip $archive
        case "*.7z"
            7z x $archive
        case "*"
            echo "Error: Unsupported archive format"
            return 1
    end
    echo "✓ Decompression complete"
end
EOF

    echo "✓ Added Fish functions"
fi

# Add to nushell config if it exists
if [ -d "$HOME/.config/nushell" ]; then
    if [ -f "$HOME/.config/nushell/config.nu" ]; then
        if ! grep -q "CachyOS Shell Functions" "$HOME/.config/nushell/config.nu"; then
            echo "" >> "$HOME/.config/nushell/config.nu"
            echo "# CachyOS Shell Functions" >> "$HOME/.config/nushell/config.nu"
            echo "alias ll = eza -la --icons --git" >> "$HOME/.config/nushell/config.nu"
            echo "alias lt = eza --tree --icons" >> "$HOME/.config/nushell/config.nu"
            echo "alias la = eza -a --icons" >> "$HOME/.config/nushell/config.nu"
            echo "alias ls = eza --icons" >> "$HOME/.config/nushell/config.nu"
            echo "alias cat = bat --paging=never" >> "$HOME/.config/nushell/config.nu"
            echo "alias grep = rg" >> "$HOME/.config/nushell/config.nu"
            echo "alias find = fd" >> "$HOME/.config/nushell/config.nu"
            echo "alias v = nvim" >> "$HOME/.config/nushell/config.nu"
            echo "alias code = cursor" >> "$HOME/.config/nushell/config.nu"
            echo "✓ Added to Nushell config"
        fi
    fi
fi

echo ""
echo "============================================="
echo "Shell Functions & Aliases Setup Complete!"
echo "============================================="
echo ""
echo "Available functions:"
echo "- compress/decompress: Archive management"
echo "- update-system/update-aur/update-all: System updates"
echo "- dev-server: Start development servers"
echo "- git-sync/git-cleanup: Git workflow helpers"
echo "- docker-cleanup: Docker maintenance"
echo "- up [levels]: Navigate directories"
echo "- ff: Fuzzy file finding"
echo "- sysinfo: System information"
echo "- ports: Active network connections"
echo "- psg <name>: Process search"
echo "- reload-theme: Reload terminal theme"
echo ""
echo "Modern CLI aliases:"
echo "- ll, lt, la, ls (eza with icons)"
echo "- cat (bat with syntax highlighting)"
echo "- grep (ripgrep), find (fd)"
echo "- top (btop), v (nvim), code (cursor)"
echo ""
echo "Restart your shell or run 'source ~/.bashrc' to activate!"
EOF 