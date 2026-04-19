#
# ~/.bashrc
#

PS1='[\u@\h \W]\$ '

# Aliases
alias vim='nvim'
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Dotfiles management
alias conf='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
