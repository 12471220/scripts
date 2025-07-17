#!/bin/bash
# @modified sc
# @since 2025
#
# @require lm-sensors

# -m1: match only the first occurrence
# -oP: use Perl-compatible regex
temp=$(sensors | grep -m1 -oP '\+?\d+(\.\d+)?(?=°C)' | sed 's/^+//')

if (( $(awk "BEGIN {print ($temp < 50)}") )); then
    icon=""
elif (( $(awk "BEGIN {print ($temp < 70)}") )); then
    icon=""
else
    icon=""
fi

echo "$icon ${temp}°C"

