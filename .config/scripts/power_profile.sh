#!/bin/bash

# Get the current profile
CURRENT_PROFILE=$(powerprofilesctl get)

# Toggle profiles
if [ "$CURRENT_PROFILE" = "performance" ]; then
    NEW_PROFILE="balanced"
elif [ "$CURRENT_PROFILE" = "balanced" ]; then
    NEW_PROFILE="power-saver"
else
    NEW_PROFILE="performance"
fi

# Set the new profile
powerprofilesctl set "$NEW_PROFILE"

# Send a notification
notify-send "Power Profile Changed: $NEW_PROFILE" "New Profile: $NEW_PROFILE"
