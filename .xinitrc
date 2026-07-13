# Load environment variables (.bashrc is not sourced in X sessions)
if [ -f "$HOME/.xprofile" ]; then
    . "$HOME/.xprofile"
fi

# Get displays
INTERNAL="eDP-1"
EXTERNAL="$(xrandr --query | awk '$2 == "connected" && $1 != "eDP-1" { print $1; exit }')"

# Mirror internal display onto external monitor, scaling to match its resolution
# if [ -n "$EXTERNAL" ]; then
#     xrandr \
#         --output "$EXTERNAL" --mode 2560x1440 --primary \
#         --output "$INTERNAL" --mode 1920x1080 --same-as "$EXTERNAL" --scale-from 2560x1440
# else
#     xrandr \
#         --output "$INTERNAL" --mode 1920x1080 --primary
# fi

# Extend external monitor normally and place it above the internal display
if [ -n "$EXTERNAL" ]; then
    xrandr \
        --output "$EXTERNAL" --mode 2560x1440 --primary \
        --output "$INTERNAL" --mode 1920x1080 --transform none --below "$EXTERNAL"
else
    xrandr \
        --output "$INTERNAL" --mode 1920x1080 --primary
fi

# Set a normal cursor for the root window / bar (avoids the huge X core cursor)
xsetroot -cursor_name left_ptr

# Export X session vars into the D-Bus/systemd --user environment so
# xdg-desktop-portal-gtk can open the display (needed for save/download dialogs)
dbus-update-activation-environment --systemd DISPLAY XAUTHORITY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE

# Autostart
setbg &
picom &
unclutter &
dunst &
keepassxc &
nextcloud --background &
dwmblocks &
redshift -l 51:7 &

exec dwm
