Swal - Sway + Pywal


1a. Copy /etc/sway/config to ~/.config/sway/config for Sway's standard configuration
1b. Copy pre-sharpened Sway config to ~/.config/sway/config

2. pip install pywal and add it to sway config

exec ~/.local/bin/wal -i ~/Pictures/aurora.png -n

3. Make terminal (ex: kitty) include color palette generated bu pywal

nano ~/.config/kitty/kitty.conf 
include ~/.cache/wal/colors-kitty.conf
