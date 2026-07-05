#
# ~/.zshrc
#

# History
HISTSIZE=10000000
SAVEHIST=10000000
mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"
setopt SHARE_HISTORY        # write + re-read after each command (replaces PROMPT_COMMAND hack)
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

# Completion — rebuild dump only if it's older than 24h
autoload -Uz compinit
_zcompdump="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"
if [[ -n "$_zcompdump"(#qN.mh+24) ]]; then
  compinit -d "$_zcompdump"
else
  compinit -C -d "$_zcompdump"
fi
unset _zcompdump

# Source profile (env vars, PATH, startx autolaunch)
[ -f ~/.profile ] && . ~/.profile

# Prompt: [user@host dir]$ — same colors as bash PS1
PROMPT='%B%F{red}[%F{yellow}%n%F{green}@%F{blue}%m %F{magenta}%1~%F{red}]%F{white}%#%f%b '

# Aliases
alias vim='nvim'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
passf() {
    local name
    name=$(find "${PASSWORD_STORE_DIR:-$HOME/.password-store}" -name "*.gpg" \
        | sed "s|${PASSWORD_STORE_DIR:-$HOME/.password-store}/||;s|\.gpg$||" \
        | sort | fzf --height 40% --reverse)
    [ -n "$name" ] && pass show "$name" | head -1 | xclip -selection clipboard && echo "Copied: $name"
}

# Dotfiles management
alias conf='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Remove junk folders from home
for dir in "$HOME/thunderbird" "$HOME/omnissa-$USER"; do
  [[ -d "$dir" ]] && rm -rf -- "$dir"
done
unset dir

# lf/lfub: cd to last directory on exit
_lf_cd() {
  local cmd="$1" tmp dir
  shift
  tmp=$(mktemp)
  command "$cmd" -last-dir-path="$tmp" "$@"
  if [[ -f "$tmp" ]]; then
    dir=$(< "$tmp")
    rm -f "$tmp"
    [[ -d "$dir" && "$dir" != "$PWD" ]] && cd "$dir"
  fi
}
lf()   { _lf_cd lf   "$@"; }
lfub() { _lf_cd lfub "$@"; }

# Up/Down arrow: search history by prefix already typed
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search

# Vi mode
bindkey -v
export KEYTIMEOUT=1

# Cursor shape: block in normal mode, beam in insert mode
zle-keymap-select() {
  case $KEYMAP in
    vicmd)      echo -ne '\e[2 q';;
    viins|main) echo -ne '\e[6 q';;
  esac
}
zle -N zle-keymap-select

zle-line-init() {
  zle -K viins
  echo -ne '\e[6 q'
}
zle -N zle-line-init

echo -ne '\e[6 q'
preexec() { echo -ne '\e[6 q'; }

# Plugins (must be last — syntax-highlighting especially)
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
