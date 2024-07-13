if [ -d ~/.bashrc.d ]; then
    for file in ~/.bashrc.d/*.sh ; do
        . "$file"
    done
    unset file
fi

[[ $- != *i* ]] && return

shopt -s checkwinsize histappend extglob autocd
stty -ixon # disable Ctrl-s freeze

unalias -a

alias gdb='gdb -q'
alias ls='LC_COLLATE=C ls --color --group-directories-first'
alias o='setsid xdg-open'
alias ox='exec setsid xdg-open'
alias py=python3
alias q=qalc
alias th='gio trash'

# system information
function inf {
    uname -sr
    uptime | sed 's/ //'
    sensors 2>/dev/null | awk '/Tctl:/{print "CPU temp:\t"$2}'
    printf 'Memory in use:\t' && free -m | awk '/Mem/{print $3+$5"M"}'
    df -h | awk '/\/$/{print "Storage:\t"$3"/"$2" ("$5")"}'
    term=$(readlink "/proc/$(cat /proc/$(echo $$)/stat | cut -d ' ' -f 4)/exe")
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

truecolortest() {
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

# bc calc shorthand
function cl {
    echo "scale=5; $@" | bc
}

# python doc
function pyd {
    if [ $# -ne 1 ]; then
        return 1
    fi
    python3 -c "help('$1')"
}

NOTES=~/Documents/notes.txt
# take a note
function n {
    if [ -z "$1" ]; then
        ns
    else
        if ! [ -f "$NOTES" ]; then
            echo '[n]' >> "$NOTES"
        fi
        date=$(date '+%a.%d.%m %H:%M')
        echo "$date | $@" >> "$NOTES"
    fi
}

# display notes
function ns {
    if ! [ -f "$NOTES" ]; then
        echo "No notes (file missing)." 2>&1
        return 1
    fi

    local lines
    if [ -z "$1" ]; then
        lines="10"
    else
        lines="$1"
    fi
    sed '1,/^\[n\]$/ d' "$NOTES" | tail -n "$lines"
}

function datediff {
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

PS1='${exitcode}\W\$ '

PROMPT_COMMAND='exitcode=$?; if [ $exitcode -ne 0 ]; then exitcode="$exitcode "; else unset exitcode; fi'

export PS1 PROMPT_COMMAND HISTSIZE=10000 HISTFILESIZE=200000

if ! shopt -oq posix && [ "$TERM" != dumb ]; then
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

    if command -v __git_ps1 >/dev/null; then
        PS1='`__git_ps1 "(\e[1;31m%s\e[0m) "`'$PS1

        if shopt -q login_shell && [ "$(basename "$PWD")" = repos ]; then
            for r in `find */ -type d -name .git`; do
                r=${r%/.git}
                printf '[\e[1;34m%s\e[0m] on \e[1;31m%s\e[0m\n' "$r" "$(git -C "$r" branch --show-current)"
                git -C "$r" status -s
                printf '\n'
            done
        fi
    fi

    export FZF_CTRL_T_COMMAND="${FZF_CTRL_T_COMMAND:-"command find -L . -mindepth 1 \\( -path '*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' -o -path '*/dosdevices/*' \\) -prune \
        -o -type f -print \
        -o -type d -print \
        -o -type l -print 2> /dev/null | cut -b3-"}"

    export FZF_ALT_C_COMMAND="${FZF_ALT_C_COMMAND:-"command find -L . -mindepth 1 \\( -path '*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' -o -path '*/dosdevices/*' \\) -prune \
        -o -type d -print 2> /dev/null | cut -b3-"}"
fi
