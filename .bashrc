if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
	PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi

export PATH

[[ $- != *i* ]] && return

shopt -s checkwinsize expand_aliases histappend extglob autocd

unalias -a
alias gdb='gdb -q'
alias ls='LC_COLLATE=C ls --color=auto --group-directories-first'
alias l='ls -la'
alias o='setsid xdg-open'
alias m=make

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

export PS1 PROMPT_COMMAND HISTSIZE=10000 HISTFILESIZE=20000 \
	FZF_DEFAULT_COMMAND='find .' \
	FZF_CTRL_T_COMMAND='find .' \
	FZF_ALT_C_COMMAND='find . -type d' \
	FZF_DEFAULT_OPTS='--no-color'

if ! shopt -oq posix && [ "$TERM" != dumb ]; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi

	if [ -f /usr/share/doc/fzf/examples/key-bindings.bash ]; then
		. /usr/share/doc/fzf/examples/key-bindings.bash
	fi
fi
