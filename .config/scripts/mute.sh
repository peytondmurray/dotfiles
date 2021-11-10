#!/bin/bash

for SINK in `pamixer --list-sinks | sed '1d' | awk '{print $1}'`
do
    pamixer --sink ${SINK} -t
done
