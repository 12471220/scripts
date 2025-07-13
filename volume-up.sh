#!/bin/sh
# @author sc
# @date 2025/07/12
# @require pipewire, notify-send

# This script increases the default system volume by 3% and displays a notification with the new volume level.
wpctl set-volume @DEFAULT_AUDIO_SINK@ 3%+>/dev/null

notify-send "$(basename "$0")" \
    "$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf "Current: %d%", $2*100}')" \
    --icon=audio-volume-high \
    --app-name="volume-control" \
    --expire-time=2000

