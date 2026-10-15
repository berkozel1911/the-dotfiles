#!/usr/bin/env bash
# Screenshot -> satty for annotation. Enter in satty copies, Ctrl+S saves.
# usage: screenshot.sh region|full

dir="${XDG_PICTURES_DIR:-$HOME/Pictures}/Screenshots"
mkdir -p "$dir"

case "$1" in
    full) grab=(grim -) ;;
    *)    geom=$(slurp -d) || exit 0
          grab=(grim -g "$geom" -) ;;
esac

"${grab[@]}" | satty --filename - \
    --output-filename "$dir/%Y-%m-%d_%H-%M-%S.png" \
    --copy-command wl-copy \
    --early-exit
