#!/bin/bash

xrandr_args=""

for output in $(xrandr | grep 'connected' | awk '{print $1}'); do
    xrandr_args+="--output ${output} "
    if [[ "${output}" == 'eDP1' ]]; then
        xrandr_args+="--primary --mode 1920x1080 --pos 0x0 --rotate normal "
    else
        xrandr_args+="--off "
    fi
done

xrandr ${xrandr_args}
