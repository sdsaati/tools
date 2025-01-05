#!/usr/bin/env bash
# for selecting themes you can run this command: rofi-theme-selector

#rofi -show run -theme blue -font "ComicShannsMono Nerd Font Bold 14" -show combi
#rofi -modi combi,drun -show drun -matching normal -theme fancy -show-icons -i -p -font "Fira Sans Bold 16"
a=""
export WIDTH="80%"
if [ -z "$1" ]; then
  a="combi"
else
  a="$1"
fi
rofi -config ~/bin/rofi/config.rasi -show "$a" \
-modes combi \
-combi-modes "window,drun,run,ssh" \
-window-title " " \
-mesg " " \
-markup \
-dpi 0 \
-fixed-num-lines \
-parse-known-hosts \
-parse-hosts \
-theme DarkBlue \
-combi-display-format " ({mode}) {text}" \
-font "SpaceMono Nerd Font 16" \
-matching fuzzy -show-icons -i -p " " \
-window-thumbnail \
-kb-accept-entry "Return,KP_Enter" \
-kb-row-up "Control+p" \
-kb-row-down "Control+n" \
-kb-remove-to-eol "" \
-kb-cancel "Escape" \
-kb-row-last "Control+g"
