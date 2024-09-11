#!/bin/sh
paused=$(echo '{ "command": ["get_property", "pause"] }' | socat - /tmp/mpvsocket | jq -r .data)

if $paused == true
then
	~/.config/scripts/mpv/play.sh
else
	~/.config/scripts/mpv/pause.sh
fi
