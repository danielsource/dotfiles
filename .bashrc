[ -z "$PS1" ] && return

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

shopt -s histappend
shopt -s extglob
shopt -s globskipdots
stty -ixon

if [ "$TERM" = linux ]; then
	printf '\e]P0000000\e]P1cd3131\e]P20dbc79\e]P3e5e510\e]P42472c8\e]P5bc3fbc\e]P611a8cd\e]P8666666\e]P9f14c4c\e]PA23d18b\e]PBf5f543\e]PC3b8eea\e]PDd670d6\e]PE29b8db'
fi

if [ "$(id -u)" -ne 0 ] && [[ ! "$TERM" =~ dumb|eterm* ]]; then
	if [ -f "${PREFIX:-/usr}"/share/bash-completion/bash_completion ]; then
		. "${PREFIX:-/usr}"/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
	if [ -f "${PREFIX:-/usr}"/share/doc/fzf/examples/key-bindings.bash ]; then
		. "${PREFIX:-/usr}"/share/doc/fzf/examples/key-bindings.bash
	fi

	bind -x '"\eOP":tmuxhere' # F1
	if command -v st >/dev/null; then
		bind -x '"\eOQ":setsid st' # F2
	fi

	if command -v __git_ps1 >/dev/null; then
		GIT_PS1_SHOWDIRTYSTATE=1
		GIT_PS1_SHOWSTASHSTATE=1
		GIT_PS1_SHOWUNTRACKEDFILES=1
		GIT_PS1_SHOWUPSTREAM=auto
		GIT_PS1_HIDE_IF_PWD_IGNORED=1
		PS1='\[\e]0;($?) In \W $(__git_ps1 "on %s")\a\]% '
	else
		PS1='\[\e]0;($?) \W\a\]% '
	fi
else
	printf "\e]0;$0\a"
	PS1='\$ '
fi

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

lz() {
	if [ $# -eq 0 ]; then
		echo '?' >&2
		return 2
	fi

	local out treedepth arch cache patt

	case $1 in
	-t[1-9]*) treedepth="${1#-t}" && shift ;;
	-t) treedepth=0 && shift ;;
	-t0) unset treedepth && shift ;;
	esac

	if [ $# -lt 1 ] || [ $# -gt 2 ]; then
		echo '?' >&2
		return 2
	fi

	arch=$1 && shift
	cache=${XDG_CACHE_HOME:-$HOME/.cache}/lz-"$(basename "$arch")".txt
	if [ "$cache" -nt "$arch" ]; then
		out=$(cat "$cache")
	else
		case $arch in
		*.zip) mkdir -p "$(dirname "$cache")" && out=$(zipinfo -1 "$arch" | tee "$cache") ;;
		*.tar|*.tar.gz|*.tar.xz) mkdir -p "$(dirname "$cache")" && out=$(tar -tf "$arch" | tee "$cache") ;;
		*) return 1;
		esac
	fi

	patt=$1 && shift
	if [ -z "$treedepth" ] || ! command -v tree >/dev/null; then
		echo "$out" | grep -- "$patt"
		return
	fi
	if [ "$treedepth" -eq 0 ]; then
		echo "$out" | grep -- "$patt" | tree --fromfile .
		return
	fi
	echo "$out" | grep -- "$patt" | tree --fromfile . -L "$treedepth"
}

iman() {
	if [ -z "$1" ]; then
		echo '?' >&2
		return 1
	fi
	case $1 in
	*.info.gz|*.info-*.gz)
		gzip -d < "$1" | tr '\037' '#' | "${PAGER:-less}" -M ;;
	*)
		if [ -f /usr/share/info/"$1".info"$2".gz ]; then
			gzip -d < /usr/share/info/"$1".info"$2".gz | tr '\037' '#' | "${PAGER:-less}" -M
		else
			man "$1"
		fi
	esac
}

sysc() {
	man "${1:-2}" \
		"$(echo '#include <sys/syscall.h>' |
		cpp -dM |
		awk '/#define __NR_/ {print $3 "\t" substr($2, 6)}' |
		sort -n |
		fzf |
		cut -f2)"
}

tmuxhere() {
	tmux new-session -As "$(printf '%.*s' 7 "$(basename "$PWD" | tr -cd '[:alnum:]')")"
}

wh() {
	local delay=1 err
	if [ $# -gt 2 ]; then
		echo '?' >&2
		return 1
	elif [ $# -eq 2 ]; then
		delay=$1
		shift || return
	fi
	while :; do
		watch -ten "$delay" -- "$@"
		err=$?
		if [ $err -ne 8 ]; then
			return $err
		fi
		sleep 0.3
	done
}

alias ls='LC_COLLATE=C ls -h --color=auto --group-directories-first --time-style="+%y %b %d %H:%M:%S"'

export GPG_TTY=$(tty)

if [ -f ~/.bashrc.local ]; then
	. ~/.bashrc.local
fi
