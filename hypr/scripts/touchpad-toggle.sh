#!/usr/bin/env bash

export ENABLE_TOUCHPAD="$XDG_RUNTIME_DIR/enable.touchpad"

enable_touchpad() {
	printf "true" >"$ENABLE_TOUCHPAD"
	notify-send -u normal "Enabling Tuchpad"
	hyprctl keyword '$ENABLE_TOUCHPAD' "true" -r
}

disable_touchpad() {
	printf "false" >"$ENABLE_TOUCHPAD"
	notify-send -u normal "Disabling Tuchpad"
	hyprctl keyword '$ENABLE_TOUCHPAD' "false" -r
}

if ! [ -f "$ENABLE_TOUCHPAD" ]; then
	enable_touchpad
else
	if [ $(cat "$ENABLE_TOUCHPAD") = "true" ]; then
		disable_touchpad
	elif [ $(cat "$ENABLE_TOUCHPAD") = "false" ]; then
		enable_touchpad
	fi
fi
