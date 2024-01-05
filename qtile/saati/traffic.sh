#!/bin/bash

path_of_here=$(dirname "$0")
cd "${path_of_here}"
path_of_here=$(pwd)

myupload="ﯴ"
mydownload="ﯲ"
myRX2=0
myTX2=0
while :
do
myRX1=$myRX2
myTX1=$myTX2


myRX2="$(ip -s link show $1 | awk '/[0-9]/ {print $1}' | awk '{if(NR==3) print $0}')"
myTX2="$(ip -s link show $1 | awk '/[0-9]/ {print $1}' | awk '{if(NR==4) print $0}')"

printf "%s%s %s%s" "$myupload:" $(( ((myTX2/1024)-(myTX1/1024))/2 )) "$mydownload:" $(( ((myRX2/1024)-(myRX1/1024))/2 )) > "$path_of_here/myspeed"

sleep 2 
done &
exit 1
