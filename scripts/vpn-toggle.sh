#!/usr/bin/env bash

pid=$(pgrep openvpn)
echo $pid
if [ -z "$pid" ]; then
    pkexec vpn
else
    pkexec killall -9 openvpn
fi
