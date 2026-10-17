#!/usr/bin/env bash
# Build the .debs described in pkgs/ inside a throwaway Debian 13 container.
#
#   ./build.sh                 build everything in order.txt
#   ./build.sh ghostty ...     build only the named packages (in the given order)
#
# Results land in ./repo (a flat apt repository). Install on the host with:
#   sudo apt install ./repo/*.deb

set -euo pipefail
cd "$(dirname "$0")"

image=dotfiles-debbuild
podman image exists "$image" || podman build -t "$image" -f Containerfile .

mkdir -p sources repo
pkgs=("$@")
(( ${#pkgs[@]} )) || mapfile -t pkgs < <(grep -vE '^\s*(#|$)' order.txt)

podman run --rm -i $([[ -t 0 ]] && echo -t) \
    -v "$PWD:/work:Z" \
    -e JOBS="$(nproc)" \
    "$image" /work/inner-build.sh "${pkgs[@]}"
