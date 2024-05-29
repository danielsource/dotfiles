[[ $- != *i* ]] && return

shopt -s checkwinsize expand_aliases histappend extglob autocd

unalias -a

alias sudo='sudo '
alias cp='cp -i -b'
alias gdb='gdb -q'
alias ip='ip --color=always'
alias ls='LC_COLLATE=C ls --color=auto --group-directories-first'
alias mv='mv -i -b'
alias rm='rm -I'

alias e='${EDITOR:-vi}'
alias l='ls -la'
alias m=make
alias o='setsid xdg-open'
alias py=python3
alias q=qalc
alias th='gio trash'

case $TERM in *-256color)
	if [ $EUID -ne 0 ]; then
		PS1='\[\033[31m\]$exitcode\[\033[1;34m\]\W\[\033[0m\]\[\033[33m\]%\[\033[0m\] '
	else
		PS1='\[\033[31m\]$exitcode\w\$\[\033[0m\] '
	fi
	PS1="\[\e]0;\u@\h\a\]$PS1"
	;;
*)
	PS1='$exitcode\w \$ '
esac

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
