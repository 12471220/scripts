#/bin/bash
# @author sc
# @date 2025/07/13

time=$(date "+%H:%M %b.%d,%a")
index=$((10#$(date +%I) - 1))
#time_icon=(           )
time_icon=(󱐿 󱑀 󱑁 󱑂 󱑃 󱑄 󱑅 󱑆 󱑇 󱑈 󱑉 󱑊)

echo ${time_icon[$index]} $time

