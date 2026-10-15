-- Programs. Everything is started through `uwsm app --` so each app runs in its own systemd scope.

local run = "uwsm app -- "

return {
    terminal = run .. "ghostty",
    files    = run .. "ghostty -e yazi",
    browser  = run .. "brave-browser",
    editor   = run .. "ghostty -e nvim",
    launcher = "pkill -x fuzzel || " .. run .. "fuzzel",
    mixer    = run .. "flatpak run com.saivert.pwvucontrol",

    -- Scratchpads
    music  = run .. "brave-browser --app=https://music.youtube.com",
    sysmon = run .. "ghostty --class=scratch.btop -e btop",
}
