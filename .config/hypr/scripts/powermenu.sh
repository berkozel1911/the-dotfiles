#!/usr/bin/env bash
# Power menu through fuzzel.

choice=$(printf '%s\n' \
    "󰌾  Lock" \
    "󰤄  Suspend" \
    "󰍃  Log out" \
    "󰜉  Reboot" \
    "󰐥  Shut down" \
    | fuzzel --dmenu --prompt "power " --lines 5 --width 20)

case "$choice" in
    *Lock)       loginctl lock-session ;;
    *Suspend)    systemctl suspend ;;
    *"Log out")  uwsm stop ;;
    *Reboot)     systemctl reboot ;;
    *"Shut down") systemctl poweroff ;;
esac
