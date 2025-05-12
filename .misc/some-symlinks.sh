#!/bin/sh

set -e

cd "$(dirname "$0")"

mkdir -p ~/.config
ln -sr user-dirs.dirs ~/.config

mkdir -p ~/.config/fontconfig
ln -sr fonts.conf ~/.config/fontconfig

mkdir -p ~/.local/share/xfce4/terminal/colorschemes
ln -sr xfce4-terminal.theme ~/.local/share/xfce4/terminal/colorschemes/Theme.theme
