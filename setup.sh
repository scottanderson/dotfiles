#!/bin/bash
git submodule update --init
git config --global alias.l "log --graph --abbrev-commit --decorate --date=relative --format='%C(auto)%h - %C(bold green)(%ar)%C(reset)%C(auto) %s - %C(bold)%an%C(reset)%C(auto)%d'"
git config --global core.excludesfile '~/.cvsignore'
git config --global url.ssh://git@github.com/.pushinsteadof git://github.com/
git config --global url.ssh://git@github.com/.pushinsteadof https://github.com/
for f in bashrc cvsignore screenrc vim vimrc; do
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
