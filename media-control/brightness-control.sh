#!/bin/sh
# @author sc
# @date 2025/07/12
# @modified 2025/07/15
# @depends brightnessctl
# @require signal.sh

source $SCRIPT_HOME/signal.sh
brightness_down() {
    brightnessctl set 5%- >/dev/null
}
brightness_up() {
    brightnessctl set +5% >/dev/null
}

main() {
    local para=$1
    case "$para" in
        down)
            brightness_down
            signal_send $SIGNAL_BRIGHTNESS_DOWN
            ;;
        up)
            signal_send $SIGNAL_BRIGHTNESS_UP
            brightness_up
            ;;
        *)
            echo "Usage: $0 {up|down}"
            exit 1
            ;;
    esac
}

# If the script is being run directly, call the main function
if [ "${BASH_SOURCE[0]}" = "${0}" ] || [ -z "${BASH_SOURCE[0]}" ]; then
    main "$@"
fi
