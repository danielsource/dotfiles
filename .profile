umask 077

export EDITOR=/usr/bin/vim

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
