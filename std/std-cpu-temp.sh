#!/bin/bash
# @modifier sc
# @since 2025
#
# @require lm-sensors

# -m1: match only the first occurrence
# -oP: use Perl-compatible regex

# have decimal
#temp=$(sensors | grep -m1 -oP '\+?\d+(\.\d+)?(?=°C)' | sed 's/^+//')
temp="$(($(cat /sys/class/hwmon/hwmon3/temp1_input) / 1000))"
# have no decimal
#temp=$(sensors | grep -m1 -oP '\+?\d+(\.\d+)?(?=°C)' | sed -E 's/^\+?([0-9]+).*/\1/')


if (( $(awk "BEGIN {print ($temp < 50)}") )); then
    icon=""
elif (( $(awk "BEGIN {print ($temp < 70)}") )); then
    icon=""
else
    icon=""
fi

echo "$icon ${temp}°C"

