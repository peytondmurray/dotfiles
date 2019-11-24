#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto --group-directories-first'
PS1="[\u@\h \W]\$ "

alias ll='ls -lah'
alias python='/home/pdmurray/python38/bin/python3'
alias pip='/home/pdmurray/python38/bin/pip3'
alias du='du -h'
alias sudo='sudo '
alias yay='yay --color=auto'
alias pacman='pacman --color=auto'

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
export PS1="\[\e[0;36m\]$PS1\[\e[m\]"
