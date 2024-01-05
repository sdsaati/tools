#!/usr/bin/env bash
path_of_here="$(cd "$(dirname "$0")" && pwd)"

mydate=$(date '+%a %y/%m/%d %H:%M:%S')
icon=""
printf "%s%s%s\\n" "$icon" "$("${path_of_here}"/pcal -t) " "$mydate" 
exit 1
