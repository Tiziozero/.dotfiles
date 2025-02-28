#!/bin/bash

# Get the volume level and mute status
VOLUME=$(amixer get Master | grep -o '[0-9]*%' | head -n 1 | tr -d '%')
MUTED=$(amixer get Master | grep -o '\[off\]' | head -n 1)

# Check if muted
if [[ -n "$MUTED" ]]; then
    echo "🔇 Muted"
else
    echo "$VOLUME%"
fi

