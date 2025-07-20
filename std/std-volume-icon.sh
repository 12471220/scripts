#!/bin/sh
# @author sc
# @date 2025/07/12

status="$(wpctl get-volume @DEFAULT_AUDIO_SINK@)"
# delete all non-numeric characters and leading zeroes
volume="$(echo $status | sed 's/[^0-9]*//g; s/^0//' )"
muted="$(echo $status | grep 'MUTED')"

[ -z "$muted" ] && icon=" " || icon=" "

echo "$icon $volume"%
