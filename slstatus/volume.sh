if [ $(amixer get Master | awk '$0~/%/{print $6}') == "[off]" ]; then
	echo "[MUTED]"
else
	echo $(amixer get Master | awk '$0~/%/{print $4}')
fi
