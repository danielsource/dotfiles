# shellcheck shell=sh

umask 077

export EDITOR=/usr/bin/vim
export FZF_DEFAULT_OPTS='--no-color'
export NEWT_MONO=1
export LS_COLORS='su=30;41:ow=30;42'

if [ -n "$BASH_VERSION" ]; then
	if [ -f "$HOME/.bashrc" ]; then
		. "$HOME/.bashrc"
	fi
fi

if [ -d "$HOME/bin" ]; then
	PATH=$HOME/bin:$PATH
fi

if [ -d "$HOME/.local/bin" ]; then
	PATH=$PATH:$HOME/.local/bin
fi

if [ -d /var/lib/flatpak/exports/bin ]; then
	PATH=$PATH:/var/lib/flatpak/exports/bin
fi

if [ -f ~/docs/env.sh ]; then
	. ~/docs/env.sh
fi
