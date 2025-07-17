#!/bin/sh
# @author sc

# please write the city name in $HOME/.cache/city
sav_wttr_file=$HOME/.cache/wttr
sav_city_file=$HOME/.cache/city
tmp_file=$(mktemp)
city=""

# get city
if [ -f $sav_city_file ]; then
    city=$(cat $sav_city_file)
else
    echo "ERROR: No city file found" >&2
    exit 1
fi

stat=$(curl -s -o $tmp_file -w "%{http_code}" "wttr.in/${city}?format=%c%t")
if [ "$stat" -eq 200 ]; then
    mv "$tmp_file" "$sav_wttr_file"
    echo "$(cat $sav_wttr_file)" | awk '{print $1$2}'
    date "+ %s">>$sav_wttr_file
else
    cur_timestamp=$(date "+%s")
    old_timestamp=$(cat $sav_wttr_file | awk '{print $3}')
    diff=$((cur_timestamp - old_timestamp))
    weather_info=$(cat $sav_wttr_file | awk '{print $1$2}')
    if [ $diff -gt 3600 ]; then
        valid_time="$((diff / 3600))h ago"
    else
        valid_time="$((diff / 60))min ago"
    fi
    echo "$weather_info($valid_time)"
fi
