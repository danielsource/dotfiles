#umask 022

export FZF_DEFAULT_OPTS=--no-color
export EDITOR=vim
export SUDO_EDITOR=svim

if [ -n "$BASH_VERSION" ]; then
	if [ -f "$HOME/.bashrc" ]; then
		. "$HOME/.bashrc"
	fi
fi

if [ -d "$HOME/.bin" ]; then
	PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ]; then
	PATH="$HOME/.local/bin:$PATH"
fi

if [ -d /var/lib/flatpak/exports/bin ]; then
	PATH="$PATH:/var/lib/flatpak/exports/bin"
fi

if [ -z "$DISPLAY" -a "$(tty)" = '/dev/tty5' ]; then
	exec xinit -- :5 vt05 2> ~/.cache/xinit-err.txt
fi
