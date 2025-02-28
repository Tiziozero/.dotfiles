#!/bin/bash
# echo "$(date): Script executed with args: $@" >> ~/setbrightness.log


# File to store current brightness level
BRIGHTNESS_FILE="$HOME/.current_brightness"

# Display output (replace with your actual output name if different)
DISPLAY_OUTPUT="eDP-1"

# Default brightness if the file doesn't exist
DEFAULT_BRIGHTNESS=1.0

# Ensure brightness file exists
if [ ! -f "$BRIGHTNESS_FILE" ]; then
    echo "$DEFAULT_BRIGHTNESS" > "$BRIGHTNESS_FILE"
fi

# Read current brightness
CURRENT_BRIGHTNESS=$(cat "$BRIGHTNESS_FILE")

# Check if argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <+0.05|-0.05>"
    exit 1
fi

# Calculate new brightness
NEW_BRIGHTNESS=$(echo "$CURRENT_BRIGHTNESS $1" | bc)

# Ensure brightness stays within bounds (0.1 to 1.0)
if (( $(echo "$NEW_BRIGHTNESS < 0.1" | bc -l) )); then
    NEW_BRIGHTNESS=0.1
elif (( $(echo "$NEW_BRIGHTNESS > 1.0" | bc -l) )); then
    NEW_BRIGHTNESS=1.0
fi

# Apply the new brightness using xrandr
xrandr --output "$DISPLAY_OUTPUT" --brightness "$NEW_BRIGHTNESS"


# Save the new brightness to the file
echo "$NEW_BRIGHTNESS" > "$BRIGHTNESS_FILE"

# Confirm the brightness change
echo "Brightness adjusted to $NEW_BRIGHTNESS"

if (( $(echo "$NEW_BRIGHTNESS <= 1.0" | bc -l) )); then
    notify-send "$NEW_BRIGHTNESS" "Brightness adjusted to $NEW_BRIGHTNESS"
else
    notify-send "1.0" "Brightness adjusted to 1.0"
fi

