#!/usr/bin/env bash
find "$2" -iname "$3" -mtime -"$1" 2>/dev/null

