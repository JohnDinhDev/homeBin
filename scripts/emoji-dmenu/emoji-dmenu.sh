#! /bin/bash
# Give dmenu list of all unicode characters to copy.
# Shows the selected character in dunst if running

grep -v "#" $HOME/bin/emojiMap | dmenu -i -l 20 -fn Monospace-18 | awk '{print $1}' | tr -d '\n' | xclip -selection clipboard

pgrep -x dunst >/dev/null && notify-send "$(xclip -o -selection clipboard) copied to clipboard."
