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
alias rm='trashy put'
alias rg='rg -S'
alias less='less -R'
alias tree='tree -C'
alias hx='helix'

export PATH=$HOME/go/bin:$PATH
export PATH=$HOME/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.config/scripts:$PATH
export PATH=/usr/lib/emscripten:$PATH

export VISUAL=nvim
export EDITOR=nvim
export FONTCONFIG_PATH=/etc/fonts
export TERM=xterm-kitty
export RANGER_LOAD_DEFAULT_RC=FALSE
export NUMPY_EXPERIMENTAL_DTYPE_API=1
export DFT_DISPLAY=side-by-side-show-both

alias nnn='nnn -de -P p'
export NNN_OPTS="H"
export LC_COLLATE="C" # Set hidden files on top
export NNN_FIFO="/tmp/nnn.fifo"
export NNN_FCOLORS="AAAAE631BBBBCCCCDDDD9999"
export NNN_PLUG="p:preview-tui"
export SPLIT='v'
export DFT_DISPLAY='side-by-side-show-both'

export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

eval "$(luarocks path)"

export BAZEL_ARGS="--local_cpu_resources=HOST_CPUS-4 --local_ram_resources=HOST_RAM*0.6"

eval "$(ssh-agent)" > /dev/null

playbell() {
    paplay /usr/share/sounds/freedesktop/stereo/complete.oga
}

ssh() {
    TERM=xterm-256color command ssh "$@"
}

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

# Requires fzf fzf-extras
source /usr/share/fzf/fzf-extras.bash
# source /usr/share/fzf/{key-bindings,completion}.bash

cdd() {
    cd "${HOME}/Desktop/workspace/$1" || return
}

cda() {
    cd "${HOME}/Desktop/astro/$1" || return
}

cdsp() {
    cd "$(python -c 'import site; print(site.getsitepackages()[0])')" || return
}

cds() {
    cd ~/Desktop/workspace/sandbox/ || return
}

killsc() {
    pkill --signal 9 wineserver
    pkill --signal 9 winedevice.exe
    pkill --signal 9 Agent.exe
    pkill --signal 9 conhost.exe
    pkill --signal 9 rpcss.exe
    pkill --signal 9 plugplay.exe
    pkill --signal 9 svchost.exe
    pkill --signal 9 tabtip.exe
    pkill --signal 9 services.exe
    pkill --signal 9 explorer.exe
}

PATH="/home/pdmurray/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/pdmurray/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/pdmurray/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/pdmurray/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/pdmurray/perl5"; export PERL_MM_OPT;

# [[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
#     . /usr/share/bash-completion/bash_completion

# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION

eval "$(starship init bash)"

# Atuin setup
[[ -f /usr/share/bash-preexec/bash-preexec.sh ]] && source /usr/share/bash-preexec/bash-preexec.sh
eval "$(atuin init bash --disable-up-arrow)"

eval "$(direnv hook bash)"

pyenv activate miniconda3-latest

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/pdmurray/.conda/envs/conda-store/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/pdmurray/.conda/envs/conda-store/etc/profile.d/conda.sh" ]; then
        . "/home/pdmurray/.conda/envs/conda-store/etc/profile.d/conda.sh"
    else
        export PATH="/home/pdmurray/.conda/envs/conda-store/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

conda activate conda-store-server-dev
echo "Activated conda-store-server-dev"
