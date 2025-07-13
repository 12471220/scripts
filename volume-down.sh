#!/bin/sh
# @author: sc
# @date: 2025/07/12
# @require: pipewire, notify-send

# This script decreases the system volume by 3% using wpctl(pipewire toolls).
wpctl set-volume @DEFAULT_AUDIO_SINK@ 3%-

notify-send \
    "$(basename "$0")" \
    "$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf "Current: %d%", $2*100}')" \
    --icon=audio-volume-low \
    --app-name="volume-control" \
    --expire-time=2000

