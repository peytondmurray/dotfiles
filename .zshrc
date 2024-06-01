# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git starship direnv fd gh pip)

source $ZSH/oh-my-zsh.sh

# User configuration

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

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
eval "$(luarocks path)"
eval "$(atuin init zsh --disable-up-arrow)"

# The following lines were added by compinstall
zstyle :compinstall filename '/home/pdmurray/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
