-- See https://wiki.hypr.land/configuring/core/rules/

local apps = require("apps")

------------------
--- WORKSPACES ---
------------------

-- Four regular workspaces, always shown in the bar
for i = 1, 4 do
    hl.workspace_rule({ workspace = tostring(i), monitor = "DP-2", persistent = true, default = (i == 1) })
end

-- Scratchpads: first toggle launches the app, later toggles just show/hide it
hl.workspace_rule({ workspace = "special:music",   on_created_empty = apps.music })
hl.workspace_rule({ workspace = "special:monitor", on_created_empty = apps.sysmon })

---------------
--- WINDOWS ---
---------------

-- Keep scratchpad apps in their scratchpad even if launched another way
hl.window_rule({
    name      = "scratch-music",
    match     = { class = "^brave-music\\.youtube\\.com.*" },
    workspace = "special:music silent",
})

hl.window_rule({
    name      = "scratch-monitor",
    match     = { class = "^scratch\\.btop$" },
    workspace = "special:monitor silent",
})

-- Small floating utilities
hl.window_rule({
    name   = "float-utilities",
    match  = { class = "^(org\\.pulseaudio\\.pavucontrol|blueman-manager|nm-connection-editor|swappy)$" },
    float  = true,
    size   = { "monitor_w * 0.45", "monitor_h * 0.55" },
    center = true,
})

-- File pickers and other dialogs
hl.window_rule({
    name   = "float-dialogs",
    match  = { title = "^(Open File|Save File|Save As|Open Folder|File Upload|Select a File|Choose Files?).*" },
    float  = true,
    center = true,
})

hl.window_rule({
    name   = "float-portal",
    match  = { class = "^xdg-desktop-portal-gtk$" },
    float  = true,
    center = true,
})

-- Picture-in-picture video stays on top in the corner
hl.window_rule({
    name  = "pip",
    match = { title = "^Picture.in.[Pp]icture$" },
    float = true,
    pin   = true,
    size  = { "monitor_w * 0.25", "monitor_h * 0.25" },
    move  = { "monitor_w - window_w - 16", "monitor_h - window_h - 16" },
    keep_aspect_ratio = true,
})

-- Don't let video players or games go idle
hl.window_rule({
    name         = "idle-fullscreen",
    match        = { class = ".*" },
    idle_inhibit = "fullscreen",
})

-- Ignore maximize requests; the layout decides
hl.window_rule({
    name           = "suppress-maximize",
    match          = { class = ".*" },
    suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
    name  = "fix-xwayland-drags",
    match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
    no_focus = true,
})
