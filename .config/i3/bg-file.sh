#!/usr/bin/bash
path=$"$HOME/.config/several/sus/.resources"
# echo "Enter link/path"
# read file
#


if [ -z "$1" ]; then
    echo "Error: missing link!"
    exit 1  # Exit script with an error code (optional)
fi

img="$1"

if [ -z "$2" ]; then
    convert $path/$img -resize x1080 -gravity center -background black -extent 1920x1080 $path/result.png # >/dev/null 2>&1
    echo "$?"
    if [ $? -ne 0 ]; then
      echo "failed to create bg image."
      exit 1
    fi
else
    if [[ "$2" == "r" ]]; then
        convert $path/$img -resize x1080 -gravity east -background black -extent 1920x1080 $path/result.png #  >/dev/null 2>&1
        echo "$?"
        if [ $? -ne 0 ]; then
          echo "failed to create bg image."
          exit 1
        fi
    else if [[ "$2" == "l" ]]; then
        convert $path/$img -resize x1080 -gravity west -background black -extent 1920x1080 $path/result.png >/dev/null 2>&1
        echo "$?"
        if [ $? -ne 0 ]; then
          echo "failed to create bg image."
          exit 1
        fi
    else
        echo "invalid argument for direction"
        exit 1
    fi fi
fi
feh --bg-scale $path/result.png
echo "$?"
exit 0

