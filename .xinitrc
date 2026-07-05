# Load environment variables (.bashrc is not sourced in X sessions)
if [ -f "$HOME/.xprofile" ]; then
    . "$HOME/.xprofile"
fi

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

exec i3
