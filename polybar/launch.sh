#!/usr/bin/env bash

# Polybar check displays
#if type "xrandr"; then
#	for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
#			MONITOR=$m polybar --reload example &
#			done
#		else
#				polybar --reload example &
#fi

# Polybar on both displays
#DISPLAY1="$(xrandr -q | grep 'eDP1\|VGA-1' | cut -d ' ' -f1)"
#[[ ! -z "$DISPLAY1"  ]] && MONITOR="$DISPLAY1" polybar top && polybar bottom &

#DISPLAY2="$(xrandr -q | grep 'HDMI1\|DVI-I-1' | cut -d ' ' -f1)"
#[[ ! -z $DISPLAY2  ]] && MONITOR=$DISPLAY2 polybar top2 && polybar bottom2 &

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch top and bottom bar
polybar top2 &
polybar bottom2 &
polybar top &
polybar bottom

