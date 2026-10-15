-- Long-running daemons (waybar, mako, hypridle, hyprsunset, hyprpolkitagent) are systemd
-- user services enabled once with `systemctl --user enable`, see INSTALL.md.
-- Only things without a unit are started here.

hl.on("hyprland.start", function()
    hl.exec_cmd("uwsm app -- wl-paste --type text  --watch cliphist store")
    hl.exec_cmd("uwsm app -- wl-paste --type image --watch cliphist store")
end)
