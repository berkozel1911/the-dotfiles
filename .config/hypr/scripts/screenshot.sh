#!/usr/bin/env bash
# Screenshot -> swappy for annotation. Ctrl+C copies, Ctrl+S saves (see ~/.config/swappy/config).
# usage: screenshot.sh region|full

case "$1" in
    full) grab=(grim -) ;;
    *)    geom=$(slurp -d) || exit 0
          grab=(grim -g "$geom" -) ;;
esac

mkdir -p "${XDG_PICTURES_DIR:-$HOME/Pictures}/Screenshots"
"${grab[@]}" | swappy -f -
