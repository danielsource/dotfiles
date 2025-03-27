export EDITOR=vim
export FZF_DEFAULT_OPTS=--no-color

if [ -d "$HOME/.local/bin" ]; then
    PATH=$PATH:$HOME/.local/bin
fi

if [ -d /var/lib/flatpak/exports/bin ]; then
    PATH=$PATH:/var/lib/flatpak/exports/bin
fi

if [ -n "$BASH_VERSION" ]; then
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi
