#!/bin/sh

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Basic settings
xset s off -dpms
xrandr --output DVI-D-0 --mode 1920x1080 --rate 144
xrandr --output HDMI-0 --left-of DVI-D-0 --rate 75
xinput set-prop 8 153 1.00000, 0.000000, 0.000000, 0.000000, 1.00000, 0.000000, 0.000000, 0.000000, 1.000000

# Background
feh --bg-fill /home/jl/Pictures/wallpapers/citylights.jpg

# Load nvidia settings
nvidia-settings -l


# Autostart programs
firefox &
spotify &
st -e sh -c 'cat TODO; bash' &
# Start tmux with neomutt and irssi
st -e sh -c 'tmux new-session -d -s "std" && tmux rename-window -t 0 "MAIL" && tmux send -t std.0 neomutt ENTER && tmux new-window -n IRC irssi && tmux a' &
# Statusbar
/path/to/bar.sh &

# Window Manager
exec dwm
