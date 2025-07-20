#!/bin/bash
# @dependencies: grim, slurp
# @require: signal.sh

. "$SCRIPT_HOME/signal.sh"

timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
filename="$HOME/pic/screenshots/screenshot_${timestamp}.png"

grim -g "$(slurp)" "$filename"
wl-copy < "$filename"
if [ $? -eq 0 ]; then
    signal_send $SIGNAL_SCREENSHOT_COMPLETED
fi
