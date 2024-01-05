#!/bin/bash

# List all the network interfaces that are Running (are UP)
# Search for ppp interface that is UP
isTherePPP=`ip link ls up | awk '{print $2}' | xargs echo | awk '{print $1 " " $3 " " $5 " " $7 " " $9 " " $11}' | sed 's/://g'`


if echo $isTherePPP | grep -q 'ppp\|vpn'; then
    result=''
else
    result=''
fi

printf "%s%s\\n" "VPN:" "$result" 

exit 1
