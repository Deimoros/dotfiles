#!/usr/bin/env bash
PROFILE="$1"

if [ -z "$PROFILE" ]; then
  echo "Usage: use-profile <name>"
  exit 1
fi

BASE="$HOME/dotfiles/$PROFILE"

#ln -sfn "$BASE/.config/sway"    "$HOME/.config/sway"
#ln -sfn "$BASE/.config/waybar"  "$HOME/.config/waybar"
#ln -sfn "$BASE/.local/bin"      "$HOME/.local/bin"

echo "Activated profile: $PROFILE"
