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
alias df='df -h'
alias sudo='sudo '
alias grep='grep --color=always'
alias rm='trashy put'
alias rg='rg -S'
alias less='less -R'
alias tree='tree -C --gitignore'
alias hx='helix'
alias nnn='nnn -de -P p'
alias dk-clean-all='docker stop $(docker container ls -a -q) && docker system prune -a -f --volumes'

eval "$(ssh-agent)" > /dev/null
ssh-add -q

export VISUAL=nvim
export EDITOR=nvim
export TERM=xterm-kitty
export DFT_DISPLAY='side-by-side-show-both'
export LC_COLLATE="C" # Set hidden files on top
export NNN_FCOLORS="AAAAE631BBBBCCCCDDDD9999"
export NNN_FIFO="/tmp/nnn.fifo"
export NNN_OPTS="H"
export NNN_PLUG="p:preview-tui"
export SPLIT='v'
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export VOLTA_HOME=$HOME/.volta

export PATH="$VOLTA_HOME/bin:$PATH"
export PATH="/opt/homebrew/opt/trash/bin:$PATH"
export PATH=$HOME/.config/scripts:$PATH
alias rm="trash"

export PATH="$PATH:/Users/peyton/.local/bin"
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
if (( ! $+functions[pyenv] )); then
    eval "$(pyenv init - zsh)"
    eval "$(pyenv virtualenv-init -)"
fi

# gcp-guard: default Prod GCP to read-only (added by eng-commons bootstrap.sh)
eval "$(gcp-guard shell-init zsh)"

. "$HOME/.atuin/bin/env"

# Needed because of how homebrew is...
export LDFLAGS="-L/opt/homebrew/opt/libomp/lib:$LDFLAGS"
export CPPFLAGS="-I/opt/homebrew/opt/libomp/include:$CPPFLAGS"
export PATH="/opt/homebrew/opt/imagemagick-full/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/imagemagick-full/lib:$LDFLAGS"
export CPPFLAGS="-I/opt/homebrew/opt/imagemagick-full/include:$CPPFLAGS"
export PKG_CONFIG_PATH="/opt/homebrew/opt/imagemagick-full/lib/pkgconfig:$PKG_CONFIG_PATH"

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
    elif [[ $1 == "tag" && $# == 1 ]]; then
        command git tag | sort -V
    else
		command git "$@"
	fi
}

cdd() {
    cd "${HOME}/dev/$1" || return
}

cdsp() {
    cd "$(python -c 'import site; print(site.getsitepackages()[0])')" || return
}

cds() {
    cd "${HOME}/dev/sandbox/" || return
}

pgdb() {

    if [ ! -e ".python-version" ]; then
        echo "No local python environment selected. Please set a local pyenv virtualenv."
        return 1
    fi

    version=$($(pyenv which python) -V | awk '{print $2}')

    if [ ! -d "$HOME/dev/cpython" ]; then
        echo "Downloading cpython source..."

        pushd ~/dev
        gh repo clone python/cpython
        pushd cpython
        git fetch --tags
        git checkout v$version
        popd
        popd
    fi

    if [ ! -e './.gdbinit' ]; then
        if [[ $# == 0 ]]; then
            echo "Call this function with a local python script to debug."
            return 1
        fi

        echo "Writing .gdbinit..."
        echo "directory $(pyenv prefix)/include/" >> .gdbinit
        echo "directory ~/dev/cpython/" >> .gdbinit
        echo "" >> .gdbinit
        echo "file $(pyenv which python)" >> .gdbinit
        echo "run" >> .gdbinit

        echo "Add 'directory <path-to-your-compiled-extension-source>' and any breakpoints you want to .gdbinit, then rerun pgdb."
        return 0
    fi

    if

    filename=$(basename -- "$1")
    extension="${filename##*.}"

    if [[ extension == ".py" ]]; then
        gdb --args ${@:2}
    elif [[ filename == "pytest" ]]; then
        gdb --args -m ${@:2}
    else
        gdb
    fi
}

autoload -Uz compinit
compinit

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

bindkey '^[[Z' reverse-menu-complete # Move back one item in completion menus

# Bind key sequences for deleting by subword
autoload -U select-word-style
select-word-style bash

eval "$(luarocks path)"
eval "$(starship init zsh)"
eval "$(atuin init zsh --disable-up-arrow)"

# case insensitive path-completion 
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu select=0

bindkey '^I' complete-word

# Carapace completion
export CARAPACE_MATCH="CASE_INSENSITIVE"
export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
source <(carapace _carapace)
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
