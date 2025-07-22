#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 /path/to/directory"
  exit 1
fi

DIR="$1"


mkdir "$DIR/new"

for file in "$DIR"/*.mp4; do
  # Skip if no files found
  [ -e "$file" ] || { echo "No .mp4 files found in $DIR"; exit 1; }

  filename=$(basename -- "$file")
  extension="${filename##*.}"
  filename_only="${filename%.*}"

  output="$DIR/new/${filename_only}_fixed.${extension}"

  echo "Processing '$file' -> '$output' ..."
  ffmpeg -err_detect ignore_err -i "$file" -c copy "$output"
done

echo "Done!"

