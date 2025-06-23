PATH=$HOME/.local/bin:$HOME/.misc/scripts:$PATH
export FZF_DEFAULT_OPTS=--no-color

if command -v vim >/dev/null; then
	export EDITOR=vim
fi

if command -v svim >/dev/null; then
	export SUDO_EDITOR=svim
fi

if [ -f ~/.profile.local ]; then
	. ~/.profile.local
fi

if [ -n "$BASH_VERSION" ]; then
	if [ -f "$HOME/.bashrc" ]; then
		. "$HOME/.bashrc"
	fi
fi

if [ $(id -u) -ne 0 ]; then
	if [ -d /var/lib/flatpak/exports/bin ]; then
		PATH="$PATH:/var/lib/flatpak/exports/bin"
	fi

	if [ -f ~/.xinitrc ] && [ -z "$DISPLAY" ] && [ "$(tty)" = '/dev/tty5' ]; then
		exec xinit -- :5 vt05 > "${XDG_CACHE_HOME:-$HOME/.cache}"/xinit.log 2>&1
	fi
fi
