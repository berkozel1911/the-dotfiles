# Hyprland setup (Debian 13 "trixie")

Hyprland 0.55+ · Lua config · master-stack · Waybar · uwsm session · greetd login.
Palette: Kanagawa base (`#1f1f28`) + Ayu bright foregrounds, cyan accent (`#95e6cb`).

## 1. Packages

No third-party apt repos, no Flatpak. The Hyprland stack comes from **trixie-backports**,
so enable it first (`deb https://deb.debian.org/debian trixie-backports main` in `/etc/apt/sources.list`):

```bash
sudo apt update
sudo apt install -t trixie-backports \
  hyprland hyprlock hypridle hyprsunset hyprpolkitagent xdg-desktop-portal-hyprland uwsm greetd \
  pipewire-audio wireplumber
sudo apt install \
  tuigreet xdg-desktop-portal-gtk waybar fuzzel mako-notifier cliphist wl-clipboard grim slurp swappy \
  btop mpv imv zathura zathura-pdf-poppler pavucontrol playerctl jq zsh git
```

What Debian 13 lacks (or ships too old) is built from the scripts in [deb/](deb/) inside a
throwaway Debian 13 container (needs only `podman`, runs on any distro):

```bash
deb/build.sh               # everything in deb/order.txt; results in deb/repo/
sudo apt install ./deb/repo/*.deb
```

Self-built: ghostty (not in Debian), yazi (not in Debian), neovim 0.12 (Debian has 0.10; the nvim
config needs 0.11+, this replaces `neovim` + `neovim-runtime`).
To update one later: bump `version=` in `deb/pkgs/<name>.sh` and run `deb/build.sh <name>`.

Font: JetBrainsMono Nerd Font is used everywhere (bar, launcher, lock screen, terminal).
Debian only ships plain JetBrains Mono (`fonts-jetbrains-mono`), so grab the Nerd Font from
<https://github.com/ryanoasis/nerd-fonts/releases> into `~/.local/share/fonts` and run `fc-cache -f`.

## 2. Link configs

```bash
cd ~/Documents/devops/repo/the-dotfiles
for d in hypr waybar fuzzel mako ghostty zathura imv swappy uwsm nvim; do
  ln -sfn "$PWD/.config/$d" ~/.config/$d
done
ln -sf "$PWD/.config/mimeapps.list" ~/.config/mimeapps.list
```

## 3. Session services (once)

Daemons run as systemd user services under uwsm instead of from the Hyprland config:

```bash
systemctl --user enable waybar.service hypridle.service hyprsunset.service hyprpolkitagent.service
```

Mako is D-Bus activated, so it starts on the first notification.

## 4. Login: greetd + tuigreet

System files live in `etc/` and are **copied** (the greeter user, Debian's `_greetd`, can't read your home):

```bash
sudo install -Dm644 etc/greetd/config.toml /etc/greetd/config.toml
sudo install -Dm644 etc/greetd/vtrgb /etc/greetd/vtrgb
sudo install -Dm644 etc/systemd/system/greetd.service.d/palette.conf /etc/systemd/system/greetd.service.d/palette.conf
sudo install -Dm644 etc/systemd/system/greetd.service.d/tty1.conf /etc/systemd/system/greetd.service.d/tty1.conf
sudo install -Dm644 etc/tmpfiles.d/tuigreet.conf /etc/tmpfiles.d/tuigreet.conf
sudo systemd-tmpfiles --create /etc/tmpfiles.d/tuigreet.conf
sudo systemctl disable sddm.service gdm3.service 2>/dev/null   # whatever display manager was there
sudo systemctl enable greetd.service
```

Reboot. tuigreet starts Hyprland by default; `F3` picks another session, `F12` is power.
The console itself is recolored to the palette (`setvtrgb`, from `kbd`), so tuigreet's ANSI colors match.

Debian's `/etc/pam.d/greetd` doesn't unlock a keyring. If you want GNOME Keyring unlocked at login,
install `libpam-gnome-keyring` and add `auth optional pam_gnome_keyring.so` and
`session optional pam_gnome_keyring.so auto_start` to it.

To go back: `sudo systemctl disable greetd` and re-enable your previous display manager.

## Keys

| Key | Action |
|---|---|
| `Super+Return` / `Super+D` | Ghostty / Fuzzel |
| `Super+F1` / `F2` / `F3` | Yazi / Brave / nvim |
| `Super+F4` / `F5` | YT Music scratchpad / btop scratchpad |
| `Super+←↑→↓`, `+Shift` | Focus, move window |
| `Super+1–4`, `+Shift` | Go to workspace, send window there |
| `Super+Shift+Return` | Swap with master |
| `Super+Tab` / `Shift+Tab` | Next / previous window |
| `Super+Ctrl+←/→` | Shrink / grow master |
| `Super+O` | Master on left ↔ top |
| `Super+Q` / `F` / `Shift+F` | Close / fullscreen / maximize |
| `Super+Shift+Space` | Toggle floating |
| `Super+V` | Clipboard history |
| `Super+L` / `Super+N` | Lock / night light |
| `Super+Escape`, `Ctrl+Alt+Del` | Power menu |
| `Print` / `Shift+Print` | Screenshot region / screen → swappy |
| `Alt+Shift` | Switch keyboard layout (us ↔ tr) |

## Notes

- Scratchpads launch their app on first toggle (`on_created_empty`), then just show and hide it.
- No wallpaper: the background is the palette's solid `#1f1f28` (`misc.background_color`).
  Add `hyprpaper` and a `hyprpaper.conf` later if you want an image.
- Yazi has no theme file. Its default theme uses the terminal's 16 colors, so it follows Ghostty's palette.
