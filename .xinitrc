# Load environment variables (.bashrc is not sourced in X sessions)
if [ -f "$HOME/.xprofile" ]; then
    . "$HOME/.xprofile"
fi

# Expose X session vars to systemd user units and D-Bus activated services
systemctl --user import-environment DISPLAY XAUTHORITY XDG_CURRENT_DESKTOP XDG_SESSION_DESKTOP XDG_SESSION_TYPE SSH_AUTH_SOCK SSH_AGENT_PID
dbus-update-activation-environment --systemd DISPLAY XAUTHORITY XDG_CURRENT_DESKTOP XDG_SESSION_DESKTOP XDG_SESSION_TYPE SSH_AUTH_SOCK SSH_AGENT_PID

# Mirror internal display onto external monitor, scaling to match its resolution
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

setbg &       # wallpaper
remaps &      # keyboard remaps
picom &       # compositor
unclutter &   # hide idle cursor
dunst &       # notifications
dwmblocks &   # status bar

exec dwm
