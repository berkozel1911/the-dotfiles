# Yazi needs a newer Rust than Debian 13's (1.85), so the build uses rustup's stable toolchain.
version=26.9.1
summary="Blazing fast terminal file manager written in Rust"
url=https://github.com/sxyazi/yazi
source=$url/archive/v$version/yazi-$version.tar.gz
recommends=(file ffmpeg poppler-utils fd-find ripgrep fzf zoxide imagemagick 7zip jq wl-clipboard)

build() {
    export RUSTUP_HOME=/opt/rustup CARGO_HOME=/opt/cargo PATH=/opt/cargo/bin:$PATH
    command -v cargo >/dev/null ||
        curl -fsSL https://sh.rustup.rs | sh -s -- -y -q --profile minimal --no-modify-path

    YAZI_GEN_COMPLETIONS=1 cargo build --release --locked -j"${JOBS:-4}" -p yazi-fm -p yazi-cli

    install -Dm755 target/release/yazi "$DESTDIR/usr/bin/yazi"
    install -Dm755 target/release/ya   "$DESTDIR/usr/bin/ya"
    install -Dm644 assets/yazi.desktop "$DESTDIR/usr/share/applications/yazi.desktop"
    install -Dm644 assets/logo.png     "$DESTDIR/usr/share/icons/hicolor/256x256/apps/yazi.png"

    local bin dir
    for bin in yazi ya; do
        dir=yazi-boot/completions; [[ $bin == ya ]] && dir=yazi-cli/completions
        install -Dm644 "$dir/$bin.bash" "$DESTDIR/usr/share/bash-completion/completions/$bin"
        install -Dm644 "$dir/_$bin"     "$DESTDIR/usr/share/zsh/vendor-completions/_$bin"
        install -Dm644 "$dir/$bin.fish" "$DESTDIR/usr/share/fish/vendor_completions.d/$bin.fish"
    done
}
