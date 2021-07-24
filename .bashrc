#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias exa='exa -la --group-directories-first'
alias ex='exa'
alias ll='exa'
alias du='du -h'
alias df='df -h'
alias ip='ip -c'
alias sudo='sudo '
alias paru='paru --color=always --sudoloop'
alias pacman='pacman --color=always'
alias grep='grep --color=always'
alias dmenu='demnu_run -nb "$color0" -nf "$color15" -sb "$color1" -sf "$color15"'
alias vectivate='source vectivate'
alias kmon='kmon -u'
alias rm='trash-put'
alias rg='rg -S'
alias aesvpn='openconnect vpn.aes.com/scc002 --servercert pin-sha256:8FytlQi7EjBIbvTDVyCnhcBY4Or3YlXP1VaImo5asOI= --user=qs.pmurray.c -v --reconnect-timeout=100 -s "`which vpn-slice` 10.247.11.22 qhub.ouraes.com"'
alias less='less -R'

export PATH=/home/pdmurray/.gem/ruby/2.7.0/bin:$PATH
export PATH=/home/pdmurray/go/bin:$PATH
export PATH=/home/pdmurray/.local/bin:$PATH
export PATH=/home/pdmurray/bin:$PATH
export PATH=/home/pdmurray/.cargo/bin:$PATH
export PATH=/home/pdmurray/.config/scripts:$PATH

export VISUAL=nvim
export EDITOR=nvim
export FONTCONFIG_PATH=/etc/fonts
export TERM=xterm-kitty
export RANGER_LOAD_DEFAULT_RC=FALSE

eval "$(ssh-agent)" > /dev/null

ssh() {
    TERM=xterm-256color command ssh $@
}

colors() {
    awk 'BEGIN{
        s="/\\/\\/\\/\\/\\"; s=s s s s s s s s;
        for (colnum = 0; colnum<77; colnum++) {
            r = 255-(colnum*255/76);
            g = (colnum*510/76);
            b = (colnum*255/76);
            if (g>255) g = 510-g;
            printf "\033[48;2;%d;%d;%dm", r,g,b;
            printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
            printf "%s\033[0m", substr(s,colnum+1,1);
        }
        printf "\n";
    }'
}

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
txtrst="\[\e[0m\]"


get_git_branch() {
	local branch
	if branch=$(command git rev-parse --abbrev-ref HEAD 2>/dev/null); then
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
	if [[ "$(command git rev-parse --show-toplevel 2>/dev/null)" != "$HOME" ]]; then
		echo "$(get_git_color)$(get_git_branch)${txtrst}";
	else
		echo "";
	fi
}

get_venv() {
    [[ -z "${VIRTUAL_ENV}" ]] && echo "" || echo "${bakblktxtylw}[$(echo ${VIRTUAL_ENV} | awk -F'/' '{print $NF}')]${txtrst}"
}

set_ps1() {
	export PS1="[\u@\h ${bldwht}\w${txtrst}]$(get_venv)$(generate_git_ps1)$ "
}

PROMPT_COMMAND=set_ps1

git() {
	if [[ "$#" == 1 && "$1" == "log" && "$(git rev-parse --abbrev-ref HEAD)" != "master" ]]; then
		command git log master.. -n 20 --pretty="%C(Yellow)%h %C(reset)%ad %C(Green)%<(12,trunc) %cr %C(reset) %<(20,trunc)%C(Cyan)%an %C(reset)%s" --date=short --no-merges
	elif [[ "$1" == "log" && "$(git rev-parse --abbrev-ref HEAD)" == "master" ]]; then
		command git log -n 20 --pretty="%C(Yellow)%h %C(reset)%ad %C(Green)%<(12,trunc) %cr %C(reset) %<(20,trunc)%C(Cyan)%an %C(reset)%s" --date=short --no-merges
	else
		command git $@
	fi
}

pipupdate() {
    local outdated=$(pip list --outdated)
    if [[ -z "${outdated/ //}" ]]; then
        echo "All packages up to date."
    else
	    pip install -U $(echo "${outdated}" | tail -n +3 | awk '{print $1}' | awk 'ORS=" "')
    fi
}

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Lazily load nvm, otherwise bash startup takes much longer
nvm() {
    unset -f nvm
    source /usr/share/nvm/init-nvm.sh
    nvm "$@"
}

node() {
    unset -f node
    source /usr/share/nvm/init-nvm.sh
    node "$@"
}

npm() {
    unset -f npm
    source /usr/share/nvm/init-nvm.sh
    npm "$@"
}
PATH="/home/pdmurray/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/pdmurray/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/pdmurray/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/pdmurray/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/pdmurray/perl5"; export PERL_MM_OPT;

[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion

# Load pyenv automatically
eval "$(pyenv init -)"

# move all paths ending in 'sbin' to the back of PATH
# This is needed because pyenv fails to find the system python otherwise
for SB in $(echo "$PATH" | grep ':*/[^:]*sbin' -o)
do
  export PATH="${PATH/$SB}:${SB#:}"
done

alias luamake=/home/pdmurray/.config/nvim/lua-language-server/3rd/luamake/luamake
