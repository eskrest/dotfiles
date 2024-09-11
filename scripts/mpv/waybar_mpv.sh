#!/bin/sh
# echo '{ "command": ["get_property", "metadata"] }' | socat - /tmp/mpvsocket | jq .data | jq .artist
metadata=$(echo '{ "command": ["get_property", "metadata"] }' | socat - /tmp/mpvsocket | jq .data)
pause_icon=""
pause=$(echo '{ "command": ["get_property", "pause"] }' | socat - /tmp/mpvsocket | jq .data)
if [ "$pause" = "true" ]; then
    pause_icon=""
fi
artist=$(echo $metadata | jq .artist | tr -d '"')
title=$(echo $metadata | jq .title | tr -d '"')
# echo "$artist - $title"
# echo "$title"
# {"text": "$text", "tooltip": "$tooltip", "class": "$class", "percentage": $percentage }
if [ -z "$title$artist" ]; then
    echo '{ "text": "" }'
else
    echo '{ "text": "'"$pause_icon $title - $artist"'" }'
fi
