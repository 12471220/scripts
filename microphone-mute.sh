#!/bin/sh
# @author sc
# @date 2025/07/12
# require pipewire, notify-send

status="$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep '[MUTED]')"
if [ -z "$status" ]; then
    wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 1
    icon=microphone-sensitivity-muted
    info="Microphone MUTED"
else
    wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 0
    icon=audio-input-microphone
    info="Microphone unmuted"
fi

notify-send "$(basename "$0")" \
    "$info" \
    --app-name="volume-control" \
    --icon=$icon \
    --expire-time=2000

