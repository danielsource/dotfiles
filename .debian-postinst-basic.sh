#!/bin/sh

set -e

apt update && apt upgrade

apt install vim-gtk3

apt autopurge \
	evolution \
	gnome-contacts \
	gnome-games \
	gnome-maps \
	gnome-music \
	gnome-text-editor \
	gnome-weather \
	nano \
	synaptic \
	totem \
	vim-tiny \
	yelp \
	zutty

apt install \
	anacron \
	apt-file \
	arch-install-scripts \
	bash-completion \
	bmake \
	bsdutils \
	build-essential \
	fzf \
	gdb \
	gimp \
	git \
	gparted \
	gpick \
	kruler \
	libsdl2-dev \
	ltrace \
	mat2 \
	mpv \
	nasm \
	python-pygame-doc \
	python3-pygame \
	qalc \
	rename \
	scrot \
	shellcheck \
	strace \
	testdisk \
	time \
	tmux \
	universal-ctags \
	xclip \
	xorg-dev \
	xxd \
	zenity

if [ -z "$1" ]; then
	exit
fi
username=$1

cd /home/"$username"

if ! [ -d .git ]; then
	rm -f .bashrc .profile
	runuser "$username" -c 'git init -b main'
	runuser "$username" -c 'git remote add origin https://github.com/danielsource/dotfiles.git'
	runuser "$username" -c 'git pull --set-upstream origin main'
fi

cp .bashrc .profile /etc/skel
cp .profile "$HOME/.profile"
sed 's/32m/31m/' .bashrc > "$HOME/.bashrc"

runuser "$username" -c 'git ls-files'
