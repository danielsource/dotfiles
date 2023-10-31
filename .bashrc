unalias -a
shopt -s expand_aliases

alias cp='cp -i -b'
alias gdb='gdb -q'
alias ls='LC_COLLATE=C ls --color=never -F --group-directories-first'
alias mv='mv -i -b'
alias rm='rm -I'
alias sudo='sudo '

alias b=acpi
alias e='${EDITOR:-vi}'
alias es='exec "${SHELL:-sh}"'
alias l='ls -la'
alias m=make
alias o='setsid xdg-open'
alias ox='exec setsid xdg-open'
alias py=python3
alias q=qalc
alias th='gio trash'
alias lesss='less +G'

if [ -d ~/.bashrc.d ]; then
	for file in ~/.bashrc.d/*.sh ; do
		. "$file"
	done
	unset file
fi

[[ $- != *i* ]] && return

shopt -s checkwinsize expand_aliases histappend extglob autocd
stty -ixon # disable Ctrl-s freeze

# system information
inf() {
	uname -sr
	uptime | sed 's/ //'
	sensors 2>/dev/null | awk '/Tctl:/{print "CPU temp:\t"$2}'
	printf 'Memory in use:\t' && free -m | awk '/Mem/{print $3+$5"M"}'
	df -h | awk '/\/$/{print "Storage:\t"$3"/"$2" ("$5")"}'
	term=$(readlink "/proc/$(cat /proc/$(echo $$)/stat | cut -d ' ' -f 4)/exe")
	if [ -n "$term" ]; then
		printf 'Terminal:\t%s\n' "$term"
	fi
	acpi 2>/dev/null
	for i in {0..7}; do
		printf '\e[48;5;%sm %2d \e[0m ' $i $i
	done
	printf '\n'
	for i in {8..15}; do
		printf '\e[48;5;%sm %2d \e[0m ' $i $i
	done
	printf '\n'
}

# bc calc shorthand
function cl {
	echo "scale=5; $@" | bc
}

# python doc
pyd() {
	if [ $# -ne 1 ]; then
		return 1
	fi
	python3 -c "help('$1')"
}

NOTES=~/Documents/notes.txt
# take a note
function n {
	if [ -z "$1" ]; then
		ns
	else
		date=$(date '+%a.%d.%m %H:%M')
		echo "$date | $@" >> "$NOTES"
	fi
}
# display notes
function ns {
	if ! [ -f "$NOTES" ]; then
		echo "No notes (file missing)." 2>&1
		return 1
	fi

	local lines
	if [ -z "$1" ]; then
		lines="10"
	else
		lines="$1"
	fi
	tail "$NOTES" -n "$lines"
}

PS1='$exitcode\w\$ '

PROMPT_COMMAND='exitcode=$?; if [ $exitcode -ne 0 ]; then exitcode="$exitcode "; else unset exitcode; fi'

export PS1 PROMPT_COMMAND HISTSIZE=10000 HISTFILESIZE=200000

if ! shopt -oq posix && [ "$TERM" != dumb ]; then
	if [ -f "${PREFIX:-/usr}"/share/bash-completion/bash_completion ]; then
		. "${PREFIX:-/usr}"/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi

	if [ -f /usr/share/doc/fzf/examples/key-bindings.bash ]; then
		. /usr/share/doc/fzf/examples/key-bindings.bash
	elif [ -f "${PREFIX:-/usr}"/share/fzf/key-bindings.bash ]; then
		. "${PREFIX:-/usr}"/share/fzf/key-bindings.bash
	fi
fi

datediff() {
	if [ $# -eq 1 ]; then
		d1="$(date +%s)" || return $?
	elif [ $# -ne 2 ]; then
		return 1
	else
		d1=$(date -d "$2" +%s) || return $?
	fi
	d2=$(date -d "$1" +%s) || return $?
	if [ $d1 -lt $d2 ]; then
		echo $(( (d2 - d1) / 86400 )) days
	else
		echo $(( (d1 - d2) / 86400 )) days
	fi
}
