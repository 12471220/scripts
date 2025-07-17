#!/usr/bin/sh
# @author nate zhou
# @modifier sc
# @since 2025


status="$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@)"
muted="$(echo $status | grep 'MUTED')"

if [[ -z "$muted" ]];then
    volume="$(echo $status | sed 's/[^0-9]*//g; s/^0//' )%"
    icon="󰍬 $volume"
else
    icon="󰍭"
fi

echo "$icon"
