#!/bin/sh
echo '{ "command": ["playlist-prev"] }' | socat - /tmp/mpvsocket
