# zmodload zsh/zprof
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

fpath=(/usr/share/zsh/site-functions/ $fpath)
fpath=(~/.config/zsh-completions/ $fpath)

if [ -f ~/.env ]; then
    set -a
    source ~/.env
    set +a
fi

# Use emacs style editing, not vim
bindkey -e

setopt correct

# Show what is effectively `ls -l` when tab completing a file
zstyle ':completion:*' file-list true

alias eza='eza -laH --group-directories-first --sort=extension'
alias ex='eza'
alias ll='eza'
alias du='du -h'
alias df='df -h'
alias ip='ip -c'
alias sudo='sudo '
alias paru='paru --color=always --devel --sudoloop'
alias pacman='pacman --color=always'
alias grep='grep --color=always'
alias vectivate='source vectivate'
alias kmon='kmon -u'
alias rm='trashy put'
alias rg='rg -S'
alias less='less -R'
alias tree='tree -C --gitignore'
alias hx='helix'
alias nnn='nnn -de -P p'
alias dk-clean-all='docker stop $(docker container ls -a -q) && docker system prune -a -f --volumes'

eval "$(ssh-agent)" > /dev/null

export VISUAL=nvim
export EDITOR=nvim
export FONTCONFIG_PATH=/etc/fonts
export TERM=xterm-kitty
export RANGER_LOAD_DEFAULT_RC=FALSE
export NUMPY_EXPERIMENTAL_DTYPE_API=1
export DFT_DISPLAY=side-by-side-show-both
export NNN_OPTS="H"
export LC_COLLATE="C" # Set hidden files on top
export NNN_FIFO="/tmp/nnn.fifo"
export NNN_FCOLORS="AAAAE631BBBBCCCCDDDD9999"
export NNN_PLUG="p:preview-tui"
export SPLIT='v'
export DFT_DISPLAY='side-by-side-show-both'
export BAZEL_ARGS="--local_cpu_resources=HOST_CPUS-4 --local_ram_resources=HOST_RAM*0.6"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1


export PATH=$HOME/go/bin:$PATH
export PATH=$HOME/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.config/scripts:$PATH
export PATH=/usr/lib/emscripten:$PATH
export PATH=/opt/miniconda3/bin/:$PATH
export PATH=/opt/google-cloud-cli/bin/:$PATH
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

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
    elif [[ $1 == "tag" ]]; then
        command git tag | sort -V
    else
		command git "$@"
	fi
}

cdc() {
    cd "${HOME}/Desktop/workspace/codecrafters/$1" || return
}

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
    cd "${HOME}/Desktop/workspace/sandbox/" || return
}

pgdb() {

    if [ ! -e ".python-version" ]; then
        echo "No local python environment selected. Please set a local pyenv virtualenv."
        return 1
    fi

    version=$($(pyenv which python) -V | awk '{print $2}')

    if [ ! -d "$HOME/Desktop/workspace/cpython" ]; then
        echo "Downloading cpython source..."

        pushd ~/Desktop/workspace
        gh repo clone python/cpython
        pushd cpython
        git fetch --tags
        git checkout v$version
        popd
        popd
    fi

    if [ ! -e './.gdbinit' ]; then
        echo "Writing .gdbinit..."

        if [[ $# == 0 ]]; then
            echo "Call this function with a local python script to debug."
            return 1
        fi

        echo "directory $(pyenv prefix)/include/" >> .gdbinit
        echo "directory ~/Desktop/workspace/cpython/" >> .gdbinit
        echo "" >> .gdbinit
        echo "file $(pyenv which python)" >> .gdbinit
        echo "run $(pwd)/$1" >> .gdbinit

        echo "Add 'directory <path-to-your-compiled-extension-source>' and any breakpoints you want to .gdbinit, then rerun pgdb."
        return 0
    fi

    gdb
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

setup-pixi() {
    echo "watch_file pixi.lock" >> .envrc
    echo 'eval "$(pixi shell-hook)"' >> .envrc
}

autoload -U promptinit
promptinit

bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line

# Set up key bindings for navigating by word and subword
bindkey '^[[1;5C' forward-word     # Ctrl+Right Arrow
bindkey '^[[1;5D' backward-word    # Ctrl+Left Arrow
bindkey '^[[1;3C' forward-char     # Alt+Right Arrow
bindkey '^[[1;3D' backward-char    # Alt+Left Arrow

# Bind key sequences for deleting by word
bindkey '^[[3;5~' kill-word        # Ctrl+Delete (if supported by terminal)
bindkey '^H' backward-kill-word    # Ctrl+Backspace (^H)

# Bind key sequences for deleting by subword
autoload -U select-word-style
select-word-style bash

eval "$(luarocks path)"
eval "$(starship init zsh)"
eval "$(atuin init zsh --disable-up-arrow)"
eval "$(direnv hook zsh)"

# case insensitive path-completion 
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu select=0

bindkey '^I' complete-word

# The following lines were added by compinstall
zstyle :compinstall filename '/home/pdmurray/.zshrc'

# fpath=(~/.config/zsh-completions $fpath)
autoload -Uz compinit bashcompinit
compinit
bashcompinit

# End of lines added by compinstall
eval "$(pixi completion --shell zsh)"

autoload -Uz /usr/share/zsh/site-functions/*(.:t)

# Credit: https://github.com/rust-lang/rustup/blob/master/src/cli/self_update/env.sh
case ":${PATH}:" in
    *:"/home/pdmurray/.local/share/bob/nvim-bin":*)
        ;;
    *)
        export PATH="/home/pdmurray/.local/share/bob/nvim-bin:$PATH"
        ;;
esac
