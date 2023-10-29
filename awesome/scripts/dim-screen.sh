#!/bin/sh

dim_screen() {
	xrandr --output eDP --brightness 0.5
}

restore_screen() {
	xrandr --output eDP --brightness 1
}

turn_off_screen() {
	restore_screen
	xset dpms force off
}

dim_screen

trap "restore_screen; kill %%; exit 0" HUP
trap "sleep 1; turn_off_screen; kill %%; exit 0" TERM

sleep 2147483647 &
wait
