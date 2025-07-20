#!/usr/bin/sh
# @author nate zhou
# @modifier sc
# @since 2025
# @require bluetoothctl

level=" $(bluetoothctl info | grep -m1 'Battery Percentage' | awk -F'[()]' '{print $2}')"

if [ -n "$level" ];then 
    icon="" || level="$level%"
else
    icon="󰂲"
fi

echo "$icon$level"

