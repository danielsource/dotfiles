#
# ~/.bashrc
#

unalias -a

case $- in *i*) ;; *) return ;; esac

if [ -d ~/.bashrc.d ]; then
    for file in ~/.bashrc.d/*.sh ; do
        . "$file"
    done
    unset file
fi

if [ -n "$BASH" ]; then
    shopt -s checkwinsize histappend extglob autocd

    case $TERM in dumb|emacs) ;; *)
        stty -ixon # disable Ctrl-s freeze

        if [ -f "${PREFIX:-/usr}"/share/bash-completion/bash_completion ]; then
            . "${PREFIX:-/usr}"/share/bash-completion/bash_completion
        elif [ -f /etc/bash_completion ]; then
            . /etc/bash_completion
        fi

        if [ -f /usr/share/doc/fzf/examples/key-bindings.bash ]; then
            . /usr/share/doc/fzf/examples/key-bindings.bash
        elif [ -f "${PREFIX:-/usr}"/share/fzf/key-bindings.bash ]; then
            . "${PREFIX:-/usr}"/share/fzf/key-bindings.bash
        fi

        if [ -f "${PREFIX:-/usr}"/share/bash-completion/completions/git ]; then
            . "${PREFIX:-/usr}"/share/bash-completion/completions/git
        fi

        if [ -f "${PREFIX:-/usr}"/share/git/git-prompt.sh ]; then
            . "${PREFIX:-/usr}"/share/git/git-prompt.sh
        fi

        if command -v __git_complete >/dev/null; then
            alias g=git; __git_complete g __git_main
            alias ga='git add'; __git_complete ga _git_add
            alias gb='git branch'; __git_complete gb _git_branch

            alias gc='git commit --no-edit --allow-empty-message'; __git_complete gc _git_commit
            alias gca='gc -a'; __git_complete gca _git_commit
            alias gcam='gc -a --amend --no-edit'; __git_complete gcam _git_commit

            alias gd='git diff'; __git_complete gd _git_diff
            alias gdw='gd --word-diff'; __git_complete gdw _git_diff

            alias gf='git fetch'; __git_complete gf _git_fetch
            alias gl='git log'; __git_complete gl _git_log
            alias gr='git remote'; __git_complete gr _git_remote
            alias gs='git status'; __git_complete gs _git_status
            alias gsh='git switch'; __git_complete gsh _git_switch
            alias gsw='git show'; __git_complete gsw _git_show
            alias gwc='git whatchanged'; __git_complete gwc _git_whatchanged
        fi

        if command -v __git_ps1 >/dev/null; then
            PS1='`__git_ps1 "(\[\e[1;31m\]%s\[\e[0m\]) "`'$PS1
        fi

        export FZF_CTRL_T_COMMAND="${FZF_CTRL_T_COMMAND:-"command find -L . \
            -mindepth 1 \
            \\( -path '*/\\.*' \
                -o -fstype 'sysfs' \
                -o -fstype 'devfs' \
                -o -fstype 'devtmpfs' \
                -o -fstype 'proc' \
                -o -path '*/dosdevices/*' \\) -prune \
            -o -type f -print \
            -o -type d -print \
            -o -type l -print 2>/dev/null | cut -b3-"}"

        export FZF_ALT_C_COMMAND="${FZF_ALT_C_COMMAND:-"command find -L . \
            -mindepth 1 \
            \\( -path '*/\\.*' -and -not -name .archive \
                -o -fstype 'sysfs' \
                -o -fstype 'devfs' \
                -o -fstype 'devtmpfs' \
                -o -fstype 'proc' \
                -o -path '*/dosdevices/*' \\) -prune \
            -o -type d -print 2>/dev/null | cut -b3-"}"
    ;;
    esac
fi

HISTSIZE=10000
HISTFILESIZE=200000
HISTCONTROL=ignorespace
PS1='${exitcode}\W\$ '
PROMPT_COMMAND='exitcode=$?; if [ $exitcode -ne 0 ]; then exitcode="$exitcode "; else unset exitcode; fi'
unset LS_COLORS

case "$TERM" in
xterm*|rxvt*|tmux*)
    PS1="\[\e]0;\u@\h\a\]$PS1"
    ;;
*)
    ;;
esac

alias gdb='gdb -q'
alias ls='LC_COLLATE=C ls --color --group-directories-first'
alias l='ls'
alias la='ls -la'
alias mk=bmake
alias o='open_file'
alias ox='exec setsid xdg-open'
alias pl='swipl -q'
alias py=python3
alias q=qalc
alias t='LC_COLLATE=C tree --filesfirst --gitignore --prune'
alias ta='t -a -I ".git"'
alias th='gio trash'

# text editor
function e {
    local editor
    for ed in "$EDITOR" vim vi mg nano; do
        if command -v "$ed" >/dev/null; then
            editor=$ed
            break
        fi
    done
    if [ -z "$editor" ]; then
        return 1
    fi
    case $1 in -*) $editor "$@"; return ;; esac
    dir=$(dirname "$1")
    mkdir -vp "$dir"
    $editor "$@"
}

# quick C snippet runner using TCC(1)
# Example: c 'printf("%u\n", (uint8_t)-1+1)'
function c {
    if [ $# -le 0 ]; then
        tcc -w -run - </dev/stdin
        return
    fi
    if [ -f "$1" ]; then
        ${CC:-tcc} -std=c99 -Wall -Wextra -Wpedantic -g -O0 -o "${1%%.c}" "$@"
        return
    fi
    local code=$1
    shift
    cat << EOF | sed "s/\`/'/g" | tcc -w -run - "$@"
#include <inttypes.h>
#include <limits.h>
#include <stddef.h>
#include <stdint.h>
int main(int argc, char **argv) {
    $code;
}
EOF
}

# bc calc shorthand
function cl {
    echo "scale=5; $*" | bc
}

function datediff {
    local d1 d2
    if [ $# -eq 1 ]; then
        d1="$(date +%s)" || return $?
    elif [ $# -ne 2 ]; then
        return 1
    else
        d1=$(date -d "$2" +%s) || return $?
    fi
    d2=$(date -d "$1" +%s) || return $?
    if [ $d1 -lt $d2 ]; then
        echo $(( (d2 - d1) / 86400 )) days
    else
        echo $(( (d1 - d2) / 86400 )) days
    fi
}

# system information
function inf {
    sh - << 'EOF'
if [ -f /etc/os-release ]; then
    . /etc/os-release
fi
printf '%s (kernel %s)\n' "$NAME" "$(uname -r)"
EOF
    uptime | sed 's/ //'
    sensors 2>/dev/null | awk '/Tctl:/{print "CPU temp:\t"$2}'
    printf 'Memory in use:\t' && free -m | awk '/Mem/{print $3+$5"M"}'
    df -h 2>/dev/null | awk '/\/$/{print "Storage:\t"$3"/"$2" ("$5")"}'
    local term=$(readlink "/proc/$(cat /proc/$(echo $$)/stat | cut -d ' ' -f 4)/exe")
    if [ -n "$term" ]; then
        printf 'Terminal:\t%s\n' "$term"
    fi
    acpi 2>/dev/null
    for i in {0..7}; do
        printf '\e[48;5;%sm %2d \e[0m ' $i $i
    done
    printf '\n'
    for i in {8..15}; do
        printf '\e[48;5;%sm %2d \e[0m ' $i $i
    done
    printf '\n'
}

# longest basename
function longbn {
    find "${1-.}" -path '*/.git' -prune -o -print | awk '
    BEGIN {
        max = 0;
        maxpath = "";
    } {
        n = split($0, s, /\//);
        bn = s[n];
        if (length(bn) > max) {
            max = length(bn);
            maxpath = $0;
        }
        sum += length(bn);
    } END {
        print "file:\t\t", maxpath, "\nlength:\t\t", max "\navg length:\t", sum/NR, "\ntotal files:\t", NR
    }'
}

