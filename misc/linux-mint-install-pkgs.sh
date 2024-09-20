#!/bin/sh

set -ev

# Distro related utilities
apt install -y\
    apt-file\
    arch-install-scripts\
    localepurge

# Development tools
apt install -y\
    build-essential\
    clang\
    clang-tools\
    tcc\
    gdb\
    bmake\
    nasm\
    valgrind\
    kcachegrind\
    python3-venv\
    libsdl2-dev\
    libsdl2-doc\
    manpages\
    manpages-dev\
    manpages-posix\
    manpages-posix-dev\
    gh\
    swi-prolog\
    gprolog

# CLI utilities
apt install -y\
    vim-gtk3\
    mg\
    git\
    fzf\
    tmux\
    htop\
    stow\
    ncal\
    qalc\
    tree\
    cloc\
    ascii\
    figlet\
    xclip\
    xdotool\
    scrot\
    ripgrep\
    rename\
    shellcheck\
    util-linux-extra\
    syncthing\
    stress

# Multimedia & graphics
apt install -y\
    ffmpeg\
    yt-dlp\
    mpv\
    vlc\
    obs-studio\
    imagemagick\
    gimp\
    zathura-pdf-poppler\
    zathura

# Other GUI utilities
apt install -y\
    catfish\
    gnome-clocks\
    keepassxc\
    kdeconnect\
    redshift\
    gpick\
    dconf-editor\
    kruler\
    gource\
    fonts-mononoki\
    gnome-characters
