#!/usr/bin/env bash
# Waybar indicator for a Hyprland special workspace.
# usage: scratch.sh <name> <icon>

name="$1" icon="$2"
count=$(hyprctl workspaces -j | jq --arg n "special:$name" '[.[] | select(.name == $n)][0].windows // 0')

if (( count > 0 )); then
    printf '{"text":"%s","class":"active","tooltip":"%s scratchpad (%s)"}\n' "$icon" "$name" "$count"
else
    printf '{"text":"%s","class":"empty","tooltip":"%s scratchpad (not started)"}\n' "$icon" "$name"
fi
