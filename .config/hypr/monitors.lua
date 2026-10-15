-- See https://wiki.hypr.land/configuring/core/monitors/

hl.monitor({
    output   = "DP-2",
    mode     = "2560x1440@165",
    position = "0x0",
    scale    = 1,
})

-- Fallback for anything else that gets plugged in
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})
