#!/bin/bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias exa='exa -laH --group-directories-first --sort=extension'
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
alias tree='tree -C --gitignore'
alias hx='helix'

export PATH=$HOME/go/bin:$PATH
export PATH=$HOME/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.config/scripts:$PATH
export PATH=/usr/lib/emscripten:$PATH
export PATH=$HOME/.local/bin:$PATH

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

# export PYENV_VIRTUALENV_DISABLE_PROMPT=1
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init --path)"
# eval "$(pyenv init -)"

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

export PATH=/opt/miniforge/bin:$PATH

init_conda_dev() {
    pushd ~/Desktop/workspace/conda || exit

    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/home/pdmurray/Desktop/workspace/conda/devenv/envs/devenv-3.10-c/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/home/pdmurray/Desktop/workspace/conda/devenv/envs/devenv-3.10-c/etc/profile.d/conda.sh" ]; then
            . "/home/pdmurray/Desktop/workspace/conda/devenv/envs/devenv-3.10-c/etc/profile.d/conda.sh"
        else
            export PATH="/home/pdmurray/Desktop/workspace/conda/devenv/envs/devenv-3.10-c/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<

    echo "Setting up conda dev environment..."

    _SRC=$(git rev-parse --show-toplevel)
    _DEVENV="${_SRC}/devenv"
    _PYTHON="${_PYTHON:-3.10}"
    _NAME="devenv-${_PYTHON}-c"
    _ENV="${_DEVENV}/envs/${_NAME}"
    _UPDATED="${_ENV}/.devenv-updated"
    _BASEEXE=conda
    _ENVEXE="${_ENV}/bin/conda"
    _MACH="$(uname)"

    updating() {
        # check if explicitly updating or if 24 hrs since last update
        [ "${_UPDATE}" = "true" ] && return 0
        [ -f "${_UPDATED}" ] || return 0
        return $(( $(( $(date +%s) - $(date -r "${_UPDATED}" +%s) )) < 86400 ))
    }

    # create empty env if it doesn't exist
    if ! [ -d "${_ENV}" ]; then
        echo "Creating ${_NAME}..."
        if ! PYTHONPATH="" "${_BASEEXE}" create --yes --quiet "--prefix=${_ENV}" > /dev/null; then
            echo "Error: failed to create ${_NAME}" 1>&2
            return 1
        fi
    fi

    # check if explicitly updating or if 24 hrs since last update
    if updating; then
        echo "Updating ${_NAME}..."

        if ! PYTHONPATH="" "${_BASEEXE}" install \
            --yes \
            --quiet \
            "--prefix=${_ENV}" \
            --override-channels \
            --channel=defaults \
            "--file=${_SRC}/tests/requirements.txt" \
            "--file=${_SRC}/tests/requirements-ci.txt" \
            "$([ "${_MACH}" = "Linux" ] && echo "--file=${_SRC}/tests/requirements-Linux.txt")" \
            "python=${_PYTHON}" > /dev/null; then
            echo "Error: failed to update ${_NAME}" 1>&2
            return 1
        fi

        # update timestamp
        touch "${_UPDATED}"
    fi

    # "install" conda
    # trick conda into importing from our source code and not from site-packages
    if [ -z "${PYTHONPATH+x}" ]; then
        export PYTHONPATH="${_SRC}"
    else
        export PYTHONPATH="${_SRC}:${PYTHONPATH}"
    fi

    # initialize conda command
    echo "Initializing shell integration..."
    eval "$(${_ENVEXE} shell.bash hook)" > /dev/null
    if ! [ $? = 0 ]; then
        echo "Error: failed to initialize shell integration" 1>&2
        return 1
    fi

    # activate env
    echo "Activating ${_NAME}..."
    if ! conda activate "${_ENV}" > /dev/null; then
        echo "Error: failed to activate ${_NAME}" 1>&2
        return 1
    fi

    # cleanup
    unset _ARCH
    unset _BASEEXE
    unset _CMD
    unset _DEFAULT_ARCH
    unset _DEFAULT_DEVENV
    unset _DEFAULT_DRYRUN
    unset _DEFAULT_MACH
    unset _DEFAULT_PYTHON
    unset _DEFAULT_UPDATE
    unset _DEVENV
    unset _DRYRUN
    unset _ENV
    unset _ENVEXE
    unset _INSTALLER
    unset _MACH
    unset _NAME
    unset _PYTHON
    unset _PYTHONEXE
    unset _SRC
    unset _UPDATE
    unset _UPDATED

    popd || exit
}

init_conda_dev

# if [[ $(pwd) == "$HOME/Desktop/workspace/conda" || $(pwd) == "$HOME/Desktop/workspace/conda-declarative" ]]; then
#     init_conda_dev
# else
#     # >>> conda initialize >>>
#     # !! Contents within this block are managed by 'conda init' !!
#     __conda_setup="$('/opt/miniforge/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
#     if [ $? -eq 0 ]; then
#         eval "$__conda_setup"
#     else
#         if [ -f "/opt/miniforge/etc/profile.d/conda.sh" ]; then
#             . "/opt/miniforge/etc/profile.d/conda.sh"
#         else
#             export PATH="/opt/miniforge/bin:$PATH"
#         fi
#     fi
#     unset __conda_setup
#     # <<< conda initialize <<<
# fi
