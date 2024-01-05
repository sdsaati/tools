#!/bin/bash
myfreemem=$(free -h | awk '(NR==2){ print $3 }')
icon=""
printf "%s%s\\n" "$icon " "$myfreemem" 
exit 1
