[ -z "$PS1" ] && return

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

shopt -s histappend
shopt -s extglob
shopt -s globskipdots
stty -ixon

if [ $(id -u) -eq 0 ]; then
	is_root=1
fi

if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi

case "$TERM" in
xterm-color|*-256color)
	color_prompt=1 ;;
linux)
	printf '\e]P0000000\e]P1cd3131\e]P20dbc79\e]P3e5e510\e]P42472c8\e]P5bc3fbc\e]P611a8cd\e]P8666666\e]P9f14c4c\e]PA23d18b\e]PBf5f543\e]PC3b8eea\e]PDd670d6\e]PE29b8db'
	color_prompt=1 ;;
esac

if [[ ! "$TERM" =~ dumb|eterm* ]]; then
	if [ -f "${PREFIX:-/usr}"/share/bash-completion/bash_completion ]; then
		. "${PREFIX:-/usr}"/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi

	if [ -z "$is_root" ]; then
		if [ -f "${PREFIX:-/usr}"/share/doc/fzf/examples/key-bindings.bash ]; then
			. "${PREFIX:-/usr}"/share/doc/fzf/examples/key-bindings.bash
		fi
		bind -x '"\eOP":tmuxhere' # F1
		if command -v st >/dev/null; then
			bind -x '"\eOQ":setsid st' # F2
		fi
	fi
fi

if [ -n "$color_prompt" ]; then
	printf "\e]0;$(ps -o tty= -p $$)\a"
	if [ -z "$is_root" ]; then
		PS1='${debian_chroot:+($debian_chroot) }\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '
	else
		PS1='${debian_chroot:+($debian_chroot) }\[\033[01;31m\]\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]# '
	fi
else
	PS1='${debian_chroot:+($debian_chroot) }\u@\h:\W\$ '
fi
unset is_root color_prompt

asciigraph() {
	cat <<'EOF'
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
	local d1 d2 diff day hour min sec
	if [ $# -eq 1 ]; then
		d1="$(date +%s)" || return $?
	elif [ $# -eq 2 ]; then
		d1=$(date -d "$2" +%s) || return $?
	else
		echo '?' >&2
		return 1
	fi
	d2=$(date -d "$1" +%s) || return $?
	diff=$((d2 - d1))
	day=$((diff / 86400))
	hour=$(((diff % 86400) / 3600))
	min=$(((diff % 3600) / 60))
	sec=$((diff % 60))
	echo "$diff s = $day d + $hour h + $min min + $sec s"
}

lastmod() {
	find "$@" -type f -exec stat -c '%Y :%y %n' {} + | sort -nr | cut -d: -f2-
}

tmuxhere() {
	tmux new-session -As "$(printf '%.*s' 7 "$(basename "$PWD" | tr -cd '[:alnum:]')")"
}

trysudo() {
	if [ $(id -u) -eq 0 ] || ! command -v sudo >/dev/null; then
		"$@"
	else
		sudo -- "$@"
	fi
}

update() {
	(set -e; . /etc/os-release; distro=${ID_LIKE:-$ID}
	case $distro in
	(*debian*)
		trysudo apt update
		trysudo apt -y upgrade
		;;
	(*)
		echo "Not supported" >&2
		exit 1
		;;
	esac) || return
	if command -v flatpak >/dev/null; then
		printf 'Try to update flatpaks? [Y/n] '
		read opt
		case $opt in
			''|[Yy]*) flatpak update -y ;;
			*) return ;;
		esac
	fi
}

alias ls='LC_COLLATE=C ls -h --color=auto --group-directories-first --time-style="+%y %b %d %H:%M:%S"'

export GPG_TTY=$(tty)

if [ -f ~/.bashrc.local ]; then
	. ~/.bashrc.local
fi
