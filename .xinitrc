# Source .profile to set environment variables
if [ -f "$HOME/.xprofile" ]; then
    . "$HOME/.xprofile"
fi

dwmbar &

exec dwm;
