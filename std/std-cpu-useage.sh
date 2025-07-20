#!/usr/bin/sh
# @author nate zhou
# @since 2025

usage=" $(mpstat --dec=0 1 1| awk 'NR==4 {print 100 - $NF}')"

icon=""

echo "$icon$usage"%

