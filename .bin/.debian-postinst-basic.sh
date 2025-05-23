#!/bin/sh

set -e

if [ "$(id -u)" -ne 0 ]; then
	echo "Must be root" >&2
	exit 1
fi

sysctl_conf=/etc/sysctl.d/local.conf
if [ ! -e "$sysctl_conf" ]; then
	echo "Creating $sysctl_conf"
	echo 'kernel.dmesg_restrict=0' > /etc/sysctl.d/local.conf
	echo
fi

motd_file=/etc/motd
if [ -e "$motd_file" ]; then
	echo "Moving $motd_file to $motd_file.bak"
	mv "$motd_file" "$motd_file.bak"
	echo
fi

### Debian only ###
if . /etc/os-release && [ "$ID" = debian ] && [ -n "$VERSION_ID" ]
then

echo "You are in $NAME $VERSION_ID"
echo

echo "Install software-properties-common to configure contrib and non-free exceptions"
apt install software-properties-common
echo "[END] Install software-properties-common"
echo

echo "Creating files at /etc/apt/preferences.d/ ..."

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

echo

echo "Add contrib and non-free"
apt-add-repository contrib non-free
echo "[END] Add contrib and non-free"
echo

fi
### END Debian only ###

echo "apt update && apt upgrade"
apt update && apt upgrade
echo "[END] apt update && apt upgrade"
echo

echo "Install my tools and goodies"
apt install \
	apt-file \
	arch-install-scripts \
	ascii \
	bash-completion \
	bmake \
	build-essential \
	cpp-doc \
	curl \
	feh \
	ffmpeg \
	fonts-inter \
	fonts-mononoki \
	fzf \
	gcc-doc \
	gdb \
	gdb-doc \
	gimp \
	git \
	gparted \
	gpg \
	gpick \
	imagemagick \
	kruler \
	libnotify-bin \
	libsdl2-dev \
	libx11-doc \
	ltrace \
	lxappearance \
	lynx \
	man-db \
	manpages \
	manpages-posix \
	manpages-posix-dev \
	mat2 \
	mpv \
	nasm \
	ncal \
	pavucontrol \
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
	vim-gtk3 \
	x11-xserver-utils \
	xclip \
	xdg-utils \
	xfce4-notifyd \
	xfce4-terminal \
	xinit \
	xinput \
	xorg-dev \
	xxd \
	zip
echo "[END] Install my tools and goodies"
echo

if [ -z "$1" ]; then
	echo "Skipping user setup. Bye!"
	exit
fi
username=$1

echo "USER is $username"
cd /home/"$username"

if [ ! -d .git ]; then
	[ -e .config/user-dirs.dirs ] && mv .config/user-dirs.dirs .config/user-dirs.dirs.bak
	rm -f .bashrc .profile

	repo_url=https://github.com/danielsource/dotfiles.git
	echo "Cloning $repo_url in user home"
	su "$username" -c 'git init -b main'
	su "$username" -c "git remote add origin $repo_url"
	su "$username" -c 'git pull --set-upstream origin main'
fi

echo "Copying bashrc and profile to /etc/skell and /root"
cp .bashrc .profile /etc/skel
cp .profile "$HOME/.profile"
sed 's/32m/31m/' .bashrc > "$HOME/.bashrc"

echo "Copying svim to system executables directory"
cp .bin/svim /usr/local/bin/svim

echo

echo "git ls-files"
su "$username" -c 'git ls-files'
echo

echo "Basic setup is done!"
