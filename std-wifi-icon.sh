#!/bin/sh
# @author sc
# @date 2025/07/12

device="wlp4s0"
status="$(nmcli device status|grep "^$device\s"|awk '{print $3}')"

level="$(awk '/^\s*w/ {print int($3 * 100 / 70)}' /proc/net/wireless)"
# connected disconnected unavailable 
#
if [ "$status" = "connected" ];then
    if [ "$level" -le 25 ]; then
        icon="󰤟"
    elif [ "$level" -le 50 ]; then
        icon="󰤢"
    elif [ "$level" -le 75 ]; then
        icon="󰤥"
    elif [ "$level" -le 100 ]; then
        icon="󰤨"
    fi
wifi_name="$(nmcli device status | awk -v dev="$device" '$1 == dev {for (i=4; i<=NF; i++) printf "%s%s", $i, (i<NF ? " " : "\n")}')"
elif [ "$status" = "disconnected" ];then
    icon="󰤯"
    wifi_name=""
else 
    icon="󰤮"
    wifi_name=""
fi

echo "${icon} ${wifi_name}"

