#!/bin/sh

export $TERMINAL=st

mpd &
dunst &
xcompmgr &
xwallpaper --zoom ~/.local/share/walls/wall &

# Export GUI env to user systemd/DBus so keybinding-launched apps see it.
systemctl --user import-environment DISPLAY XAUTHORITY XDG_RUNTIME_DIR
dbus-update-activation-environment --systemd DISPLAY XAUTHORITY XDG_RUNTIME_DIR

dwmblocks &
exec dwm
