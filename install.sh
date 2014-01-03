#!/bin/sh

INSTALL_DIR="$HOME/.dotfiles"

mv $HOME/.vim $HOME/.vim.bak
ln -s $INSTALL_DIR/vim $HOME/.vim

mv $HOME/.vimrc $HOME/.vimrc.bak
ln -s $INSTALL_DIR/vimrc $HOME/.vimrc

mv $HOME/.screenrc $HOME/.screenrc.bak
ln -s $INSTALL_DIR/screenrc $HOME/.screenrc

mv $HOME/.tmux.conf $HOME/.tmux.conf.bak
ln -s $INSTALL_DIR/tmux.conf $HOME/.tmux.conf

cat $INSTALL_DIR/bashrc.sample >> $HOME/.bashrc
