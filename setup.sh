#!/bin/bash
for f in .screenrc .vim .vimrc; do
    target="dotfiles/$f"
    if [ -e ~/$f ]; then
    if [ "$(readlink ~/$f)" = "$target" ]; then
        echo "$f already installed"
        continue
    fi
        echo $f exists, moving it to ~/$f.bak
        mv ~/$f ~/$f.bak
    fi
    mkdir -p $(dirname ~/$f)
    ln -sf $target ~/$f
done
