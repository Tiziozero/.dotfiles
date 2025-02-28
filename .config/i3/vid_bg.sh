#!/bin/bash

# USE "$VID_PATH"!!!
VID_PATH=$HOME/.config/i3/sus/01_1.mp4
xwinwrap -b -fs -sp -fs -nf -ov -- mpv -wid WID --loop --no-audio "$VID_PATH"

