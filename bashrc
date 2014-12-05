#!/bin/bash
# This file isn't installed by setup.sh because it's a stub. I've currently got too many things that
# are machine specific. When I get around to cleaning that up, I will add it to setup.sh.
export EDITOR=vim
export PROMPT_COMMAND='echo -ne "\033]0;${PWD/$HOME/~}\007"'
function promptCommand() {
    echo -ne "\033]0;"
    echo -n $USER@
    echo -n ${HOSTNAME} | sed -e 's/ud4bed98a954c5314f099/scoander-dp/' \
                              -e 's/u5cf9dd78212b5347288a/igor-sea/' \
                              -e 's/ud4bed98a91a8539b5fe6/igor2/' \
                              -e 's/3c07547b91d8/shakezula/' \
                              -e 's/\.ant\.amazon\.com//'
    echo -ne "\007"
}
export PROMPT_COMMAND='promptCommand'

if [[ "$(uname -s)" == "Darwin" ]]; then
    alias vim='mvim -v'
    alias vi='mvim -v'
fi

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
