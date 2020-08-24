#!/bin/bash

# symbolicize.sh
# Iterate through the top level in `./`; if a corresponding item already exists
# in $HOME, delete it and put a symbolic link to the corresponding item in `./`.
# If it doesn't exist, make a symbolic link, creating required directories
# as necessary.

# Ignore any lines that start with `#` or only have blank space in them.
# Store the rest for later.
ignores=$(sed '/^#/d; /^\s*$/d' ./symbolicize.conf)



DRY=0
CONFIG=''
for var in "$@"; do
    if [[ $var == '-d' ]]; then
        DRY=1
    else
        CONFIG="$var"
    fi
done

special_targets=$(jq -r ".${CONFIG} | keys | @sh" ./swapconfig.json)

for item in $(find ./ -type f,l | grep -Fv "${ignores}"); do

    # If the item is not in the ignore list, make a link
    if [[ ${ignores} != *"${item}"* ]]; then

        linkpath=${HOME}/${item}
        targetpath=$(pwd)/${item}

        if [[ "${DRY}" == 0 ]]; then
            rm -rfv ${linkpath}
            mkdir -pv $(dirname ${linkpath});
            ln -sfv ${targetpath} ${linkpath};
        else
		    echo "${linkpath}->${targetpath}";
        fi
    fi
done
