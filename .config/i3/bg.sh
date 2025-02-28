#!/usr/bin/bash
path=$"$HOME/.config/several/sus/.resources"
search_query=$'00'
# selected_file=$(ls $path | grep $search_query | fzf)
selected_file=$(ls $path | fzf)

echo $path/$selected_file
convert $path/$selected_file -resize x1080 -gravity east -background black -extent 1920x1080 $path/result.png

feh --bg-scale $path/result.png

