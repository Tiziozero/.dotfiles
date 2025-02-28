#!/bin/bash

# Directory containing wallpapers
WALLPAPER_DIR="/home/kleidi/.config/several/shika"
# Time in seconds between wallpaper changes
INTERVAL=3

PREV_PID=0

while true; do
    for WALLPAPER in $(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" -o -iname "*.gif" \)); do
        echo "Setting wallpaper: $WALLPAPER"

        # Start swaybg and get its PID
        swaybg -i "$WALLPAPER" -m fit -c "#ffffff" &
        NEW_PID=$!

        sleep 1  # Wait for swaybg to start

        # Kill previous swaybg instance (if it exists)
        if [[ $PREV_PID -ne 0 ]] && kill -0 "$PREV_PID" 2>/dev/null; then
            kill "$PREV_PID"
        fi

        # Update PID
        PREV_PID=$NEW_PID

        sleep "$INTERVAL"
    done
done
