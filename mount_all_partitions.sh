#!/usr/bin/env bash
lsblk  --noheadings --raw | awk '{print substr($0,0,4)}' | uniq -c | grep 1 | awk '{print "/dev/"$2}' | grep -E "(/dev/sd.)[[:digit:]]" | xargs -I{} -n1 udisksctl mount -b {}
lsblk  --noheadings --raw | awk '{print substr($0,0,4)}' | uniq -c | grep 1 | awk '{print "/dev/"$2}' | grep -E "(/dev/sd.)[[:digit:]]" | xargs -I{} -n1 ntfsfix {}