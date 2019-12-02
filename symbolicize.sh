#!/bin/bash

# symbolicize.sh
# Recursively iterate through the dotfiles in `./`; if a corresponding dotfile
# already exists in $HOME, delete it and put a symbolic link to the dotfile
# in `./`. If it doesn't exist in $HOME, ask the user about making a symbolic
# link anyway, creating the required directory structure as necessary.


if [[ $# > 0 ]]; then
	echo "Dry run:";
fi

for item in $(find ./ -type f ! -path './.git/*' ! -path './symbolicize.sh' ! -path './.gitignore'); do
	# Strip the './' from the files found in the current directory
	fname=${item:2};

	# If the file exists in $HOME, then try to replace it with a symbolic link to the
	# corresponding file in ${pwd}
	if [[ -e $HOME/${fname} ]]; then
		echo "${HOME}/${fname}->${pwd}/${fname}";

		# Don't replace if any arguments are passed to the script; this is a dry run
		if [[ $# == 0 ]]; then
			rm ${HOME}/${fname} 2>/dev/null;
			ln -s $(pwd)/${fname} ${HOME}/${fname};
		fi

	# If the file doesn't exist in $HOME, ask the user about making a symbolic link anyway,
	# creating directories as necessary
	else
		read -p "${HOME}/${fname} doesn't exist. Create symbolic link anyway? [Y/n]: " makelink
		if [[ $(echo ${makelink} | awk '{print tolower($0)}') == "y" ]] || [[ $makelink == "" ]]; then
			echo "${HOME}/${fname}->$(pwd)/${fname}";
			if [[ $# == 0 ]]; then
				mkdir -pv $(dirname ${fname});
				ln -s $(pwd)/${fname} ${HOME}/${fname};
			fi
		fi
	fi
done
