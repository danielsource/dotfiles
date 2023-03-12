#
# ~/.bashrc
#

# shellcheck shell=bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ -z "$FUNCNEST" ]] && export FUNCNEST=100 # limits recursive functions, see 'man bash'

# This command disables the annoying default behavior of 'Ctrl-s', which
# causes the terminal to freeze and become unresponsive.
stty -ixon

maybe_run() {
    cmd=$1
    shift 1
    if command -v "$cmd" >/dev/null; then
        "$cmd" "$@"
    fi
}

command_not_found_handle() {
    local pkgfile_out
    echo "$(basename -- "$0"): $1: command not found"
    if command -v pkgfile >/dev/null; then
        if pkgfile_out=$(pkgfile "$1") || [ -n "$pkgfile_out" ]; then
            printf '\n%s\n%s\n' \
                "Packages that may provide this command:" "$pkgfile_out"
        fi
    fi
}

pro() {
    pro_src() {
        cd "$1" || return $?
        if [ -r "./.user/env.sh" ]; then
            echo "Sourcing ./.user/env.sh" >&2
            source "./.user/env.sh"
        fi
    }
    local projects_dir="${XDG_PUBLICSHARE_DIR:-$HOME}"
    local project
    for project in "$projects_dir"/*; do
        if [ "$PWD" = "$project" ]; then
            pro_src "$project"
            return $?
        fi
    done
    if [ "$1" = - ]; then
        return
    fi
    if [ -z "$1" ]; then
        cd "$projects_dir" && l
        return $?
    fi
    pro_src "$projects_dir/$1"
    unset pro_src
}

PS1='\[\e]0;\W\a\]\[\e[30;106m\]($?) \W \$\[\e[0m\] '

HISTSIZE=10000
HISTFILESIZE=20000

printf '\x1b[6;1 q'

shopt -s autocd

if [ -r ~/.bash_aliases ]; then
    # shellcheck source=.bash_aliases
    source ~/.bash_aliases
fi

pro -
