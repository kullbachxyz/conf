#
# ~/.bashrc
#

HISTSIZE=10000000
HISTFILESIZE=10000000

HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/bash/history"

# Append to history file instead of overwriting
shopt -s histappend

# Write to history file immediately after each command, view all entries by paralel shells
PROMPT_COMMAND='history -a; history -n'

[ -f ~/.profile ] && . ~/.profile

PS1='[\u@\h \W]\$ '

# Aliases
alias vim='nvim'
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Dotfiles management
alias conf='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Remove junk folders from home
case $- in
  *i*)
    for dir in "$HOME/thunderbird" "$HOME/omnissa-$USER"; do
      if [ -d "$dir" ]; then
        rm -rf -- "$dir"
      fi
    done
    ;;
esac

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
