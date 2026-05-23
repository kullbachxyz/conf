# Source .profile to set environment variables
if [ -f "$HOME/.xprofile" ]; then
    . "$HOME/.xprofile"
fi

systemctl --user import-environment DISPLAY XAUTHORITY XDG_CURRENT_DESKTOP XDG_SESSION_DESKTOP XDG_SESSION_TYPE
dbus-update-activation-environment --systemd DISPLAY XAUTHORITY XDG_CURRENT_DESKTOP XDG_SESSION_DESKTOP XDG_SESSION_TYPE

# SSH Agent (x11-ssh-askpass needs to be installed!)
eval "$(ssh-agent -s)"
ssh-add "$HOME/.ssh/id_ed25519" </dev/null

dunst &
dwmblocks &

exec dwm;
