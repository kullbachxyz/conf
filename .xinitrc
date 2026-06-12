# Source .xprofile to set environment variables
if [ -f "$HOME/.xprofile" ]; then
    . "$HOME/.xprofile"
fi

systemctl --user import-environment DISPLAY XAUTHORITY XDG_CURRENT_DESKTOP XDG_SESSION_DESKTOP XDG_SESSION_TYPE
dbus-update-activation-environment --systemd DISPLAY XAUTHORITY XDG_CURRENT_DESKTOP XDG_SESSION_DESKTOP XDG_SESSION_TYPE

# Monitor setup
INTERNAL="eDP-1"
EXTERNAL="$(xrandr --query | awk '$2 == "connected" && $1 != "eDP-1" { print $1; exit }')"

if [ -n "$EXTERNAL" ]; then
    xrandr \
        --output "$EXTERNAL" --mode 2560x1440 --primary \
        --output "$INTERNAL" --mode 1920x1080 --same-as "$EXTERNAL" --scale-from 2560x1440
else
    xrandr \
        --output "$INTERNAL" --mode 1920x1080 --primary
fi

xwallpaper --zoom ~/pics/wall.png

picom &
dunst &
dwmblocks &

# SSH Agent
eval "$(ssh-agent -s)"
ssh-add "$HOME/.ssh/id_ed25519" </dev/null &

exec dwm
