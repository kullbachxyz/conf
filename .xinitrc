# Source .profile to set environment variables
if [ -f "$HOME/.xprofile" ]; then
    . "$HOME/.xprofile"
fi

dunst &
dwmblocks &

exec dwm;
