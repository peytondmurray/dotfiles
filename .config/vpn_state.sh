#!/bin/bash

status=$(timeout -s 2 -k 3 3 sudo protonvpn s)
if
ip=$(echo "${status}" | grep 'IP' | awk '{print $2}')

if [[ $(echo ${status} | grep 'Status' | awk '{print $2}') == 'Connected' ]]; then
    echo " ${ip}"
else
    echo " ${ip}"
fi
