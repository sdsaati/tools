#!/usr/bin/env bash
rofi -modi drun,run -show drun \
  -matching normal -show-icons -i -p \
  -kb-accept-entry "Return,KP_Enter" \
#  -kb-row-down "Control+j"
  -kb-remove-to-eol "" \
#  -kb-row-up "Control+k"
  -kb-cancel "Escape" \
  -kb-row-last "Control+g"
