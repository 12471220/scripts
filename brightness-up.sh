#!/bin/sh
# @author sc
# @date 2025/07/12
# @require brightnessctl, notify-send

# This script increases the screen brightness by 5% and displays a notification with the new brightness level.
brightnessctl set +5% >/dev/null
notify-send "$(basename "$0")" \
    "$(brightnessctl get | awk '{printf "Current Brightness: %d%", $1}')" \
    --icon=display-brightness-symbolic \
    --app-name="brightness-control" \
    --expire-time=2000
