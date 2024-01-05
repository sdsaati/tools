#!/bin/bash
mytemp=$(sed 's/000$/°C/' /sys/class/thermal/thermal_zone0/temp)
icon=""
printf "%s %s\\n" "$icon" "$mytemp" 
exit 1
