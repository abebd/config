#!/usr/bin/env bash

dir="$HOME/.config/polybar"
themes=(`ls --hide="launch.sh" $dir`)

launch_bar() {
	# Terminate already running bar instances
	killall -q polybar

	# Wait until the processes have been shut down
	while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

	# Launch the bar
	if type "xrandr"; then
	  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
		MONITOR=$m polybar -q main -c "$dir/$style/config.ini" &	
	  done
	else
	  polybar --reload main &
	fi
    #if [[ "$style" == "my-first-polybar" ]]; then
    #    polybar -q main -c "$dir/$style/config.ini" &	
    #fi
}

if [[ "$1" == "--my-first-polybar" ]]; then
	style="my-first-polybar"
	launch_bar
else
	cat <<- EOF
	Usage : launch.sh --theme
		
	Available Themes :
        --my-first-polybar
	EOF
fi
