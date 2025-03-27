[ -z "$PS1" ] && return

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

shopt -s histappend
shopt -s checkwinsize
stty -ixon

case "$TERM" in
	xterm-color|*-256color) color_prompt=yes ;;
esac

if [ "$color_prompt" = yes ]; then
	PS1='($?) \[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
	PS1='($?) \u@\h:\w\$ '
fi
unset color_prompt

case "$TERM" in
xterm*|rxvt*|tmux*)
	PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
	;;
*)
	;;
esac

if ! shopt -oq posix; then
	if [ -f "${PREFIX:-/usr}"/share/bash-completion/bash_completion ]; then
		. "${PREFIX:-/usr}"/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

open() { setsid xdg-open "$@" 2>/dev/null; }
tmux_here() { tmux new-session -As "$(printf '%.*s' 7 "$(basename "$PWD" | tr -cd '[:alnum:]')")"; }
alias ls='LC_COLLATE=C ls --color=auto --group-directories-first'
alias l='ls -lahG'
alias o=open
bind -x '"\C-g":tmux_here'
