#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias exa='exa -la --group-directories-first --sort=extension'
alias ex='exa'
alias ll='exa'
alias du='du -h'
alias df='df -h'
alias ip='ip -c'
alias sudo='sudo '
alias paru='paru --color=always --devel'
alias pacman='pacman --color=always'
alias grep='grep --color=always'
alias dmenu='demnu_run -nb "$color0" -nf "$color15" -sb "$color1" -sf "$color15"'
alias vectivate='source vectivate'
alias kmon='kmon -u'
alias rm='trash-put'
alias rg='rg -S'
alias less='less -R'
alias tree='tree -C'
alias trash-empty='trash-empty -f'

export PATH=$HOME/go/bin:$PATH
export PATH=$HOME/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.config/scripts:$PATH
export PATH=$HOME/.local/bin:$PATH

export VISUAL=nvim
export EDITOR=nvim
export FONTCONFIG_PATH=/etc/fonts
export TERM=xterm-kitty
export RANGER_LOAD_DEFAULT_RC=FALSE
export NUMPY_EXPERIMENTAL_DTYPE_API=1

eval "$(ssh-agent)" > /dev/null

ssh() {
    TERM=xterm-256color command ssh $@
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
        local status=$(command git status -uno)
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

get_conda_env() {
    [[ -z "${CONDA_PREFIX}" ]] && echo "" || echo "${bldpur}⟦$(basename ${CONDA_PREFIX})⟧${txtrst}"
}

set_ps1() {
    export PS1="${bldblu}[\w]${txtrst}$(get_conda_env)$(generate_git_ps1)${bldblu}\$${txtrst} "
}

PROMPT_COMMAND=set_ps1

git() {
    if [[ "$#" == 1 && "$1" == "log" ]]; then
        local branch="$(command git rev-parse --abbrev-ref HEAD 2>/dev/null)"
        local default_branch="$(get_git_default_branch)"
        if [[ ! -z "${branch}" ]]; then
            if [[ ${branch} == ${default_branch} ]]; then
                git logg
            else
                git logg ${default_branch}..
            fi
        fi
	else
		command git $@
	fi
}

get_git_default_branch() {
    # Check if there's a default branch name
    branch=$(command git rev-parse --abbrev-ref origin/HEAD)
    if [[ $? == 0 ]]; then
        echo ${branch} | cut -c8-
    else
        # If not, retrieve the new default branch name
        command git remote set-head origin -a
        echo $(command git rev-parse --abbrev-ref origin/HEAD) | cut -c8-
    fi
}

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

cdd() {
    cd ~/Desktop/workspace/$@
}

cds() {
    cd $(python -c "import site; print(site.getsitepackages()[0])")
}

PATH="/home/pdmurray/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/pdmurray/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/pdmurray/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/pdmurray/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/pdmurray/perl5"; export PERL_MM_OPT;

[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion

lutris() {
    PYENV_VERSION=system command lutris $@
}

calibre() {
    PYENV_VERSION=system command calibre $@
}

ebook-convert() {
    PYENV_VERSION=system command ebook-convert $@
}

# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('${HOME}/.pyenv/versions/mambaforge/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "${HOME}/.pyenv/versions/mambaforge/etc/profile.d/conda.sh" ]; then
        . "${HOME}/.pyenv/versions/mambaforge/etc/profile.d/conda.sh"
    else
        export PATH="${HOME}/.pyenv/versions/mambaforge/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "${HOME}/.pyenv/versions/mambaforge/etc/profile.d/mamba.sh" ]; then
    . "${HOME}/.pyenv/versions/mambaforge/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

mamba activate dev
