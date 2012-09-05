#!/bin/sh

BASHEXT="$HOME/etc/bash-ext"

mv $HOME/.vim $HOME/.vim.bak
ln -s $BASHEXT/vim $HOME/.vim

mv $HOME/.vimrc $HOME/.vimrc.bak
ln -s $BASHEXT/vimrc $HOME/.vimrc

mv $HOME/.screenrc $HOME/.screenrc.bak
ln -s $BASHEXT/screenrc $HOME/.screenrc

cat $BASHEXT/bashrc.sample >> $HOME/.bashrc
source $HOME/.bashrc
