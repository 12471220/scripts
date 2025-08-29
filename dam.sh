#!/bin/sh

# exec dam
[ -n pgrep -f dam.sh ] && killall dam.sh

$SCRIPT_HOME/std/std-dambar.sh | dam
