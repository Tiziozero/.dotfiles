#!/bin/bash

# Check if the waybar is running
if pgrep -x "waybar" > /dev/null
then
    # echo "running. killing waybar..." >> ~/swaybarRun
    # If it's running, kill it
    pkill waybar
else
    # If it's not running, start it
    # echo "not running. starting waybar..." >> ~/swaybarRun
    waybar &
fi
# echo "Done" >> ~/swaybarRun
