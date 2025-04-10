#!/bin/sh

# NOTE: Allow 'non-free' and 'contrib' in order to get some GNU docs

set -e

apt install mg

apt autopurge \
    cheese \
    evolution \
    gnome-contacts \
    gnome-games \
    gnome-maps \
    gnome-music \
    gnome-weather \
    nano \
    synaptic \
    totem \
    vim-tiny \
    yelp \
    zutty

apt update && apt upgrade

apt install \
    anacron \
    apt-file \
    arch-install-scripts \
    bash-completion \
    bmake \
    bsdutils \
    build-essential \
    emacs-common-non-dfsg \
    emacs-gtk \
    fzf \
    gcc-12-doc \
    gdb \
    gimp \
    gpick \
    git \
    gparted \
    kruler \
    libsdl2-dev \
    ltrace \
    mpv \
    nasm \
    python-pygame-doc \
    python3-pygame \
    qalc \
    rename \
    scrot \
    shellcheck \
    strace \
    strace \
    testdisk \
    time \
    tmux \
    universal-ctags \
    vim-gtk3 \
    xclip \
    xorg-dev \
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
cp .bashrc .profile "$HOME"

runuser "$username" -c 'git ls-files'
