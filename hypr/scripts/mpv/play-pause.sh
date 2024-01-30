#!/bin/sh
paused=$(echo '{ "command": ["get_property", "pause"] }' | socat - /tmp/mpvsocket | jq -r .data)

if $paused == true
then
	~/.config/hypr/scripts/mpv/play.sh
else
	~/.config/hypr/scripts/mpv/pause.sh
fi
