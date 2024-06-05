# plugins=(git starship direnv fd gh pip)

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

fpath=(/usr/share/zsh/site-functions/ $fpath)

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
alias rm='trash'
alias rg='rg -S'
alias less='less -R'
alias tree='tree -C'
alias hx='helix'
alias nnn='nnn -de -P p'

# eval "$(pyenv init --path)"
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
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

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

pgdb() {
    gdb "$(pyenv which python)" "$@"
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

bindkey '^H' backward-kill-word

eval "$(luarocks path)"
eval "$(starship init zsh)"
eval "$(atuin init zsh --disable-up-arrow)"

# case insensitive path-completion 
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 

# The following lines were added by compinstall
zstyle :compinstall filename '/home/pdmurray/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
