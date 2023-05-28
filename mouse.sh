#!/bin/bash
mouse_id=$(xinput list | grep -m 1 "ASUS ROG STRIX IMPACT" | awk '{print $7}' | sed 's/id=\([0-9]*\)/\1/')
xinput --set-prop ${mouse_id} 328 -0.78
