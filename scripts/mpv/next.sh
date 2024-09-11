#!/bin/sh
echo '{ "command": ["playlist-next"] }' | socat - /tmp/mpvsocket
