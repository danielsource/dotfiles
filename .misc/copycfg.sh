#!/bin/sh

set -e

trycopy() {
	dst="$1"
	basen="$(basename "$1")"
	src="${basen#.}"
	if [ ! -e "$dst" ]; then
		echo "creating: $dst from $src"
		mkdir -p "$(dirname "$dst")"
		sed \
			-e "s|%DOWNLOAD%|$(xdg-user-dir DOWNLOAD)|" \
			-e "s|%DOCUMENTS%|$(xdg-user-dir DOCUMENTS)|" \
			"$src" > "$dst"
	else
		diff -U 0 --color "$src" "$dst" && echo "exists: $dst"
	fi
	return 0
}

cd "$(dirname "$0")"

trycopy ~/.xinitrc

trycopy "${XDG_CONFIG_HOME:-$HOME/.config}"/user-dirs.dirs

trycopy "${XDG_CONFIG_HOME:-$HOME/.config}"/fontconfig/fonts.conf

trycopy "${XDG_CONFIG_HOME:-$HOME/.config}"/zathura/zathurarc

trycopy "${XDG_DATA_HOME:-$HOME/.local/share}"/xfce4/terminal/colorschemes/xfce4-terminal.theme
