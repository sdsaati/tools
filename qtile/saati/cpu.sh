#!/bin/bash
CPU=$(echo $(top -bn1 | grep load | awk '{printf "%.2f", $(NF-2)}')*10 | bc)
icon=""
printf "%s %s%%\\n" "$icon" "$CPU" 
exit 1
