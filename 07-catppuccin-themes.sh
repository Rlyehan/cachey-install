#!/bin/bash

set -e  

echo "Installing Catppuccin Mocha themes..."

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

# Install Catppuccin GTK theme
if ! command -v paru &> /dev/null; then
    echo "Error: paru not found. Please install paru first."
    exit 1
fi

paru -S --needed --noconfirm catppuccin-gtk-theme-mocha

# Configure Ghostty
mkdir -p ~/.config/ghostty
cat > ~/.config/ghostty/config << 'EOF'
# Catppuccin Mocha theme for Ghostty
theme = catppuccin-mocha

# Font configuration  
font-family = "GeistMono Nerd Font"
font-size = 12

# Window settings
window-padding-x = 10
window-padding-y = 10

# Other settings
cursor-style = block
shell-integration = fish
EOF

# Configure Alacritty
mkdir -p ~/.config/alacritty
cat > ~/.config/alacritty/alacritty.toml << 'EOF'
# Catppuccin Mocha theme for Alacritty
import = [
    "~/.config/alacritty/catppuccin-mocha.toml"
]

[font]
normal.family = "GeistMono Nerd Font"
normal.style = "Regular"
bold.family = "GeistMono Nerd Font"
bold.style = "Bold"
italic.family = "GeistMono Nerd Font"
italic.style = "Italic"
size = 12

[window]
padding.x = 10
padding.y = 10
opacity = 0.95

[shell]
program = "/usr/bin/fish"
EOF

# Download Catppuccin Alacritty theme
wget -O ~/.config/alacritty/catppuccin-mocha.toml https://github.com/catppuccin/alacritty/raw/main/catppuccin-mocha.toml

# Configure kitty
mkdir -p ~/.config/kitty
cat > ~/.config/kitty/kitty.conf << 'EOF'
# Catppuccin Mocha theme for kitty
include ~/.config/kitty/catppuccin-mocha.conf

# Font configuration
font_family      GeistMono Nerd Font
bold_font        auto
italic_font      auto
bold_italic_font auto
font_size        12.0

# Window settings
background_opacity 0.95
window_padding_width 10

# Tab bar
tab_bar_style powerline
tab_powerline_style slanted

# Shell
shell fish
EOF

# Download Catppuccin kitty theme
wget -O ~/.config/kitty/catppuccin-mocha.conf https://github.com/catppuccin/kitty/raw/main/themes/mocha.conf

# Configure Starship prompt
mkdir -p ~/.config
cat > ~/.config/starship.toml << 'EOF'
# Catppuccin Mocha theme for Starship
palette = "catppuccin_mocha"

[palettes.catppuccin_mocha]
rosewater = "#f5e0dc"
flamingo = "#f2cdcd"
pink = "#f5c2e7"
mauve = "#cba6f7"
red = "#f38ba8"
maroon = "#eba0ac"
peach = "#fab387"
yellow = "#f9e2af"
green = "#a6e3a1"
teal = "#94e2d5"
sky = "#89dceb"
sapphire = "#74c7ec"
blue = "#89b4fa"
lavender = "#b4befe"
text = "#cdd6f4"
subtext1 = "#bac2de"
subtext0 = "#a6adc8"
overlay2 = "#9399b2"
overlay1 = "#7f849c"
overlay0 = "#6c7086"
surface2 = "#585b70"
surface1 = "#45475a"
surface0 = "#313244"
base = "#1e1e2e"
mantle = "#181825"
crust = "#11111b"

format = """
[](#crust)\
$os\
$username\
[](bg:mantle fg:crust)\
$directory\
[](fg:mantle bg:surface0)\
$git_branch\
$git_status\
[](fg:surface0 bg:surface1)\
$nodejs\
$rust\
$golang\
$python\
[](fg:surface1 bg:surface2)\
$docker_context\
[](fg:surface2)\
$line_break$character"""

[os]
disabled = false
style = "bg:crust fg:text"

[username]
show_always = true
style_user = "bg:crust fg:text"
style_root = "bg:crust fg:red"
format = '[$user ]($style)'

[directory]
style = "fg:text bg:mantle"
format = "[ $path ]($style)"
truncation_length = 3

[git_branch]
symbol = ""
style = "bg:surface0 fg:text"
format = '[[ $symbol $branch ](fg:text bg:surface0)]($style)'

[git_status]
style = "bg:surface0 fg:text"
format = '[[($all_status$ahead_behind )](fg:text bg:surface0)]($style)'

[nodejs]
symbol = ""
style = "bg:surface1 fg:text"
format = '[[ $symbol ($version) ](fg:text bg:surface1)]($style)'

[rust]
symbol = ""
style = "bg:surface1 fg:text"
format = '[[ $symbol ($version) ](fg:text bg:surface1)]($style)'

[golang]
symbol = ""
style = "bg:surface1 fg:text"
format = '[[ $symbol ($version) ](fg:text bg:surface1)]($style)'

[python]
symbol = ""
style = "bg:surface1 fg:text"
format = '[[ $symbol ($version) ](fg:text bg:surface1)]($style)'

[docker_context]
symbol = ""
style = "bg:surface2 fg:text"
format = '[[ $symbol $context ](fg:text bg:surface2)]($style)'

[line_break]
disabled = false

