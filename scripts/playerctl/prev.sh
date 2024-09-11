#!/bin/sh

player=$(playerctl previous 2>&1)
if [ -n "$player" ]; then
    kitty -e play
fi
