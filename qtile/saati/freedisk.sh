#!/bin/bash
myfreedisk=$(df -h | awk '{ if ($6 == "/") print $4 }')
icon=""
printf "%s%s\\n" "$icon " "$myfreedisk" 
exit 1
