#!/bin/bash
mybattery=$(cat /sys/class/power_supply/BAT0/capacity)
icon=""
printf "%s%s\\n" "$icon " "$mybattery" 
exit 1
