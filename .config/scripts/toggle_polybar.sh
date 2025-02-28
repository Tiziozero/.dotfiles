#!/bin/bash

# Check if Polybar is running
if pgrep -x "polybar" > /dev/null
then
    # If it's running, kill it
    pkill polybar
else
    # If it's not running, start it
    polybar &
fi
