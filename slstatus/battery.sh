#!/bin/bash

BATC=$(cat /sys/class/power_supply/BAT1/capacity)
BATS=$(cat /sys/class/power_supply/BAT1/status)
if [ "$BATS" = "Charging" ]; then
		echo "+ $BATC%"
else
		case "$BATC" in
		1??|9?) echo "- $BATC%"

				;;
		100|[7-8]?) echo "- $BATC%"

				;;

		[4-6]?) echo "-- $BATC%"

				;;
		*) echo "--- $BATC%"

				;;
		esac
fi