function man_web {
    local base_url="http://man.he.net/?topic="
    local target_cmd="${1:?No command specified}"
    local target_url="${base_url}${target_cmd}&section=${2:-all}"
    curl -v --silent "${target_url}" 2>&1 | sed -n "/<PRE>/,/<\/PRE>/p"
}
if ! command -v man >/dev/null; then
    function man {
        local out=$(man_web "$@")
        [ -n "$out" ] && echo "$out" | less
    }
fi

function open_file {
    for arg; do
        setsid xdg-open "$arg"
    done
}

# python doc
function ph {
    if [ $# -ne 1 ]; then
        return 1
    fi
    python3 -c "help('$1')"
}

function truecolortest {
    awk 'BEGIN{
    s="/\\/\\/\\/\\/\\"; s=s s s s s s s s;
    for (colnum = 0; colnum<77; colnum++) {
        r = 255-(colnum*255/76);
        g = (colnum*510/76);
        b = (colnum*255/76);
        if (g>255) g = 510-g;
            printf "\033[48;2;%d;%d;%dm", r,g,b;
            printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
            printf "%s\033[0m", substr(s,colnum+1,1);
        }
        printf "\n";
    }'
}

# python virtual environment
function venv {
    local venv=$(find . -maxdepth 3 -type f -path './*/bin/activate' | sort | head -1)
    if [ -n "$venv" ]; then
        source "$venv"
    fi
}
if [ -z "$VIRTUAL_ENV" ] && ! [ -f ~/.cache/.no-venv ]; then
    venv
fi

function whichw {
    if [ $# -ne 1 ]; then
        return 1
    fi
    readlink -f "$(which "$1")"
}

function yt_mp3 {
    yt-dlp -x --audio-format mp3 "$@"
}
# Example: yt_mp3 <link> -o "%(artist)s - %(album)s - %(playlist_index)02d. %(title)s.%(ext)s"
