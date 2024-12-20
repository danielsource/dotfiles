#!/bin/sh

set -e

if [ "$(id -u)" -ne 0 ]; then
	echo "Must be root" >&2
	exit 1
fi

echo kernel.dmesg_restrict=0 > /etc/sysctl.d/local.conf

### Debian only ###
if . /etc/os-release && [ "$ID" = debian ]
then
cat <<'EOF' > /etc/apt/preferences.d/block_contrib
Package: *
Pin: release o=Debian,a=stable,l=Debian,c=contrib
Pin-Priority: -1
EOF

cat <<'EOF' > /etc/apt/preferences.d/block_non-free
Package: *
Pin: release o=Debian,a=stable,l=Debian,c=non-free
Pin-Priority: -1
EOF

cat <<'EOF' > /etc/apt/preferences.d/allow_docs
Package: manpages-posix
Pin: release o=Debian,a=stable,l=Debian,c=non-free
Pin-Priority: 600

Package: manpages-posix-dev
Pin: release o=Debian,a=stable,l=Debian,c=non-free
Pin-Priority: 600

Package: gcc-doc
Pin: release o=Debian,a=stable,l=Debian,c=contrib
Pin-Priority: 600

Package: gcc-doc-base
Pin: release o=Debian,a=stable,l=Debian,c=contrib
Pin-Priority: 600

Package: gcc-12-doc
Pin: release o=Debian,a=stable,l=Debian,c=non-free
Pin-Priority: 600

Package: cpp-doc
Pin: release o=Debian,a=stable,l=Debian,c=contrib
Pin-Priority: 600

Package: cpp-12-doc
Pin: release o=Debian,a=stable,l=Debian,c=non-free
Pin-Priority: 600

Package: gdb-doc
Pin: release o=Debian,a=stable,l=Debian,c=non-free
Pin-Priority: 600
EOF

apt-add-repository contrib non-free

fi
### END Debian only ###

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
	synaptic \
	totem \
	vim-tiny \
	yelp \
	zutty

apt install \
	apt-file \
	arch-install-scripts \
	bash-completion \
	bmake \
	build-essential \
	cpp-doc \
	curl \
	feh \
	ffmpeg \
	fzf \
	gcc-doc \
	gdb \
	gdb-doc \
	gimp \
	git \
	gparted \
	gpick \
	imagemagick \
	kruler \
	libnotify-bin \
	libsdl2-dev \
	ltrace \
	manpages-posix \
	manpages-posix-dev \
	mat2 \
	mpv \
	nasm \
	ncal \
	playerctl \
	python-pygame-doc \
	python3-pip \
	python3-pygame \
	qalc \
	rename \
	scrot \
	shellcheck \
	strace \
	suckless-tools \
	testdisk \
	time \
	tmux \
	tree \
	universal-ctags \
	unzip \
	xclip \
	xdg-utils \
	xxd \
	zip

if [ -z "$1" ]; then
	exit
fi
username=$1

cd /home/"$username"

if ! [ -d .git ]; then
	[ -f .config/user-dirs.dirs ] && mv .config/user-dirs.dirs .config/user-dirs.dirs.bak
	rm -f .bashrc .profile
	runuser "$username" -c 'git init -b main'
	runuser "$username" -c 'git remote add origin https://github.com/danielsource/dotfiles.git'
	runuser "$username" -c 'git pull --set-upstream origin main'
fi

cp .bashrc .profile /etc/skel
cp .profile "$HOME/.profile"
sed 's/32m/31m/' .bashrc > "$HOME/.bashrc"
cp .bin/svim /usr/local/bin/svim

runuser "$username" -c 'git ls-files'
