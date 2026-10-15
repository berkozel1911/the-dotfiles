#!/usr/bin/env bash
# Toggle hyprsunset between warm and neutral, then refresh the waybar module.
# usage: nightlight.sh [status]

state="${XDG_RUNTIME_DIR:-/tmp}/nightlight"
warm=4500

if [[ "$1" == "status" ]]; then
    if [[ -f "$state" ]]; then
        printf '{"text":"󰖔","class":"on","tooltip":"Night light on (%sK)"}\n' "$warm"
    else
        printf '{"text":"󰖨","class":"off","tooltip":"Night light off"}\n'
    fi
    exit 0
fi

if [[ -f "$state" ]]; then
    hyprctl hyprsunset identity >/dev/null && rm -f "$state"
else
    hyprctl hyprsunset temperature "$warm" >/dev/null && touch "$state"
fi

pkill -RTMIN+8 waybar
