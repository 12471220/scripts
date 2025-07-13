#!/usr/bin/sh
# @author sc
# @scince 2025

level="$(brightnessctl | awk '/%/{print $3}')"

case $level in
    [0-9])  icon="󱩎" ;;
    1[0-9]) icon="󱩏" ;;
    2[0-9]) icon="󱩐" ;;
    3[0-9]) icon="󱩐" ;;
    4[0-9]) icon="󱩑" ;;
    5[0-9]) icon="󱩒" ;;
    6[0-9]) icon="󱩓" ;;
    7[0-9]) icon="󱩔" ;;
    8[0-9]) icon="󱩕" ;;
    9[0-9]) icon="󱩖" ;;
    100)    icon="󰛨" ;;
esac

echo "$icon" "$level%"
