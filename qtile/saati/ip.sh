#!/bin/bash
myip=$(dig +short myip.opendns.com @resolver1.opendns.com)
icon=""
printf "%s%s\\n" "$icon " "$myip" 
exit 1
