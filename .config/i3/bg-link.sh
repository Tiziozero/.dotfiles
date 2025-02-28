#!/usr/bin/bash

python3 $HOME/.config/i3/get_cookies_for_wget.py >/dev/null 2>&1

path=$"$HOME/.config/several/sus/.resources"
# echo "Enter link/path"
# read file

if [ -z "$1" ]; then
    echo "Error: missing link!"
    exit 1  # Exit script with an error code (optional)
fi

wget --load-cookies=cookies.txt \
     --referer "https://www.pixiv.net" \
     --user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3" \
     $1 \
     -O $path/img >/dev/null 2>&1

if [ $? -ne 0 ]; then
  echo "wget failed to download the image."
  exit 1
fi

if [ -z "$2" ]; then
    convert $path/img -resize x1080 -gravity center -background black -extent 1920x1080 $path/result.png >/dev/null 2>&1
    if [ $? -ne 0 ]; then
      echo "failed to create bg image."
      exit 1
    fi
else
    if [[ "$2" == "r" ]]; then
        convert $path/img -resize x1080 -gravity east -background black -extent 1920x1080 $path/result.png >/dev/null 2>&1
        if [ $? -ne 0 ]; then
          echo "failed to create bg image."
          exit 1
        fi
    else if [[ "$2" == "l" ]]; then
        convert $path/img -resize x1080 -gravity west -background black -extent 1920x1080 $path/result.png >/dev/null 2>&1
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
exit 0

