#!/bin/bash

SOURCE="$HOME/Pictures/swaywallpapers/*"
DEST="$HOME/dotfiles/swalbard/wallpapers/"

echo "Fetching wallpapers from: $SOURCE to $DEST"

cp -rf $SOURCE $DEST

