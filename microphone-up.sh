#!/bin/sh
# @author sc
# @date 2025/07/12
# require pipewire, notify-send

wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%+ 2> /dev/null

notify-send "$(basename "$0")" \
    "$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | awk '{printf "Current: %d%", $2*100}')" \
    --app-name="volume-control" \
    --expire-time=2000

