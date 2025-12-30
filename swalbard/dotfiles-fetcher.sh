#!/bin/bash

# Paths
CONFIG_DIR="$HOME/.config"
DOTFILES_DIR="$HOME/dotfiles/swalbard"


# Sway
cp "$CONFIG_DIR/sway/config" "$DOTFILES_DIR/sway/config"

# Waybar
cp "$CONFIG_DIR/waybar/config" "$DOTFILES_DIR/waybar/config"
cp "$CONFIG_DIR/waybar/style.css" "$DOTFILES_DIR/waybar/style.css"


echo "Sway and Waybar configs from $CONFIG_DIR to $DOTFILES_DIR synced successfully."

