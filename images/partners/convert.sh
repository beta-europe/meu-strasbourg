#!/usr/bin/env sh
for IMG in "$@"
do
  convert "$IMG" -thumbnail '380x320>' -background white -gravity center -extent 380x320 -strip -quality 70 ${IMG%.*}.jpg
done