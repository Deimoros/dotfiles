#!/bin/bash

# Paths
CONFIG_DIR="$HOME/.config"
DOTFILES_DIR="$HOME/dotfiles/swalbard"




# Sway
cp "$DOTFILES_DIR/sway/config" "$CONFIG_DIR/sway/config"

# Waybar
cp "$DOTFILES_DIR/waybar/config" "$CONFIG_DIR/waybar/config" 
cp "$DOTFILES_DIR/waybar/style.css" "$CONFIG_DIR/waybar/style.css" 


echo "Sway and Waybar configs from $DOTFILES_DIR to $CONFIG_DIR applied successfully."
