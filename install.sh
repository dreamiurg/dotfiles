#!/bin/sh

INSTALL_DIR="$HOME/.dotfiles"
DOTFILES=(vim vimrc screenrc tmux.conf zshrc)

for F in ${DOTFILES[@]}; do
    mv $HOME/.$F $HOME/.$F.bak
    ln -s $INSTALL_DIR/$F $HOME/.$F
done

