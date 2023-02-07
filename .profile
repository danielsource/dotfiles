#
# ~/.profile
#

# shellcheck shell=sh

chpath() {
    case ":$PATH:" in
    *:"$1":*) ;;
    *)
        if [ -d "$1" ]; then
            PATH=$2
        fi
        ;;
    esac
}

append_path() { chpath "$1" "$PATH:$1"; }
prepend_path() { chpath "$1" "$1:$PATH"; }

export ABDUCO_CMD=bash
export EDITOR=nvim
export FZF_DEFAULT_COMMAND='command find . ! \( -path "*/.git/*" -o -path "./.var/app/*" \)'
export FZF_DEFAULT_OPTS='--layout=reverse --no-color'
export LESS='-iR --incsearch --mouse'
export MOZ_USE_XINPUT2=1
export PAGER=less
export SUDO_EDITOR=vi
export TERMINAL=konsole
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_DATA_HOME="$HOME"/.local/share

prepend_path ~/bin
append_path ~/.local/bin

# If running bash, source ~/.bashrc.
if [ -n "$BASH_VERSION" ]; then
    if [ -r "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi
