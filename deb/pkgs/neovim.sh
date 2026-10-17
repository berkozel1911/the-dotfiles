# The nvim config uses vim.lsp.config / vim.lsp.enable (0.11+); Debian 13 ships 0.10.
# Replaces Debian's neovim + neovim-runtime split with one package.
version=0.12.5
summary="Vim-fork focused on extensibility and usability"
url=https://neovim.io/
source=https://github.com/neovim/neovim/archive/v$version/neovim-$version.tar.gz
builddeps=(cmake ninja-build gettext unzip)
fields=("Provides: editor, neovim-runtime" "Conflicts: neovim-runtime" "Replaces: neovim-runtime")

build() {
    # The bundled deps install into .deps/usr, which DESTDIR would redirect.
    DESTDIR= make CMAKE_BUILD_TYPE=Release CMAKE_INSTALL_PREFIX=/usr CMAKE_EXTRA_FLAGS=-DENABLE_TRANSLATIONS=ON
    cmake --install build
}
