#!/bin/sh
# @author sc
# @date 2025/07/12
# require pipewire, notify-send

source $SCRIPT_HOME/signal.sh

_microphone_volume_down() {
    wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%- 2> /dev/null
    signal_send $SIGNAL_MICROPHONE_VOLUME_DOWN
}

_microphone_volume_up() {
    wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%+ 2> /dev/null
    signal_send $SIGNAL_MICROPHONE_VOLUME_UP
}

_microphone_volume_mute_toggle() {
    status="$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep '[MUTED]')"
    if [ -z "$status" ]; then
        wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 1
        signal_send $SIGNAL_MICROPHONE_VOLUME_MUTE
    else
        wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 0
        signal_send $SIGNAL_MICROPHONE_VOLUME_UNMUTE
    fi
}

main() {
    local para=$1
    case "$para" in
        down)
            _microphone_volume_down
            ;;
        up)
            _microphone_volume_up
            ;;
        mute)
            _microphone_volume_mute_toggle
            ;;
        *)
            echo "Usage: $0 {up|down|mute}"
            exit 1
            ;;
    esac
}


# If the script is being run directly, call the main function
if [ "${BASH_SOURCE[0]}" = "${0}" ] || [ -z "${BASH_SOURCE[0]}" ]; then
    main "$@"
fi

