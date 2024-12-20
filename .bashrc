# shellcheck shell=bash

umask 077

case $- in *i*) ;; *) return ;; esac

stty -ixon
shopt -s checkwinsize
shopt -s histappend
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=10000

if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	fi
	if [ -f /usr/share/doc/fzf/examples/key-bindings.bash ]; then
		. /usr/share/doc/fzf/examples/key-bindings.bash
	fi
fi

case "$TERM" in
xterm-color|*-256color)
	c_git='\[\e[31m\]'
	c_path='\[\e[1;34m\]'
	if [ -z "$VIM_TERMINAL" ]; then
		c_err='\[\e[1;30m\]'
	fi
	c_clr='\[\e[0m\]'
	;;
esac

if command -v __git_ps1 >/dev/null; then
	git_prompt='$(__git_ps1 "%s ")'
	GIT_PS1_STATESEPARATOR=''
	GIT_PS1_HIDE_IF_PWD_IGNORED=t
fi

PS1="$c_clr$c_err\$?$c_clr $c_git$git_prompt$c_clr$c_path\W$c_clr % "

unset c_git c_path c_err c_clr git_prompt

case "$TERM" in
xterm*|rxvt*|tmux-256color|st-256color)
	PS1="\[\e]0;\u@\h: \w\a\]$PS1"
	;;
*)
	;;
esac

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

asciigraph() {
	cat <<-'EOF'
	ABCDEFGHIJKLMNOPQRSTUVWXYZ 01234
	abcdefghijklmnopqrstuvwxyz 56789
	!"#$%&'()*+,-./:;<=>?@[\]^_`{|}~
	the quick brown fox jumps over the lazy dog
	THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG
	EOF
}

datediff() {
	local d1 d2
	if [ $# -eq 1 ]; then
		d1="$(date +%s)" || return $?
	elif [ $# -ne 2 ]; then
		return 1
	else
		d1=$(date -d "$2" +%s) || return $?
	fi
	d2=$(date -d "$1" +%s) || return $?
	echo $(( (d2 - d1) / 86400 )) days
}

escsed() {
	sed 's:[][*.^$/\]:\\&:g' <<<"$1"
}

lastmod() {
	find "$@" \( -path ./.cache/mozilla \
		-o   -path ./.mozilla \
		-o   -path ./.var \
		-o   -path ./opt/misc \) -prune -o -type f -print0 |
		xargs -0 stat --format '%Y :%y %n' |
		sort -nr | cut -d: -f2-
}

longbasename() {
	find "${1-.}" -path '*/.git' -prune -o -print | awk '
	BEGIN {
		max = 0;
		maxpath = "";
	} {
		n = split($0, s, /\//);
		bn = s[n];
		if (length(bn) > max) {
			max = length(bn);
			maxpath = $0;
		}
		sum += length(bn);
	} END {
		print "file:\t\t", maxpath, "\nlength:\t\t", max "\navg length:\t", sum/NR, "\ntotal files:\t", NR
	}'
}

# wpctl wrapper
wp() {
	local default=SINK
	if [ $# -eq 0 ]; then
		wpctl status
		return
	fi
	if [ $1 = -m ]; then
		default=SOURCE
		shift 1 || return
	fi
	case $1 in
	g)
		shift 1 || return
		if [ $# -eq 0 ]; then
			wpctl get-volume @DEFAULT_AUDIO_${default}@
			return
		fi
		wpctl get-volume "$@" ;;
	v)
		shift 1 || return
		if [ $# -eq 0 ]; then
			wpctl set-volume @DEFAULT_AUDIO_${default}@
			return
		elif [ $# -eq 1 ]; then
			wpctl set-volume @DEFAULT_AUDIO_${default}@ "$@"
			return
		fi
		wpctl set-volume "$@" ;;
	m)
		shift 1 || return
		if [ $# -eq 0 ]; then
			wpctl set-mute @DEFAULT_AUDIO_${default}@ toggle
			return
		fi
		wpctl set-mute "$@" toggle ;;
	s) shift 1 && wpctl set-default "$@" ;;
	*)
		cat <<-'USAGE_END'
	usage: wp [-m] [cmd [args...]]
	       wp                   # status
	       wp g                 # get volume
	       wp g ID              # get volume
	       wp v VOL[%][-|+]     # set volume
	       wp v ID VOL[%][-|+]  # set volume
	       wp m                 # toggle mute
	       wp m ID              # toggle mute
	       wp s ID              # set default sink/source
	USAGE_END
	return 1 ;;
	esac
}

alias sudo='sudo '
alias ls='ls --color=auto'
alias l='LC_COLLATE=C ls --group-directories-first'
alias la='l -a'
alias ll='la -lhG'
alias gdb='gdb -q'
alias loc="find . -type f -name '*.c' -exec grep ';\s*$' {} + | wc -l"

bind -x '"\C-g":"tmux new-session -As $(printf %.\*s 7 $(basename $PWD | tr -cd \[:alnum:\]))"'

export GPG_TTY=$(tty)

if [ -f ~/docs/bashrc ]; then
	. ~/docs/bashrc
fi
