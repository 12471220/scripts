#!/bin/bash
# @author: sc
# @date: Jul.13,25
# @requirements: swaybg(wayland) | feh(x11)

# exit on error
set -e
dir_path="$HOME/pic/wallpaper"
log_file="$HOME/.cache/scripts.log"

exec >> "$log_file" 2>&1

if [[ ! -d "$dir_path" ]]; then
    echo "$(date "+%D %X") [ERROR]: Directory $dir_path does not exist."
    exit 1
fi

nums=$(find "$dir_path" -maxdepth 1 -type f | wc -l)

if [[ $nums -eq 0 ]]; then
    echo "$(date "+%D %X") [INFO]: No files found in $dir_path."
    exit 1
fi

ran=$(( RANDOM % nums + 1 ))

selected=$(find "$dir_path" -maxdepth 1 -type f | sed -n "${ran}p")

if [[ $XDG_SESSION_TYPE == wayland ]]; then
    # Wayland environment
    if command -v swaybg &> /dev/null; then
        swaybg -i "$selected" -m fill
        echo "$(date "+%D %X") [INFO]: Set wallpaper to $selected using swaybg."
    else
        echo "$(date "+%D %X") [ERROR]: swaybg is not installed."
        exit 1
    fi

else
    # X11 environment
    if command -v feh &> /dev/null; then
        feh --bg-fill "$selected"
        echo "$(date "+%D %X") [INFO]: Set wallpaper to $selected using feh."
    else
        echo "$(date "+%D %X") [ERROR]: feh is not installed."
        exit 1
    fi
fi

