#!/bin/sh

[ -f "$HOME/.xprofile" ] && . "$HOME/.xprofile"

# Start keyring early so env vars exist for systemd user / dbus activation
# eval "$(/usr/bin/gnome-keyring-daemon --start --components=secrets)"
# export SSH_AUTH_SOCK

mpd &
dunst &
xcompmgr &
xwallpaper --zoom "$HOME/.local/share/walls/wall" &

# Export GUI env to user systemd/DBus so keybinding-launched apps see it.
# systemctl --user import-environment DISPLAY XAUTHORITY XDG_RUNTIME_DIR SSH_AUTH_SOCK
# dbus-update-activation-environment --systemd DISPLAY XAUTHORITY XDG_RUNTIME_DIR SSH_AUTH_SOCK

dwmblocks &
exec dwm

