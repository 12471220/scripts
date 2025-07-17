#!/bin/bash
# @author sc
# @date 2025/07/12
# @depends brightnessctl, notify-send, wireplumber pipewire
# @require signal.sh

LOW_EXPIRE_TIME=2000
NORMAL_EXPIRE_TIME=5000
CRITICAL_EXPIRE_TIME=10000

source $SCRIPT_HOME/signal.sh

# core: notification function
_send_notification() {
    local signal=$1
    local title=""
    local message=""
    local icon=""
    local app_name=""
    local urgency="low"
    local expire_time=$LOW_EXPIRE_TIME
    
    case "$signal" in
        $SIGNAL_BRIGHTNESS_DOWN)
            title="Brightness DOWN"
            message="$(brightnessctl get | awk '{printf "current Brightness: %d%%", $1}')"
            icon="display-brightness-symbolic"
            ;;
        $SIGNAL_BRIGHTNESS_UP)
            title="Brightness UP"
            message="$(brightnessctl get | awk '{printf "current Brightness: %d%%", $1}')"
            icon="display-brightness-symbolic"
            ;;
        $SIGNAL_VOLUME_DOWN)
            title="Volume DOWN"
            message="$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf "current: %d%%", $2*100}')"
            icon="audio-volume-low"
            ;;
        $SIGNAL_VOLUME_UP)
            title="Volume UP"
            message="$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf "current: %d%%", $2*100}')"
            icon="audio-volume-high"
            ;;
        $SIGNAL_VOLUME_MUNTE)
            title="MUTED"
            message="volume is muted"
            icon="audio-volume-muted"
            urgency="normal"
            ;;
        $SIGNAL_VOLUME_UNMUTE)
            title="UNMUTED"
            message="volume is open"
            icon="audio-volume-medium"
            urgency="normal"
            ;;
        $SIGNAL_MICROPHONE_VOLUME_DOWN)
            title="Microphone Volume DOWN"
            message="$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | awk '{printf "current: %d%%", $2*100}')"
            icon="audio-input-microphone"
            ;;
        $SIGNAL_MICROPHONE_VOLUME_UP)
            title="Microphone Volume UP"
            message="$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | awk '{printf "current: %d%%", $2*100}')"
            icon="audio-input-microphone"
            ;;
        $SIGNAL_MICROPHONE_VOLUME_MUTE)
            title="Microphone MUTED"
            message="microphone is muted"
            icon="microphone-sensitivity-muted"
            urgency="normal"
            expire_time=$NORMAL_EXPIRE_TIME
            ;;
        $SIGNAL_MICROPHONE_VOLUME_UNMUTE)
            title="Microphone UNMUTED"
            message="microphone is open"
            icon="audio-input-microphone"
            urgency="normal"
            expire_time=$NORMAL_EXPIRE_TIME
            ;;
        *)
            return 1
            ;;
    esac
    
    notify-send "$title" \
        "$message" \
        --icon="$icon" \
        --app-name="$app_name" \
        -u "$urgency" \
        --expire-time="$expire_time"
}

sig_fifo_path="/tmp/signal_fifo"
log_path="$HOME/.cache/scripts.log"

if [ ! -p "$sig_fifo_path" ]; then
    mkfifo "$sig_fifo_path"
fi
if [ ! -f "$log_path" ]; then
    touch "$log_path"
fi

while true; do
    read -r signal < "$sig_fifo_path"
    _send_notification "$signal"
    if [ $? -ne 0 ]; then
        echo "$(date '+%Y-%m-%d %H:%M:%S') [ERROR]: Error signal: $signal" >> "$log_path"
    fi
done
