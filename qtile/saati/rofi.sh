#!/usr/bin/env bash
# for selecting themes you can run this command: rofi-theme-selector

#rofi -show run -theme blue -font "ComicShannsMono Nerd Font Bold 14" -show combi
#rofi -modi combi,drun -show drun -matching normal -theme fancy -show-icons -i -p -font "Fira Sans Bold 16"
if [ -z "$1" ]; then
  rofi -config ~/bin/rofi/config.rasi -show drun  \
  -matching normal -show-icons -i -p \
  -kb-accept-entry "Return,KP_Enter" \
  -kb-row-up "Control+k" \
  -kb-row-down "Control+j" \
  -kb-remove-to-eol "" \
  -kb-cancel "Escape" \
  -kb-row-last "Control+g"
else
  rofi -config ~/bin/rofi/config.rasi -show "$1" \
  -matching normal -show-icons -i -p \
  -kb-accept-entry "Return,KP_Enter" \
  -kb-row-up "Control+k" \
  -kb-row-down "Control+j" \
  -kb-remove-to-eol "" \
  -kb-cancel "Escape" \
  -kb-row-last "Control+g"
fi
