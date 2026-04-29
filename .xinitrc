# Source .profile to set environment variables
if [ -f "$HOME/.xprofile" ]; then
    . "$HOME/.xprofile"
fi

systemctl --user import-environment DISPLAY XAUTHORITY XDG_CURRENT_DESKTOP XDG_SESSION_DESKTOP XDG_SESSION_TYPE
dbus-update-activation-environment --systemd DISPLAY XAUTHORITY XDG_CURRENT_DESKTOP XDG_SESSION_DESKTOP XDG_SESSION_TYPE

dunst &
dwmblocks &

exec dwm;
