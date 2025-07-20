#!/usr/bin/sh
# @author nate zhou
# @since 2025

usage=" $(command free | awk '/Mem:/ {printf "%.0f\n", $3/$2 * 100}')"

icon=""

echo "$icon$usage%"
