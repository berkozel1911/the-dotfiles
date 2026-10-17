-- See https://wiki.hypr.land/configuring/core/config-options/

local c = require("colors")

hl.config({
    general = {
        gaps_in     = 4,
        gaps_out    = 8,
        border_size = 2,

        col = {
            active_border   = c.rgb(c.accent),
            inactive_border = c.rgb(c.surface),
        },

        resize_on_border = true,
        layout           = "master",
    },

    decoration = {
        rounding       = 8,
        rounding_power = 2,

        shadow = {
            enabled      = true,
            range        = 6,
            render_power = 3,
            color        = 0xaa111116,
        },

        -- Ghostty is translucent; keep blur cheap
        blur = {
            enabled = true,
            size    = 4,
            passes  = 2,
        },
    },

    animations = {
        enabled = true,
    },

    -- See https://wiki.hypr.land/configuring/layouts/master-layout/
    master = {
        mfact                = 0.55,
        new_status           = "slave",
        new_on_top           = false,
        special_scale_factor = 0.9,
    },

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo   = true,
        disable_splash_rendering = true,
        background_color        = tonumber("0x" .. c.bg),
        focus_on_activate       = true,
    },
})

-- Short and snappy; everything under ~250ms
hl.curve("snap",   { type = "bezier", points = { {0.23, 1},  {0.32, 1} } })
hl.curve("linear", { type = "bezier", points = { {0, 0},     {1, 1}    } })
hl.curve("quick",  { type = "bezier", points = { {0.15, 0},  {0.1, 1}  } })

hl.animation({ leaf = "global",        enabled = true, speed = 6,   bezier = "snap" })
hl.animation({ leaf = "border",        enabled = true, speed = 4,   bezier = "snap" })
hl.animation({ leaf = "windows",       enabled = true, speed = 3.5, bezier = "snap" })
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 3,   bezier = "snap",   style = "popin 90%" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 1.5, bezier = "linear", style = "popin 90%" })
hl.animation({ leaf = "fade",          enabled = true, speed = 2.5, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true, speed = 3,   bezier = "snap",   style = "fade" })
hl.animation({ leaf = "workspaces",    enabled = true, speed = 2.5, bezier = "snap",   style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 2.5, bezier = "snap", style = "slidevert" })
