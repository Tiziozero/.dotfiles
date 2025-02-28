#!/bin/bash

# Directory containing the wallpapers
wallpaper_dir="/media/kleidi/4B1D-CAC4/home/.config/several/d"

# Select a random image from the directory
image=$(find "$wallpaper_dir" -type f \( -name "*.jpg" -o -name "*.png" \) | shuf -n 1)

# Set the wallpaper
feh --bg-max "$image"
