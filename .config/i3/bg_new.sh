selected_file=$(python3.12 ./getLinks.py | fzf)

echo "$selected_file"
feh --bg-max $selected_file
