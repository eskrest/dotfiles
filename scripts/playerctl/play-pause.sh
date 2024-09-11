#!/bin/sh

player=$(playerctl play-pause 2>&1)
if [ -n "$player" ]; then
    kitty -e play
fi
