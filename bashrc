#!/bin/bash
# This file isn't installed by setup.sh because it's a stub. I've currently got too many things that
# are machine specific. When I get around to cleaning that up, I will add it to setup.sh.

export PATH=~/bin:$PATH

for f in ~/.bashrc-local \
         /etc/bash_completion.d/git-prompt \
         /usr/local/etc/bash_completion.d/git-completion.bash \
         /usr/local/etc/bash_completion.d/git-prompt.sh
do
    test -f $f && source $f
done

function __git_prompt() {
    if [ -n "$(git rev-parse --git-dir 2>/dev/null)" ]; then
        local gs_wd=$(git diff --no-ext-diff --quiet --exit-code; echo $?);
        local gs_i=$(git diff-index --cached --quiet HEAD --; echo $?);
        if [ $gs_wd = 0 ]; then
            if [ $gs_i = 0 ]; then
                local gs_untracked=$(! git ls-files --others --exclude-standard --error-unmatch -- '*' > /dev/null 2> /dev/null; echo $?);
                if [ $gs_untracked = 0 ]; then
                    local color="\033[01;31m"; #red
                else
                    local color="\033[35m";
                fi;
            else
                local color="\033[01;33m"; # yellow
            fi;
        else
            if [ $gs_i = 0 ]; then
                local color="\033[01;32m"; # green
            else
                if [ "$(uname -s)" = "Darwin" ]; then
                    local color="\033[33;41m";
                else
                    local color="\033[33;45m";
                fi;
            fi;
        fi;
        color="$2${color}$3";
        __git_ps1 " "$color"%s";
        return;
    fi
}

if [ "$PS1" = '${debian_chroot:+($debian_chroot)}\u@\h:\w\$ ' ] || \
   [ "$PS1" = '\h:\W \u\$ ' ]; then
    COLOR_RED="\033[01;31m"
    COLOR_GREEN="\033[01;32m"
    COLOR_YELLOW="\033[01;33m"
    COLOR_BLUE="\033[01;34m"
    COLOR_NONE="\033[00m"

    PS1='${debian_chroot:+($debian_chroot)}'
    PS1=$PS1"\[${COLOR_GREEN}\]\\u@\$(promptHost)"
    PS1=$PS1"\[${COLOR_NONE}\]:"
    PS1=$PS1"\[${COLOR_BLUE}\]\\w"
    PS1=$PS1"\$(__git_prompt ' "\[${COLOR_RED}\]"%s' \[ \])"
    PS1=$PS1"\[${COLOR_NONE}\]\\$ "
fi

export CLICOLOR=1
export EDITOR=vim

function setTitle() {
    case "$TERM" in
    screen*)
        # Screen window title
        printf '\ek%s\e\\' "$1"
        # Terminal window title
        printf '\e]0;%s\007' "$2"
        ;;
    xterm*)
        # Terminal window title
        printf '\e]0;%s\007' "$1"
        ;;
    esac
}

# http://stackoverflow.com/a/5687619
function shortPath() {
    echo -n "${PWD/#$HOME/~}" | awk -F / '{
        if (length($0) > 14) { if (NF>4) print $1 "/" $2 "/.../" $(NF-1) "/" $NF;
                               else if (NF>3) print $1 "/" $2 "/.../" $NF;
                               else print $1 "/.../" $NF; }
        else print $0; }'
}

function promptCommand() {
    local PRIMARY
    if [ -n "$(git rev-parse --show-toplevel 2>/dev/null)" ]; then
        PRIMARY=$(basename $(git rev-parse --show-toplevel))
    else
        PRIMARY=$(shortPath)
    fi
    local SECONDARY="$USER@$(promptHost) - $PRIMARY"
    if [ "$USER" = root ]; then
        PRIMARY='[!] '"$PRIMARY"
        SECONDARY='[!] '"$SECONDARY"
    fi
    setTitle "$PRIMARY" "$SECONDARY"
}

function promptHost() {
    echo -n ${HOSTNAME} | sed -e 's/ud4bed98a954c5314f099/scoander-dp/' \
                              -e 's/u5cf9dd78212b5347288a/igor-sea/' \
                              -e 's/ud4bed98a91a8539b5fe6/igor2/' \
                              -e 's/60f81db91c86/shakezula/' \
                              -e 's/\.ant\.amazon\.com//'
}
export PROMPT_COMMAND='promptCommand'
export PS1=$(echo "$PS1" | sed 's/\\h/$(promptHost)/')

# Set the screen title to the hostname once on login
case "$TERM" in
screen) ;&
screen-256color)
    echo -ne "\033k$(promptHost)\033\\"
    ;;
esac

if [[ "$(uname -s)" == "Darwin" ]]; then
    which mvim &> /dev/null || {
        alias vim='mvim -v'
        alias vi='mvim -v'
    }
fi

# Merica
LANG=en_US.UTF-8

# Erase duplicate commands in history
export HISTCONTROL="erasedups:ignoreboth"

# Ignore commands prefixed by space
export HISTCONTROL="${HISTCONTROL}:ignorespace"

# Make the history file much bigger
export HISTFILESIZE=500000
export HISTSIZE=100000

# No need to remember the exit command
export HISTIGNORE="&:[ ]*:exit"

# Prevent bash overwriting history on exit
shopt -s histappend

# Save multi-line commands to the history as one command
shopt -s cmdhist

# OS X (if you're not using vi mode), you'll want to reset <CTRL>-S from being scroll stop. This prevents bash from being able to interpret it as forward search.
if [[ "$(uname -s)" == "Darwin" ]]; then
    stty stop ""
fi
