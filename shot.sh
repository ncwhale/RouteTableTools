#!/bin/bash

SPATH="$HOME/Shots/$(coffee -e 't=new Date();console.log t.getFullYear()')截图"
FILENAME="$SPATH/$(python -c 'from datetime import datetime; print(datetime.strftime(datetime.now(), "%Y-%m-%d-%H%M%S-%f"))').png"

mkdir -p -v $SPATH
echo $FILENAME

shutter -s -n -e -o "$FILENAME" >/dev/null 2>&1
curl -F "image=@$FILENAME" -F "key=5401e4c11aea4001d574f64b406c0359" https://imgur.com/api/upload.xml | grep -E -o "<original_image>(.)*</original_image>" | grep -E -o "http://i.imgur.com/[^<]*" | xclip -selection c
notify-send "Screenshot has successfully uploaded to $(xclip -selection c -o)"

