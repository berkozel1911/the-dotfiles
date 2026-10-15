-- See https://wiki.hypr.land/configuring/core/binds/ and /configuring/core/dispatchers/

local apps    = require("./apps.lua")
local scripts = os.getenv("HOME") .. "/.config/hypr/scripts/"
local mod     = "SUPER"

local function bind(keys, dsp, opts)
    hl.bind(mod .. " + " .. keys, dsp, opts)
end

------------
--- APPS ---
------------

bind("Return", hl.dsp.exec_cmd(apps.terminal), { description = "Terminal" })
bind("D",      hl.dsp.exec_cmd(apps.launcher), { description = "Launcher" })
bind("F1",     hl.dsp.exec_cmd(apps.files),    { description = "Files (yazi)" })
bind("F2",     hl.dsp.exec_cmd(apps.browser),  { description = "Browser" })
bind("F3",     hl.dsp.exec_cmd(apps.editor),   { description = "Editor (nvim)" })

-- Scratchpads
bind("F4", hl.dsp.workspace.toggle_special("music"),   { description = "YouTube Music scratchpad" })
bind("F5", hl.dsp.workspace.toggle_special("monitor"), { description = "btop scratchpad" })

---------------
--- WINDOWS ---
---------------

bind("Q",             hl.dsp.window.close(),                       { description = "Close window" })
bind("F",             hl.dsp.window.fullscreen({ mode = "fullscreen" }), { description = "Fullscreen" })
bind("SHIFT + F",     hl.dsp.window.fullscreen({ mode = "maximized" }),  { description = "Maximize (keep bar and gaps)" })
bind("SHIFT + Space", hl.dsp.window.float(),                       { description = "Toggle floating" })

-- Focus / move with arrows
for _, dir in ipairs({ "left", "right", "up", "down" }) do
    bind(dir,             hl.dsp.focus({ direction = dir }))
    bind("SHIFT + " .. dir, hl.dsp.window.move({ direction = dir }))
end

-- Master layout
bind("SHIFT + Return", hl.dsp.layout("swapwithmaster master"), { description = "Swap with master" })
bind("Tab",            hl.dsp.layout("cyclenext"),             { description = "Next window" })
bind("SHIFT + Tab",    hl.dsp.layout("cycleprev"),             { description = "Previous window" })
bind("CTRL + right",   hl.dsp.layout("mfact +0.05"), { repeating = true, description = "Grow master" })
bind("CTRL + left",    hl.dsp.layout("mfact -0.05"), { repeating = true, description = "Shrink master" })
bind("O",              hl.dsp.layout("orientationcycle left top"), { description = "Master left/top" })

-- Mouse: drag to move, right-drag to resize
bind("mouse:272", hl.dsp.window.drag(),   { mouse = true })
bind("mouse:273", hl.dsp.window.resize(), { mouse = true })

------------------
--- WORKSPACES ---
------------------

for i = 1, 4 do
    bind(tostring(i),              hl.dsp.focus({ workspace = i }))
    bind("SHIFT + " .. i,          hl.dsp.window.move({ workspace = i }))
end

bind("mouse_down", hl.dsp.focus({ workspace = "e+1" }))
bind("mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

---------------
--- UTILITY ---
---------------

bind("V", hl.dsp.exec_cmd("cliphist list | fuzzel --dmenu --prompt 'clip ' | cliphist decode | wl-copy"),
     { description = "Clipboard history" })
bind("L",      hl.dsp.exec_cmd("loginctl lock-session"),     { description = "Lock" })
bind("N",      hl.dsp.exec_cmd(scripts .. "nightlight.sh"),  { description = "Toggle night light" })
bind("Escape", hl.dsp.exec_cmd(scripts .. "powermenu.sh"),   { description = "Power menu" })
hl.bind("CTRL + ALT + Delete", hl.dsp.exec_cmd(scripts .. "powermenu.sh"))

hl.bind("Print",         hl.dsp.exec_cmd(scripts .. "screenshot.sh region"), { description = "Screenshot region" })
hl.bind("SHIFT + Print", hl.dsp.exec_cmd(scripts .. "screenshot.sh full"),   { description = "Screenshot screen" })

-------------
--- MEDIA ---
-------------

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true })

hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
