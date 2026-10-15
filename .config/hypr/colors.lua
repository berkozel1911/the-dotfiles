-- Palette: Kanagawa base + Ayu bright foregrounds, cyan accent.
-- Same hex values are mirrored in waybar/colors.css, fuzzel, mako, ghostty and yazi.

local c = {
    bg      = "1f1f28",
    surface = "2a2a37",
    fg      = "dcd7ba",
    muted   = "727169",

    red     = "f28779",
    green   = "d5ff80",
    yellow  = "ffcc66",
    blue    = "73d0ff",
    magenta = "dfbfff",
    cyan    = "95e6cb",
}

c.accent = c.cyan

-- rgb(...) / rgba(...) helpers for Hyprland color values
function c.rgb(hex) return "rgb(" .. hex .. ")" end
function c.rgba(hex, alpha) return "rgba(" .. hex .. alpha .. ")" end

return c
