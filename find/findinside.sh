#!/usr/bin/env bash

grep -Ril "$2" "$(dirname "$1")" 2>/dev/null


