#!/bin/sh
# @author sc
# @date 7-14/25

# please write the city name in $HOME/.cache/city
sav_weather_file=$HOME/.cache/hf-weather
sav_city_file=$HOME/.cache/city
py_script=$SCRIPT_HOME/std/std-weather-hf.py
city=""

# get city
if [ -f $sav_city_file ]; then
    city=$(cat $sav_city_file)
else
    echo "ERROR: No city file found" >&2
    exit 1
fi

weather_info=$(python $py_script "$city")
if [ $? -eq 0 ]; then
    echo "$weather_info" > "$sav_weather_file"
    echo $weather_info | awk '{print $1, $2}'
else
    cur_timestamp=$(date "+%s")
    old_timestamp=$(date -d "$(cat $sav_weather_file | awk '{print $3}')" "+%s")
    diff=$((cur_timestamp - old_timestamp))
    weather_info=$(cat $sav_weather_file | awk '{print $1, $2}')
    if [ $diff -gt 3600 ]; then
        valid_time="$((diff / 3600))h ago"
    else
        valid_time="$((diff / 60))min ago"
    fi
    echo "$weather_info($valid_time)"
fi
