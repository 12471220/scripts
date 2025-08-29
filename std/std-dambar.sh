#!/bin/bash

_time=""
_battery=""
_brightness=""
_volume=""
_microphone=""
_wifi=""
_ethernet=""
_weather=""
_cpu_temp=""
_cpu_useage=""
_mem_useage=""

_update_time() {
    _time=$($SCRIPT_HOME/std/std-datetime-icon.sh)
}

_update_battery() {
    _battery=$($SCRIPT_HOME/std/std-battery-icon.sh)
}

_update_brightness() {
    _brightness=$($SCRIPT_HOME/std/std-brightness-icon.sh)
}

_update_volume() {
    _volume=$($SCRIPT_HOME/std/std-volume-icon.sh)
}

_update_microphone() {
    _microphone=$($SCRIPT_HOME/std/std-microphone-icon.sh)
}

_update_wifi() {
    _wifi=$($SCRIPT_HOME/std/std-wifi-icon.sh)
}

_update_ethernet() {
    _ethernet=$($SCRIPT_HOME/std/std-ethernet-icon.sh)
}
_update_weather() {
    _weather=$($SCRIPT_HOME/std/std-weather-hf.sh)
}

_update_cpu_temp() {
    _cpu_temp=$($SCRIPT_HOME/std/std-cpu-temp.sh)
}
    
_update_cpu_useage() {
    _cpu_useage=$($SCRIPT_HOME/std/std-cpu-useage.sh)
}

_update_mem_useage() {
    _mem_useage=$($SCRIPT_HOME/std/std-mem-useage.sh)
}

_hear_pipe() {
    while true; do
        read -r signal < "$dambar_fifo_path"
        case $signal in
            $SIGNAL_BRIGHTNESS_DOWN) 
                ;&
            $SIGNAL_BRIGHTNESS_UP)
                _update_brightness ;;
            $SIGNAL_VOLUME_DOWN) 
                ;&
            $SIGNAL_VOLUME_UP) 
                ;&
            $SIGNAL_VOLUME_MUTE)
                ;&
            $SIGNAL_VOLUME_UNMUTE) 
                _update_volume ;;
            $SIGNAL_MICROPHONE_VOLUME_DOWN)
                ;&
            $SIGNAL_MICROPHONE_VOLUME_UP)
                ;&
            $SIGNAL_MICROPHONE_VOLUME_MUTE)
                ;&
            $SIGNAL_MICROPHONE_VOLUME_UNMUTE)
                _update_microphone ;;
            *)
                ;;
        esac
    done
}

main() {
    local tick=0

    while true; do
        [ $((tick % 20)) -eq 0 ] && _update_time
        [ $((tick % 5)) -eq 0 ] && _update_battery
        [ $((tick % 20)) -eq 0 ] && _update_brightness
        [ $((tick % 20)) -eq 0 ] && _update_volume
#        [ $((tick % 5)) -eq 0 ] && _update_microphone
        [ $((tick % 5)) -eq 0 ] && _update_wifi
        [ $((tick % 5)) -eq 0 ] && _update_ethernet
        [ $((tick % 1800)) -eq 0 ] && _update_weather
        [ $((tick % 2)) -eq 0 ] && _update_cpu_temp
        [ $((tick % 2)) -eq 0 ] && _update_cpu_useage
        [ $((tick % 2)) -eq 0 ] && _update_mem_useage

        echo "| $_weather | $_cpu_useage | $_cpu_temp | $_mem_useage | $_brightness | $_volume | $_wifi | $_ethernet | $_battery | $_time"
        tick=$((tick + 1))
        sleep 1
    done
}

main
