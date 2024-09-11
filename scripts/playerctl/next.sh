#!/bin/sh

player=$(playerctl next 2>&1)
if [ -n "$player" ]; then
    kitty -e play
fi
