[ -z "$PS1" ] && return

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
PROMPT_DIRTRIM=3

shopt -s histappend
shopt -s extglob
shopt -s globskipdots
stty -ixon

case "$TERM" in
xterm*|rxvt*|tmux*)
	PS1='\[\033[00m\]($?) \[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
	PS1="\[\e]0;${debian_chroot:+($debian_chroot) }\u@\h: \W\a\]$PS1"
	;;
*)
	PS1='($?) \u@\h:\w\$ '
	;;
esac

if [ "$(id -u)" -ne 0 ] && [ "$TERM" != dumb ] && ! shopt -oq posix; then
	if [ -f "${PREFIX:-/usr}"/share/bash-completion/bash_completion ]; then
		. "${PREFIX:-/usr}"/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
	if [ -f "${PREFIX:-/usr}"/share/doc/fzf/examples/key-bindings.bash ]; then
		. "${PREFIX:-/usr}"/share/doc/fzf/examples/key-bindings.bash
	fi
	bind -x '"\C-g":tmux_here'
fi

asciigraph() {
	cat <<-'EOF'
	ABCDEFGHIJKLMNOPQRSTUVWXYZ 01234
	abcdefghijklmnopqrstuvwxyz 56789
	!"#$%&'()*+,-./:;<=>?@[\]^_`{|}~
	the quick brown fox jumps over the lazy dog
	THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG
	EOF
}

colors() {
	printf '\x1b[38;2;255;100;0mTRUECOLOR\x1b[0m\n'
	for i in {0..7}; do
		printf '\e[1;4%dm %2d \e[0m ' $i $i
	done
	printf '\n'
	for i in {0..7}; do
		printf '\e[10%dm %2d \e[0m ' $i $i
	done
	printf '\n'
	for i in {0..7}; do
		printf '\e[3%dm %2d \e[0m ' $i $i
	done
	printf '\n'
	for i in {0..7}; do
		printf '\e[1;3%dm %2d \e[0m ' $i $i
	done
	printf '\n'
}

datediff() {
	local d1 d2
	if [ $# -eq 1 ]; then
		d1="$(date +%s)" || return $?
	elif [ $# -eq 2 ]; then
		d1=$(date -d "$2" +%s) || return $?
	else
		return 1
	fi
	d2=$(date -d "$1" +%s) || return $?
	echo $(( (d2 - d1) / 86400 )) days
}

lastmod() {
	find "$@" -type f -exec stat -c '%Y :%y %n' {} + | sort -nr | cut -d: -f2-
}

rot13() {
	tr "$(echo -n {A..Z} {a..z} | tr -d ' ')" "$(echo -n {N..Z} {A..M} {n..z} {a..m} | tr -d ' ')"
}

tmux_here() {
	tmux new-session -As "$(printf '%.*s' 7 "$(basename "$PWD" | tr -cd '[:alnum:]')")"
}

alias ls='LC_COLLATE=C ls --color=auto --group-directories-first'
alias l='ls -lahG'
alias o=open

if [ "$TERM" = dumb ]; then
	alias git='git --no-pager'
fi
