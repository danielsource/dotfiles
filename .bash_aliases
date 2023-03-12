#
# ~/.bash_aliases
#

# shellcheck shell=bash

shopt -s expand_aliases

# Function definitions {{{
prompt_yes_or_no() {
    read -rep "${1-Continue?} [y/N]: " 2>&1
    [[ "$REPLY" == [Yy]* ]]
}

# shellcheck disable=SC2139
# Ignore the warning of expansion when defined
mkshortcut() {
    alias_dir() {
        if [[ -z "$1" ]]; then
            alias "$name=mkdir -vp $path && cd $path"
        else
            alias "$name=mkdir -vp $path && cd $path && eval '$*'"
        fi
    }
    alias_txt() {
        editor=${EDITOR:-vi}
        if [[ -z "$1" ]]; then
            alias "$name=$editor $path"
        else
            alias "$name=$editor $path && eval '$*'"
        fi
        alias "dir_$name=cd $(dirname "$path")"
    }
    if [[ $# -lt 2 ]]; then
        exit 2
    fi
    local name=$1
    local path=$2
    shift 2
    if [[ -d "$path" ]] || [[ "${path: -1}" = / ]]; then
        alias_dir "$@"
    else
        alias_txt "$@"
        name=${name//-/_}
        eval "dir_$name=$(dirname "$path")"
    fi
    eval "$name=$path"
    unset alias_dir alias_txt
}

_ls() {
    LC_COLLATE=C command ls --color=auto --group-directories-first "$@"
}

l() {
    local filecount=0 filefound optend
    for arg; do
        unset filefound
        case $arg in
            --) optend=1 ;;
            -*) [[ -n "$optend" ]] && filefound=1 ;;
            *) filefound=1 ;;
        esac
        if [[ -n "$filefound" ]]; then
            filecount=$((filecount + $(find "$arg" -maxdepth 1 | wc -l)
            - 1))
        fi
    done
    if [[ "$filecount" -eq 0 ]]; then
        filecount=$(($(find . -maxdepth 1 | wc -l) - 1))
    fi
    if [[ "$filecount" -ge "$((LINES - 1))" ]]; then
        _ls -Av "$@"
    else
        _ls -1Av "$@"
    fi
}

vf() {
    nvim -c "find $*"
}

open_files() {
    if command -v exo-open >/dev/null; then
        echo "exo-open $*" >&2
        setsid exo-open "$@" >& /dev/null
        return $?
    fi
    if command -v xdg-open >/dev/null; then
        for file in "$@" ; do
            echo "xdg-open $file" >&2
            setsid xdg-open "$file" >& /dev/null
        done
        return $?
    fi
    echo "${FUNCNAME[0]}: package 'xdg-utils' or 'exo' is required." >&2
    return 1
}
# }}}

alias E='exec '
alias R='exec $SHELL'
alias S='setsid '
alias a=abduco
alias cp='cp -i'
alias diff='diff --color=auto'
alias gdb='gdb -q'
alias gr='grep --exclude-dir=.git --exclude=tags -IRsnH'
alias grep='grep --color=auto'
alias ka=killall
alias ll='ls -lav'
alias ls='_ls'
alias md='mkdir -p'
alias mv='mv -i'
alias o=open_files
alias p=pwd
alias pm='sudo pacman'
alias q=qalc
alias rd=rmdir
alias rm='rm -I'
alias s='sudo '
alias se=sudoedit
alias t=tmux
alias tccrun='tcc -Wno-implicit-function-declaration -run -'
alias userenv='md .user && v .user/env.sh'
alias v=nvim

for f in \
    "${XDG_CONFIG_HOME:-$HOME/.config}/user-dirs.dirs" \
    /usr/share/doc/fzf/examples/key-bindings.bash \
    /usr/share/fzf/key-bindings.bash \
    /usr/share/git/completion/git-completion.bash
do
    if [[ -r "$f" ]]; then
        # shellcheck disable=SC1090
        # $f is a non-constant source
        source "$f"
    fi
done

mkshortcut aliases ~/.bash_aliases
mkshortcut bashrc ~/.bashrc
mkshortcut ci3 "${XDG_CONFIG_DIR:-$HOME}/.config/i3/config"
mkshortcut ci3b "${XDG_CONFIG_DIR:-$HOME}/.config/i3/i3blocks.conf"
mkshortcut cnvim "${XDG_CONFIG_DIR:-$HOME}/.config/nvim/init.vim"
mkshortcut dotf   "${XDG_DOCUMENTS_DIR:-$HOME}/dotfiles" git ls-tree -r --name-only HEAD
mkshortcut todo   "${XDG_DOCUMENTS_DIR:-$HOME}/TODO.txt"

# Alias g to git
if command -v __git_complete >/dev/null; then
    alias g=git
    __git_complete g __git_main
fi

#FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
#FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND -type d"
