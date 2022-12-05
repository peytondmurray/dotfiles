#!/bin/bash

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
export PATH=/usr/lib/emscripten:$PATH

export VISUAL=nvim
export EDITOR=nvim
export FONTCONFIG_PATH=/etc/fonts
export TERM=xterm-kitty
export RANGER_LOAD_DEFAULT_RC=FALSE
export NUMPY_EXPERIMENTAL_DTYPE_API=1

eval "$(luarocks path)"

export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

eval "$(ssh-agent)" > /dev/null

ssh() {
    TERM=xterm-256color command ssh "$@"
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


get_git_branch_ps1() {
    local branch=$(get_git_current_branch)
    if [[ -z ${branch} ]]; then
        echo ""
    else
		echo "[${branch}]"
    fi
}

get_git_color() {
	if command git branch > /dev/null 2>&1; then
        local status=$(command git status -uno)
        if grep -q 'not staged for commit' <<< "$status" || grep -q 'Untracked files:' <<< "$status"; then
            echo "${bldred}"
        elif grep -q 'Changes to be committed:' <<< "$status"; then
			echo "${bldylw}"
        elif grep -q 'Your branch is ahead of' <<< "$status"; then
			echo "${bldblu}"
        elif grep -q 'nothing to commit' <<< "$status"; then
			echo "${bldcyn}"
		else
			echo "${bldwht}"
		fi
	else
		echo "";
	fi
}

generate_git_ps1() {
	echo "$(get_git_color)$(get_git_branch_ps1)${txtrst}";
}

get_venv() {
    PYENV_NAME=$(pyenv version-name)
    if [[ "${PYENV_NAME}" == "system" ]]; then
        echo ""
    else
        if [[ $(pyenv version-file) != ${HOME}/.pyenv/version ]]; then
            echo "${bldpur}⟦${PYENV_NAME}⟧${txtrst}"
        fi
    fi
}

set_ps1() {
    # shellcheck disable=SC2155
    export PS1="${bldblu}[\w]${txtrst}$(get_venv)$(generate_git_ps1)${bldblu}\$${txtrst} "
}

PROMPT_COMMAND=set_ps1

git() {
    if [[ "$#" == 1 && "$1" == "log" ]]; then
        local branch="$(get_git_current_branch)"
        local default_branch="$(get_git_default_branch)"
        if [[ -n "${branch}" ]]; then
            if [[ ${branch} == "${default_branch}" ]]; then
                git logg
            else
                git logg "${default_branch}.."
            fi
        fi
	else
		command git "$@"
	fi
}

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

cdd() {
    cd "${HOME}/Desktop/workspace/$1" || exit
}

cdt() {
    cd "${HOME}/Desktop/telescope/$1" || exit
}

cdsp() {
    cd "$(python -c 'import site; print(site.getsitepackages()[0])')" || exit
}

cds() {
    cd ~/Desktop/workspace/sandbox/ || exit
}

PATH="/home/pdmurray/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/pdmurray/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/pdmurray/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/pdmurray/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/pdmurray/perl5"; export PERL_MM_OPT;

[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion

lutris() {
    PYENV_VERSION=system command lutris "$@"
}

calibre() {
    PYENV_VERSION=system command calibre "$@"
}

ebook-convert() {
    PYENV_VERSION=system command ebook-convert "$@"
}

# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION

if [[ ${MAMBA_LOAD} == 1 ]]; then
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
    export PYENV_VERSION=mambaforge
    mamba activate dev
fi
