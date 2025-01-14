#!/usr/bin/env fish
echo (rofi -p "calc" -dmenu) | xargs -i{} echo {} | math | rofi -mesg "The result is copied on system clipboard" -p "Result" -dmenu | xclip -i -sel clip