[character]
disabled = false
success_symbol = '[](bold fg:green)'
error_symbol = '[](bold fg:red)'
vimcmd_symbol = '[](bold fg:green)'
vimcmd_replace_one_symbol = '[](bold fg:purple)'
vimcmd_replace_symbol = '[](bold fg:purple)'
vimcmd_visual_symbol = '[](bold fg:yellow)'
EOF

# Configure btop
mkdir -p ~/.config/btop/themes
wget -O ~/.config/btop/themes/catppuccin_mocha.theme https://github.com/catppuccin/btop/raw/main/themes/catppuccin_mocha.theme

mkdir -p ~/.config/btop
cat > ~/.config/btop/btop.conf << 'EOF'
# Catppuccin Mocha theme for btop
color_theme = "catppuccin_mocha"
theme_background = True
truecolor = True
force_tty = False
presets = "cpu:1:default,mem:1:default,net:1:default,proc:1:default"
vim_keys = True
rounded_corners = True
EOF

# Configure Fish shell
mkdir -p ~/.config/fish
cat > ~/.config/fish/config.fish << 'EOF'
# Catppuccin Mocha theme for Fish shell
if status is-interactive
    # Set Catppuccin Mocha colors
    set -g fish_color_normal cdd6f4
    set -g fish_color_command 89b4fa
    set -g fish_color_quote a6e3a1
    set -g fish_color_redirection f5c2e7
    set -g fish_color_end fab387
    set -g fish_color_error f38ba8
    set -g fish_color_param f2cdcd
    set -g fish_color_comment 6c7086
    set -g fish_color_match --background=313244
    set -g fish_color_selection --background=313244
    set -g fish_color_search_match --background=313244
    set -g fish_color_history_current --bold
    set -g fish_color_operator f5c2e7
    set -g fish_color_escape eba0ac
    set -g fish_color_cwd f9e2af
    set -g fish_color_cwd_root f38ba8
    set -g fish_color_valid_path --underline
    set -g fish_color_autosuggestion 6c7086
    set -g fish_color_user a6e3a1
    set -g fish_color_host 89b4fa
    set -g fish_color_cancel -r
    set -g fish_pager_color_completion cdd6f4
    set -g fish_pager_color_description 6c7086
    set -g fish_pager_color_prefix white --bold --underline
    set -g fish_pager_color_progress brwhite --background=cyan
    set -g fish_pager_color_selected_background --background=313244
    
    # Initialize Starship prompt
    starship init fish | source
end
EOF

# Configure Neovim
mkdir -p ~/.config/nvim
cat > ~/.config/nvim/init.lua << 'EOF'
-- Catppuccin Mocha theme for Neovim
vim.cmd.colorscheme "catppuccin-mocha"

-- Basic Neovim settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.termguicolors = true

-- Install catppuccin if not present
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use { "catppuccin/nvim", as = "catppuccin" }
  
  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- Configure Catppuccin
require("catppuccin").setup({
    flavour = "mocha",
    transparent_background = true,
})
EOF

# Configure GitUI
mkdir -p ~/.config/gitui
cat > ~/.config/gitui/theme.ron << 'EOF'
// Catppuccin Mocha theme for GitUI
(
    selected_tab: Some(Rgb(203, 166, 247)),
    command_fg: Some(Rgb(205, 214, 244)),
    selection_bg: Some(Rgb(69, 71, 90)),
    selection_fg: Some(Rgb(205, 214, 244)),
    cmdbar_bg: Some(Rgb(30, 30, 46)),
    cmdbar_extra_lines_bg: Some(Rgb(30, 30, 46)),
    disabled_fg: Some(Rgb(108, 112, 134)),
    diff_line_add: Some(Rgb(166, 227, 161)),
    diff_line_delete: Some(Rgb(243, 139, 168)),
    diff_file_added: Some(Rgb(166, 227, 161)),
    diff_file_removed: Some(Rgb(243, 139, 168)),
    diff_file_moved: Some(Rgb(203, 166, 247)),
    diff_file_modified: Some(Rgb(250, 179, 135)),
    commit_hash: Some(Rgb(116, 199, 236)),
    commit_time: Some(Rgb(186, 194, 222)),
    commit_author: Some(Rgb(116, 199, 236)),
    danger_fg: Some(Rgb(243, 139, 168)),
    push_gauge_bg: Some(Rgb(137, 180, 250)),
    push_gauge_fg: Some(Rgb(30, 30, 46)),
    tag_fg: Some(Rgb(250, 179, 135)),
    branch_fg: Some(Rgb(166, 227, 161)),
)
EOF

# Configure bat
mkdir -p ~/.config/bat
cat > ~/.config/bat/config << 'EOF'
# Catppuccin Mocha theme for bat
--theme="Catppuccin Mocha"
--style="numbers,changes,header"
--paging=always
EOF

# Download Catppuccin bat theme
mkdir -p "$(bat --config-dir)/themes"
wget -O "$(bat --config-dir)/themes/Catppuccin Mocha.tmTheme" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme
bat cache --build > /dev/null 2>&1

# Configure delta (git diff)
cat >> ~/.gitconfig << 'EOF'

[core]
    pager = delta

[interactive]
    diffFilter = delta --color-only

[delta]
    navigate = true
    light = false
    syntax-theme = "Catppuccin Mocha"
    line-numbers = true
    
[merge]
    conflictstyle = diff3

[diff]
    colorMoved = default
EOF
echo "Catppuccin themes installation completed!" 