#!/bin/bash
git submodule update --init
git config --global core.excludesfile '~/.cvsignore'
for f in cvsignore screenrc vim vimrc; do
    source="$HOME/.$f"
    target="dotfiles/$f"
    if [ -e $source ]; then
        if [ "$(readlink $source)" = "$target" ]; then
            echo "$f already installed"
            continue
        fi
        echo $source exists, moving it to $source.bak
        mv $source $source.bak
    fi
    mkdir -p $(dirname $source)
    ln -sf $target $source
    echo "$f installed"
done
