#!/usr/bin/sh
# @author nate zhou
# @modifier sc
# @since 2025

status="$(cat /sys/class/net/e*/operstate 2>/dev/null)"

if [[ "$status" == "up" ]];then
    icon="󰈁"
else
    icon="󰈂"
fi

echo "$icon"
