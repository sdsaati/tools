#!/bin/bash
mycountry=$(curl -s ipinfo.io | $(dirname "$0")/../jq -c -r '.country' | sed 's/\s*\n//g')

icon=""
printf "%s%s\\n" "$icon " "$mycountry" 
exit 1
