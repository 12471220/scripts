#!/bin/sh
# @author sc
# @date 2025/07/12
# @require pipewire, notify-send

# This script toggles the mute state of the default audio sink using wpctl and displays a notification with the current mute status.

muted=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED && echo 1 || echo 0)

if [ "$muted" -eq 1 ]; then
    wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
    icon=audio-volume-medium
    stat="Unmuted"
else
    wpctl set-mute @DEFAULT_AUDIO_SINK@ 1
    icon=audio-volume-muted
    stat="Muted"
fi
notify-send "$(basename "$0")" \
    "Status: $stat" \
    --icon=$icon \
    --app-name="volume-control" \
    --expire-time=2000

