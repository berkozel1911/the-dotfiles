# Hyprland setup (Fedora 44)

Hyprland 0.56 · Lua config · master-stack · Waybar · uwsm session.
Palette: Kanagawa base (`#1f1f28`) + Ayu bright foregrounds, cyan accent (`#95e6cb`).

## 1. Packages

```bash
sudo dnf copr enable sdegler/hyprland        # hyprland 0.56, hypr* tools, uwsm, satty
sudo dnf copr enable scottames/ghostty
sudo dnf copr enable lihaohong/yazi

sudo dnf install \
  hyprland hyprlock hypridle hyprsunset hyprpolkitagent hyprshutdown \
  xdg-desktop-portal-hyprland xdg-desktop-portal-gtk uwsm \
  waybar fuzzel mako cliphist wl-clipboard grim slurp satty \
  ghostty yazi btop mpv imv zathura zathura-pdf-mupdf \
  playerctl jq

flatpak install flathub com.saivert.pwvucontrol
```

Font: JetBrainsMono Nerd Font is used everywhere (bar, launcher, lock screen, terminal).
Fedora only ships plain JetBrains Mono, so grab the Nerd Font from
<https://github.com/ryanoasis/nerd-fonts/releases> into `~/.local/share/fonts` and run `fc-cache -f`.

## 2. Link configs

```bash
cd ~/Documents/devops/repo/the-dotfiles
for d in hypr waybar fuzzel mako ghostty zathura imv uwsm nvim; do
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

## 4. Log in

Pick **Hyprland (uwsm-managed)** in SDDM.

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
| `Print` / `Shift+Print` | Screenshot region / screen → satty |
| `Alt+Shift` | Switch keyboard layout (us ↔ tr) |

## Notes

- Scratchpads launch their app on first toggle (`on_created_empty`), then just show and hide it.
- No wallpaper: the background is the palette's solid `#1f1f28` (`misc.background_color`).
  Add `hyprpaper` and a `hyprpaper.conf` later if you want an image.
- Yazi has no theme file. Its default theme uses the terminal's 16 colors, so it follows Ghostty's palette.
