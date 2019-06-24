#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto --group-directories-first'
PS1="[\u@\h \W]\$ "

alias ll='ls -lah'
alias python='/home/pdmurray/python37/bin/python3.7'
alias pip='/home/pdmurray/python37/bin/pip3'
alias du='du -h'
alias sudo='sudo '

export PATH=/home/pdmurray/python37/bin:$PATH
export PATH=/home/pdmurray/.gem/ruby/2.6.0/bin:$PATH
export PATH=/home/pdmurray/go/bin:$PATH
export PATH=/home/pdmurray/.local/bin:$PATH
export PATH=/home/pdmurray/Desktop/Workspace/oommf:$PATH

export LD_LIBRARY_PATH=/home/pdmurray/python37/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/home/pdmurray/Workspace/fidimag/local/lib:$LD_LIBRARY_PATH

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk
export VISUAL=micro
export EDITOR=micro
export PYTHONPATH=/home/pdmurray/Desktop/Workspace/fidimag:$PYTHONPATH
export OOMMFTCL=/home/pdmurray/Desktop/Workspace/oommf/oommf.tcl
export OMP_NUM_THREADS=4
export LAMMPS_POTENTIALS=/home/pdmurray/Workspace/lammps/potentials
export FONTCONFIG_PATH=/etc/fonts
export TERM=xterm
export PS1="\[\e[0;36m\]$PS1\[\e[m\]"
