# Move to ~/.local/bin/
# Make executable chmod +x ~/.local/bin/wallpaper-chooser.sh

# Or just add it to sway config:
# bindsym $mod+w exec ~/.local/bin/wallpaper-chooser.sh

echo "$HOME/Pictures/swaywallpapers"

WALLPAPER_DIR="$HOME/Pictures/swaywallpapers"
TARGET="$HOME/Pictures/swaywallpapers/placeholder.png"

choice=$(ls "$WALLPAPER_DIR" | wofi --dmenu --prompt "Wallpaper")

cp "$WALLPAPER_DIR/$choice" "$TARGET"

[ -z "$choice" ] && exit 0

pkill swaybg
swaybg -i "$TARGET" -m fill &
wal -i "$WALLPAPER_DIR/$choice" -n -e


kitty @ set-colors --all ~/.cache/wal/colors-kitty.conf
