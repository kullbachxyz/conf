# Source .profile to set environment variables
if [ -f "$HOME/.xprofile" ]; then
    . "$HOME/.xprofile"
fi

dunst &
dwmbar &

exec dwm;
