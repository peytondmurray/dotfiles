#!/bin/bash

status=$(sudo protonvpn s)
if [[ $(echo ${status} | head -1) == 'Connected' ]]; then
    sudo protonvpn d >/dev/null 2>&1
else
    sudo protonvpn c -f >/dev/null 2>&1
fi
