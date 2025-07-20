#!bin/sh
# @author sc
# @signal.sh

SIGNAL_BRIGHTNESS_DOWN=1
SIGNAL_BRIGHTNESS_UP=2
SIGNAL_VOLUME_DOWN=3
SIGNAL_VOLUME_UP=4
SIGNAL_VOLUME_MUTE=5
SIGNAL_VOLUME_UNMUTE=6
SIGNAL_MICROPHONE_VOLUME_DOWN=7
SIGNAL_MICROPHONE_VOLUME_UP=8
SIGNAL_MICROPHONE_VOLUME_MUTE=9
SIGNAL_MICROPHONE_VOLUME_UNMUTE=10
SIGNAL_SCREENSHOT_COMPLETED=11

# we can define more signals as needed
signal_send() {
    local signal=$1
    local sig_fifo_path="/tmp/signal_fifo"
    if [ ! -p "$sig_fifo_path" ]; then
        mkfifo "$sig_fifo_path"
    fi
    echo "$signal" > "$sig_fifo_path"
}
