#!/usr/bin/sh
# @author sc
# @since 2025

BAT="BAT0"
POWER="/sys/class/power_supply"

status="$(cat $POWER/$BAT/status)"
level="$(cat $POWER/$BAT/capacity)"

if [ "$level" -le 5 ];then
    icon=""
elif [ "$level" -le 25 ];then
    icon=""
elif [ "$level" -le 50 ];then
    icon=""
elif [ "$level" -le 90 ];then
    icon=""
elif [ "$level" -le 100 ];then
    icon=""
fi

case "$status" in
    "Not charging")
        icon=""
        ;;
    "Charging")
        icon="$icon ⚡️"
        ;;
    "Full")
        icon="$icon "
        ;;
esac
