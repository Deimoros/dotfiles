#!/usr/bin/env bash
# Copy to .local/bin

WALLPAPER_DIR="$HOME/Pictures/swaywallpapers"
TARGET="$HOME/Pictures/swaywallpapers/placeholder.png"

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

BG=$(sed -n '1p' ~/.cache/wal/colors)
FG=$(sed -n '8p' ~/.cache/wal/colors)
SEL=$(sed -n '2p' ~/.cache/wal/colors)

choice=$(printf "%b" "$menu" | rofi -dmenu -show-icons \
-theme ~/.cache/wal/colors-rofi-light.rasi \
-theme-str "
listview {columns: 5; lines: 3; spacing: 12px;}
element {orientation: vertical;}
element-icon {size: 220px;}
element-text {horizontal-align: 0.5;}
#element-selected { background-color: $SEL; text-color: $FG;}
#window {background-color: ${BG}cc; border:0;}
" \
-p "Wallpaper")


#choice=$(printf "%b" "$menu" | rofi -dmenu -show-icons \
#-theme ~/.cache/wal/colors-rofi-light.rasi \
#-theme-str "
#listview {columns: 5; lines: 3; spacing: 12px;}
#element {orientation: vertical;}
#element-icon {size: 220px;}
#element-text {horizontal-align: 0.5;}
#element selected { background-color: $SEL;text-color: $FG; }
#window {background-color: ${BG};border: 2px solid $SEL;}
#" \
#-p "Wallpaper")


#BG=$(sed -n '1p' ~/.cache/wal/colors | tr -d '\r\n[:space:]')
#SEL=$(sed -n '2p' ~/.cache/wal/colors | tr -d '\r\n[:space:]')
#FG=$(sed -n '8p' ~/.cache/wal/colors | tr -d '\r\n[:space:]')

#choice=$(printf "%b" "$menu" | rofi -dmenu -show-icons \
#-theme ~/.cache/wal/colors-rofi-light.rasi \
#-theme-str "$(cat <<EOF
#listview { columns: 5; lines: 3; spacing: 12px; }
#element { orientation: vertical; }
#element-icon { size: 220px; }
#element-text { horizontal-align: 0.5; }
#element selected { background-color: ${SEL}; text-color: ${FG}; }
#window { background-color: ${BG}; border: 2px solid ${SEL}; }
#EOF
#)" \
#-p "Wallpaper")



#choice=$(printf "%b" "$menu" | rofi -dmenu -show-icons \
#-theme-str "
#listview { columns: 5; lines: 3; spacing: 12px; }
#element { orientation: vertical; padding: 6px; background-color: transparent; }
#element-icon { size: 220px; }
#element-text { horizontal-align: 0.5; }
#element selected { background-color: $SEL; text-color: $FG; }
#window { background-color: $BG; border: 2px solid $SEL; }
#" \
#-p "Wallpaper")


#choice=$(printf "%b" "$menu" | rofi -dmenu -show-icons \
#-theme ~/.config/rofi/wallpaper-picker.rasi \
#-p "Wallpaper")

#choice=$(printf "%b" "$menu" | rofi -dmenu -show-icons \
#-theme ~/.cache/wal/colors-rofi-light.rasi \
#-p "Wallpaper")



[ -z "$choice" ] && exit 0

selected="$WALLPAPER_DIR/$choice"

cp "$WALLPAPER_DIR/$choice" "$TARGET"


pkill swaybg
swaybg -i "$selected" -m fill &

wal -i "$selected" -n -e

#kitty @ set-colors --all ~/.cache/wal/colors-kitty.conf
kitty @ --to unix:@kitty set-colors --all ~/.cache/wal/colors-kitty.conf

pkill waybar
waybar &

swaymsg reload
