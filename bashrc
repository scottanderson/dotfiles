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
                              -e 's/3c07547b91d8/shakezula/' \
                              -E 's/\.ant\.amazon\.com//'
    echo -ne "\007"
}
export PROMPT_COMMAND='promptCommand'

if [[ "$(uname -s)" == "Darwin" ]]; then
    alias vim='mvim -v'
    alias vi='mvim -v'
fi
