#!/bin/sh

set -e

cd "$(dirname "$0")"

cp xinitrc ~/.xinitrc

mkdir -p ~/.config
cp user-dirs.dirs ~/.config

mkdir -p ~/.config/fontconfig
cp fonts.conf ~/.config/fontconfig

mkdir -p ~/.local/share/xfce4/terminal/colorschemes
cp xfce4-terminal.theme ~/.local/share/xfce4/terminal/colorschemes/Theme.theme
