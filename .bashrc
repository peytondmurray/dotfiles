#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Import colors from wal
${HOME}/.cache/wal/colors.sh

python () { /home/pdmurray/python38/bin/python3 $@; }
pip () { /home/pdmurray/python38/bin/pip3 $@; }
alias ll='ls -lAshvX --group-directories-first --color=auto'
alias du='du -h'
alias df='df -h'
alias sudo='sudo '
alias yay='yay --color=auto'
alias pacman='pacman --color=auto'
alias grep='grep --color=auto'
alias dmen='demnu_run -nb "$color0" -nf "$color15" -sb "$color1" -sf "$color15"'
alias vectivate='source vectivate'

export PATH=/home/pdmurray/python37/bin:$PATH
export PATH=/home/pdmurray/python38/bin:$PATH
export PATH=/home/pdmurray/.gem/ruby/2.6.0/bin:$PATH
export PATH=/home/pdmurray/go/bin:$PATH
export PATH=/home/pdmurray/.local/bin:$PATH
export PATH=/home/pdmurray/bin:$PATH

export LD_LIBRARY_PATH=/home/pdmurray/python38/lib:$LD_LIBRARY_PATH

export VISUAL=micro
export EDITOR=micro
export FONTCONFIG_PATH=/etc/fonts
export TERM=xterm


### Colors ###

# Regular
txtblk="\[\e[0;30m\]"  # Black
txtred="\[\e[0;31m\]"  # Red
txtgrn="\[\e[0;32m\]"  # Green
txtylw="\[\e[0;33m\]"  # Yellow
txtblu="\[\e[0;34m\]"  # Blue
txtpur="\[\e[0;35m\]"  # Purple
txtcyn="\[\e[0;36m\]"  # Cyan
txtwht="\[\e[0;37m\]"  # White

# Bold
bldblk="\[\e[1;30m\]"  # Black
bldred="\[\e[1;31m\]"  # Red
bldgrn="\[\e[1;32m\]"  # Green
bldylw="\[\e[1;33m\]"  # Yellow
bldblu="\[\e[1;34m\]"  # Blue
bldpur="\[\e[1;35m\]"  # Purple
bldcyn="\[\e[1;36m\]"  # Cyan
bldwht="\[\e[1;37m\]"  # White

# Underline
undblk="\[\e[4;30m\]"  # Black
undred="\[\e[4;31m\]"  # Red
undgrn="\[\e[4;32m\]"  # Green
undylw="\[\e[4;33m\]"  # Yellow
undblu="\[\e[4;34m\]"  # Blue
undpur="\[\e[4;35m\]"  # Purple
undcyn="\[\e[4;36m\]"  # Cyan
undwht="\[\e[4;37m\]"  # White

# Background
bakblk="\[\e[40m\]"  # Black
bakred="\[\e[41m\]"  # Red
bakgrn="\[\e[42m\]"  # Green
bakylw="\[\e[43m\]"  # Yellow
bakblu="\[\e[44m\]"  # Blue
bakpur="\[\e[45m\]"  # Purple
bakcyn="\[\e[46m\]"  # Cyan
bakwht="\[\e[47m\]"  # White

# Others
bakylwtxtblk="\[\e[30;43m\]"
bakblktxtylw="\[\e[33;40m\]"

# Reset
# txtrst="$(tput sgr 0 2>/dev/null || echo '\e[0m')"  # Text Reset
txtrst="\[\e[0m\]"


get_git_branch() {
	local branch
	if branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null); then
		if [[ "$branch" == "HEAD" ]]; then
			branch='detached'
		fi
		echo "[${branch}]"
	else
		echo ""
	fi
}

get_git_color() {
	$(command git branch > /dev/null 2>&1)
	if [[ "$?" == 0 ]]; then
		local status=`command git status`
		if [[ "$(echo $status | grep 'not staged for commit' | wc -l)" == 1 ]] || [[ "$(echo $status | grep 'Untracked files:' | wc -l)" == 1 ]]; then
			echo ${bldred};
		elif [[ "$(echo $status | grep 'Changes to be committed: ' | wc -l)" == 1 ]]; then
			echo ${bldylw};
		elif [[ "$(echo $status | grep 'Your branch is ahead of' | wc -l)" == 1 ]]; then
			echo ${bldblu};
		elif [[ "$(echo $status | grep 'nothing to commit' | wc -l)" == 1 ]]; then
			echo ${bldcyn};
		else
			echo ${bldwht}
		fi
	else
		echo "";
	fi
}

generate_git_ps1() {
	# Exclude the directory which lives at $HOME; this is just my dotfiles repo,
	# and I don't want it cluttering up PS1 all the time
	if [[ "$(git rev-parse --show-toplevel 2>/dev/null)" != "$HOME" ]]; then
		echo "$(get_git_color)$(get_git_branch)${txtrst}";
	else
		echo "";
	fi
}

get_venv() {
	echo "${bakblktxtylw}$(echo ${VIRTUAL_ENV} | awk -F'/' '{print $NF}')${txtrst}"
}

set_ps1() {
	export PS1="[\u@\h ${bldwht}\w${txtrst}]$(get_venv)$(generate_git_ps1)$ "
}


PROMPT_COMMAND=set_ps1
