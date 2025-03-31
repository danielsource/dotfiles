[ -z "$PS1" ] && return

PS1='\[\033[01;30m\]$?\[\033[0m\] \[\033[01;32m\]\u\[\033[0m\] \[\033[01;34m\]\w \$\[\033[0m\] '
EDITOR=vim
export GPG_TTY=$(tty)

stty -ixon

open() { setsid xdg-open "$@" 2>/dev/null; }
tmux_here() { tmux new-session -As "$(printf '%.*s' 7 "$(basename "$PWD" | tr -cd '[:alnum:]')")"; }
alias ls='LC_COLLATE=C ls --color=auto --group-directories-first'
alias l='ls -lahG'
alias o=open
bind -x '"\C-g":tmux_here'

if [ -f ~/docs/misc/bashrc.sh ]; then
    . ~/docs/misc/bashrc.sh
fi
