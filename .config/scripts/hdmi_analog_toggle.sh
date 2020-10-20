#!/bin/bash

sinks=$(pactl list short sinks | awk '{print $1 " " $2}')
sink_inputs=$(pactl list short sink-inputs | awk '{print $1}')

if $(echo "$sinks" | grep -q "analog"); then
    target=$(echo "$sinks" | grep "analog" | awk '{print $1}')
else
    target=$(echo "$sinks" | grep "hdmi" | awk '{print $1}')
fi

while IFS= read -r input; do
    pactl move-sink-input "$input" "$target"
done <<< "$sink_inputs"
