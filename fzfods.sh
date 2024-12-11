#!/bin/bash
# FIXME: tihs script wont work right now
for file in $(ls); do
  content=$(odt2txt "$file" 2>/dev/null)
  path=$(echo "`pwd`/$file")
  echo $content | fzf && echo "$path"
done

