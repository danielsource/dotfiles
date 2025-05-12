#!/bin/sh

set -e

cd "$(dirname "$0")"

cp xinitrc ~/.xinitrc

mkdir -p "${XDG_CONFIG_HOME:-$HOME/.config}"
cp user-dirs.dirs "${XDG_CONFIG_HOME:-$HOME/.config}"

mkdir -p "${XDG_CONFIG_HOME:-$HOME/.config}"/fontconfig
sed "s|%DOWNLOAD%|$(xdg-user-dir DOWNLOAD)|" fonts.conf > "${XDG_CONFIG_HOME:-$HOME/.config}"/fontconfig/fonts.conf

mkdir -p "${XDG_CONFIG_HOME:-$HOME/.config}"/zathura
cp zathurarc "${XDG_CONFIG_HOME:-$HOME/.config}"/zathura

mkdir -p "${XDG_DATA_HOME:-$HOME/.local/share}"/xfce4/terminal/colorschemes
cp xfce4-terminal.theme "${XDG_DATA_HOME:-$HOME/.local/share}"/xfce4/terminal/colorschemes
