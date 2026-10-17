# Ghostty pins the Zig minor version (1.3.x needs Zig 0.15.x), which Debian
# doesn't package, so the official Zig tarball is used for the build.
version=1.3.1
summary="Fast, native, feature-rich terminal emulator"
url=https://ghostty.org/
source=https://release.files.ghostty.org/$version/ghostty-$version.tar.gz
builddeps=(libgtk-4-dev libadwaita-1-dev libgtk4-layer-shell-dev gettext libxml2-utils blueprint-compiler)
# ncurses-term already ships terminfo/g/ghostty; this package adds xterm-ghostty.
depends=(ncurses-term)

zig=0.15.2

build() {
    local zigdir=/opt/zig-$zig
    if [[ ! -x $zigdir/zig ]]; then
        mkdir -p "$zigdir"
        curl -fL "https://ziglang.org/download/$zig/zig-x86_64-linux-$zig.tar.xz" \
            | tar -xJ -C "$zigdir" --strip-components=1
    fi

    "$zigdir/zig" build \
        --prefix /usr \
        -j"${JOBS:-4}" \
        -Doptimize=ReleaseFast \
        -Dcpu=baseline \
        -Dpie=true \
        -Dversion-string="$version"

    # libghostty-vt is an embedding library the terminal doesn't use; the
    # plain ghostty terminfo entry would clash with ncurses-term.
    rm -rf "$DESTDIR"/usr/include "$DESTDIR"/usr/lib/libghostty-vt.so* \
           "$DESTDIR"/usr/share/pkgconfig "$DESTDIR"/usr/share/terminfo/g
}
