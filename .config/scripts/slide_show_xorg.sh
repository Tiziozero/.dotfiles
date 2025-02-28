#!/bin/bash

# Directory containing wallpapers
WALLPAPER_DIR="/home/kleidi/.config/several/shika"
# Time in seconds between wallpaper changes
INTERVAL=60

while true; do
    for WALLPAPER in $(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" -o -iname "*.gif" \)); do
        echo "$WALLPAPER"
        pkill swaybg  # Kill existing swaybg process
        feh --bg-max "$WALLPAPER" --image-bg '#ffffff'
        sleep "$INTERVAL"
    done
done
