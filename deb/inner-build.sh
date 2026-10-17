#!/usr/bin/env bash
# Runs inside the container. See build.sh.
#
# Each pkgs/<name>.sh sets:
#   version, release, summary, url    package metadata
#   builddeps=(...)                   Debian packages needed to build
#   depends=(...)                     extra runtime Depends (shared libs are found automatically)
#   recommends=(...)                  optional
#   fields=(...)                      optional extra control lines ("Conflicts: foo", ...)
#   source                            upstream tarball URL (saved to /work/sources)
# and defines build(), run in the unpacked source with $DESTDIR to install into.
set -euo pipefail
export DEBIAN_FRONTEND=noninteractive
apt-get update -qq

for pkg in "$@"; do
    echo "==> $pkg"
    unset version release summary url source
    builddeps=() depends=() recommends=() fields=()
    # shellcheck source=/dev/null
    source "/work/pkgs/$pkg.sh"
    release=${release:-1}

    apt-get install -y -qq --no-install-recommends "${builddeps[@]}" >/dev/null

    tarball=/work/sources/$(basename "$source")
    [[ -f $tarball ]] || curl -fL --retry 3 -o "$tarball" "$source"

    work=/tmp/build/$pkg
    rm -rf "$work" && mkdir -p "$work/src" "$work/root"
    tar -xf "$tarball" -C "$work/src" --strip-components=1
    export DESTDIR=$work/root
    (cd "$work/src" && build)
    find "$DESTDIR" -type d -empty -delete

    # Shared-library dependencies of everything ELF in the package
    mkdir -p "$work/shlibs/debian"
    printf 'Source: %s\n\nPackage: %s\nArchitecture: any\n' "$pkg" "$pkg" > "$work/shlibs/debian/control"
    mapfile -t elfs < <(find "$DESTDIR" -type f -perm -u+x -exec sh -c 'head -c4 "$1" | grep -q ELF' _ {} \; -print)
    shlibs=$(cd "$work/shlibs" && dpkg-shlibdeps -O "${elfs[@]}" | sed -n 's/^shlibs:Depends=//p')

    deps=$(IFS=,; echo "${shlibs}${depends[*]:+,${depends[*]}}" | sed 's/, */, /g')
    mkdir -p "$DESTDIR/DEBIAN"
    {
        echo "Package: $pkg"
        echo "Version: $version-$release"
        echo "Architecture: $(dpkg --print-architecture)"
        echo "Maintainer: Berk Özel <berkozel@protonmail.com>"
        echo "Installed-Size: $(du -sk --exclude=DEBIAN "$DESTDIR" | cut -f1)"
        echo "Depends: $deps"
        (( ${#recommends[@]} )) && echo "Recommends: $(IFS=,; echo "${recommends[*]}" | sed 's/,/, /g')"
        (( ${#fields[@]} )) && printf '%s\n' "${fields[@]}"
        echo "Homepage: $url"
        echo "Description: $summary"
        echo " Built from upstream source by the-dotfiles deb/build.sh."
    } > "$DESTDIR/DEBIAN/control"

    rm -f /work/repo/"${pkg}"_*.deb
    dpkg-deb --root-owner-group -Zxz --build "$DESTDIR" "/work/repo/${pkg}_${version}-${release}_$(dpkg --print-architecture).deb"
    rm -rf "$work"
done

(cd /work/repo && dpkg-scanpackages --multiversion . 2>/dev/null > Packages)
