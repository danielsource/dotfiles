#
# ~/.profile
#

export PATH="$HOME/.local/bin:$HOME/bin:$PATH"
export FZF_DEFAULT_OPTS='--no-color'

if command -v /usr/bin/vim >/dev/null; then
    export EDITOR=/usr/bin/vim
fi

if command -v /usr/bin/rvim >/dev/null; then
    export SUDO_EDITOR=/usr/bin/rvim
fi

if [ -d ~/.profile.d ]; then
    for file in ~/.profile.d/*.sh ; do
        . "$file"
    done
    unset file
fi

if [ -f ~/.ashrc ]; then
    export ENV=~/.ashrc
fi

if [ -n "$BASH" ] && [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi
