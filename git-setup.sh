#!/bin/sh

INSTALL_DIR="$HOME/.dotfiles"

# Globally exclude some files
git config --global alias.st 'status --short --branch'
git config --global alias.last "log -1 HEAD"
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.it '!git init && git commit -m “root” --allow-empty'

git config --global alias.lg "log --graph --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%cr)%C(reset) %C(white)%s%C(reset) %C(bold white)— %cn%C(reset)%C(bold yellow)%d%C(reset)' --abbrev-commit --date=relative"
git config --global alias.lga "log --graph --all --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%cr)%C(reset) %C(white)%s%C(reset) %C(bold white)— %cn%C(reset)%C(bold yellow)%d%C(reset)' --abbrev-commit --date=relative"

git config --global color.ui always
git config --global color.diff always

# allow only --ff-only merges
git config --global merge.ff true
