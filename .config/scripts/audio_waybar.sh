#!/bin/bash
output=$(pactl get-default-sink)
description=$(pactl list short sinks | grep "$output" | awk '{print $2}')
echo '{"text": "'"$description"'", "tooltip": "'"$output"'"}'
