#/bin/bash

for SINK in `pamixer --list-sinks | sed '1d' | awk '{print $1}'`
do
    if [[ ${1::1} == '+' ]]; then
	    pamixer --sink ${SINK} -i ${1:1:-1}
    else
	    pamixer --sink ${SINK} -d ${1:1:-1}
    fi
done
