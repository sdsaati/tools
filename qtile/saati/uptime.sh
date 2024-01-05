#!/bin/bash
myuptime=$(uptime | awk '{print $3}' | sed 's/,//g')
icon=""
printf "%s%s\\n" "$icon " "$myuptime" 
exit 1
