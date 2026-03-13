#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Pictures/swaywallpapers"

menu=""

for img in "$WALLPAPER_DIR"/*; do
[ -f "$img" ] || continue
name=$(basename "$img")
menu+="$name\0icon\x1f$img\n"
done

#choice=$(printf "%b" "$menu" | rofi -dmenu -show-icons -p "Wallpaper")
#choice=$(printf "%b" "$menu" | rofi -dmenu -show-icons \
#-theme-str 'listview {columns: 4; lines: 3;} element-icon {size: 160px;}' \
#-p "Wallpaper")

choice=$(printf "%b" "$menu" | rofi -dmenu -show-icons \
-theme-str '
listview {columns: 5; lines: 3; spacing: 12px;}
element {orientation: vertical;}
element-icon {size: 220px;}
element-text {horizontal-align: 0.5;}
' \
-p "Wallpaper")


[ -z "$choice" ] && exit 0

selected="$WALLPAPER_DIR/$choice"

pkill swaybg
swaybg -i "$selected" -m fill &

wal -i "$selected" -n -e

kitty @ set-colors --all ~/.cache/wal/colors-kitty.conf
 
