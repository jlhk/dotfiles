#!/bin/bash

# must be set for battery case statement
shopt -s extglob

becho() {
	echo -n " [ $1 ] "
}

bstatus() {
	# VOLUME
	if amixer get Master | grep -Fq off; then
		becho "MUTED"
	else
		becho "VOL $(amixer get Master | awk '$0~/%/{print $5;exit}' | tr -d '[]')"
	fi

	# BATTERY
	if [ -f /sys/class/power_supply/BAT0/capacity ]; then
		bat="BAT"

		if grep -Fq "Charging" /sys/class/power_supply/BAT0/status; then
			bat+="+"
		fi

		for b in /sys/class/power_supply/BAT?/capacity; do
			case "$(cat $b 2>/dev/null)" in
				(+([0-9]))	bat+=" $(cat $b%)"	;;
			esac
		done
		becho "$bat"
	fi

	# DATE
	becho "$(date +"%a %F • %R")"
}

main() {
	while true; do
		xsetroot -name "$(bstatus)      " &
		sleep 1
		wait
	done
}
main
