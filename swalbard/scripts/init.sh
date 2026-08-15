#!/usr/bin/env bash

set -euo pipefail

# ============================================================
# swalbard installer
# CachyOS / Arch Linux
# ============================================================

REPO_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
SWALBARD="$REPO_ROOT/swalbard"
CONFIG="$HOME/.config"
LOCAL_BIN="$HOME/.local/bin"
WALLPAPER_DIR="$HOME/Pictures/swaywallpapers"

# ------------------------------------------------------------
# Helpers
# ------------------------------------------------------------

info() {
    printf '\n\033[1;34m[INFO]\033[0m %s\n' "$1"
}

success() {
    printf '\033[1;32m[ OK ]\033[0m %s\n' "$1"
}

error() {
    printf '\033[1;31m[ERROR]\033[0m %s\n' "$1" >&2
}

require_command() {
    command -v "$1" >/dev/null 2>&1 || {
        error "Required command '$1' was not found."
        exit 1
    }
}

# ------------------------------------------------------------
# Basic checks
# ------------------------------------------------------------

info "Checking system..."

if [[ ! -f /etc/arch-release ]]; then
    error "This installer currently supports Arch Linux / CachyOS only."
    exit 1
fi

require_command sudo
require_command pacman

if [[ ! -d "$SWALBARD" ]]; then
    error "Could not find $SWALBARD"
    exit 1
fi

success "Arch-based system detected."

# ------------------------------------------------------------
# Packages
# ------------------------------------------------------------

info "Installing required packages..."

PACKAGES=(
    # Window manager / desktop
    sway
    waybar
    wofi
    kitty

    # Wallpaper / theming
    swaybg
    python-pywal

    # Bluetooth
    bluez
    bluez-utils
    blueman

    # Audio
    pipewire
    pipewire-pulse
    wireplumber
    pavucontrol

    # Hardware controls
    brightnessctl

    # Screenshots
    grim
    slurp

    # Power
    power-profiles-daemon

    # Launcher / scripts
    rofi

    # Fonts / icons
    ttf-jetbrains-mono-nerd

    # Basic utilities
    git
    curl
)

sudo pacman -Syu --needed "${PACKAGES[@]}"

success "Packages installed."

# ------------------------------------------------------------
# Services
# ------------------------------------------------------------

info "Enabling system services..."

sudo systemctl enable --now bluetooth.service
sudo systemctl enable --now power-profiles-daemon.service

success "Bluetooth and power-profiles-daemon enabled."

# ------------------------------------------------------------
# Directories
# ------------------------------------------------------------

info "Creating directories..."

mkdir -p \
    "$CONFIG/sway" \
    "$CONFIG/waybar" \
    "$LOCAL_BIN" \
    "$WALLPAPER_DIR"

success "Directories created."

# ------------------------------------------------------------
# Backup existing configs
# ------------------------------------------------------------

backup_file() {
    local file="$1"

    if [[ -e "$file" && ! -L "$file" ]]; then
        local backup="${file}.backup.$(date +%Y%m%d-%H%M%S)"
        mv "$file" "$backup"
        info "Backed up $file -> $backup"
    fi
}

backup_file "$CONFIG/sway/config"
backup_file "$CONFIG/waybar/config"
backup_file "$CONFIG/waybar/style.css"

# ------------------------------------------------------------
# Install Sway
# ------------------------------------------------------------

info "Installing Sway configuration..."

cp "$SWALBARD/sway/config" "$CONFIG/sway/config"

# Replace old hard-coded username/path
sed -i \
    "s#/home/olle#${HOME}#g" \
    "$CONFIG/sway/config"

success "Sway configuration installed."

# ------------------------------------------------------------
# Install Waybar
# ------------------------------------------------------------

info "Installing Waybar configuration..."

cp "$SWALBARD/waybar/config" "$CONFIG/waybar/config"
cp "$SWALBARD/waybar/style.css" "$CONFIG/waybar/style.css"

success "Waybar configuration installed."

# ------------------------------------------------------------
# Install wallpapers
# ------------------------------------------------------------

info "Installing wallpapers..."

cp -r "$SWALBARD/wallpapers/." "$WALLPAPER_DIR/"

success "Wallpapers installed."

# ------------------------------------------------------------
# Install helper scripts
# ------------------------------------------------------------

info "Installing helper scripts..."

for script in \
    wallpaper-chooser.sh \
    wallpaper-chooser-icons.sh \
    wallpaper-chooser2.sh
do
    if [[ -f "$SWALBARD/$script" ]]; then
        cp "$SWALBARD/$script" "$LOCAL_BIN/$script"
        chmod +x "$LOCAL_BIN/$script"
    fi
done

success "Helper scripts installed."

# ------------------------------------------------------------
# Pywal
# ------------------------------------------------------------

info "Generating initial Pywal theme..."

PLACEHOLDER="$WALLPAPER_DIR/placeholder.png"

if [[ -f "$PLACEHOLDER" ]]; then
    wal -i "$PLACEHOLDER" -n
    success "Pywal theme generated."
else
    error "Placeholder wallpaper not found."
fi

# ------------------------------------------------------------
# Sway validation
# ------------------------------------------------------------

info "Validating Sway configuration..."

if sway -C -c "$CONFIG/sway/config"; then
    success "Sway configuration is valid."
else
    error "Sway configuration validation failed."
    exit 1
fi

# ------------------------------------------------------------
# Final
# ------------------------------------------------------------

printf '\n'
printf '\033[1;32m========================================\033[0m\n'
printf '\033[1;32m        Swalbard installation done       \033[0m\n'
printf '\033[1;32m========================================\033[0m\n'
printf '\n'

echo "Installed:"
echo "  - Sway"
echo "  - Waybar"
echo "  - Kitty"
echo "  - Wofi"
echo "  - Rofi"
echo "  - Pywal"
echo "  - Blueman / Bluetooth"
echo "  - PipeWire / PulseAudio"
echo "  - Screenshots"
echo "  - Brightness controls"
echo "  - Power profiles"
echo "  - Wallpapers"
echo
echo "Next step:"
echo "  Log out and select Sway as your Wayland session."
echo
