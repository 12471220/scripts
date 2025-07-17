#!/bin/sh
# @author sc
# @date 2025/07/12
# @dependents pipewire
# @require signal.sh

source $SCRIPT_HOME/signal.sh
_volume_up() {
    # This function increases the system volume by 3% using wpctl (PipeWire tools).
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 3%+>/dev/null
}
_volume_down() {
    # This function decreases the system volume by 3% using wpctl (PipeWire tools).
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 3%- >/dev/null
}
_volume_mute_toggle() {
    # This function toggles the mute state of the default audio sink using wpctl.
    muted=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED && echo 1 || echo 0)
    if [ "$muted" -eq 1 ]; then
        wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 >/dev/null
    else
        wpctl set-mute @DEFAULT_AUDIO_SINK@ 1 >/dev/null
    fi
}

main() {
    # This function checks the first argument and calls the appropriate volume function.
    case "$1" in
        up)
            _volume_up
            signal_send $SIGNAL_VOLUME_UP
            ;;
        down)
            _volume_down
            signal_send $SIGNAL_VOLUME_DOWN
            ;;
        mute)
            _volume_mute_toggle
            if [ "$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED && echo 1 || echo 0)" -eq 1 ]; then
                signal_send $SIGNAL_VOLUME_MUTE
            else
                signal_send $SIGNAL_VOLUME_UNMUTE
            fi
            ;;
        *)
            echo "Usage: $(basename $0) {up|down|mute}"
            exit 1
            ;;
    esac
}

# If the script is being run directly, call the main function
if [ "${BASH_SOURCE[0]}" = "${0}" ] || [ -z "${BASH_SOURCE[0]}" ]; then
    main "$@"
fi
