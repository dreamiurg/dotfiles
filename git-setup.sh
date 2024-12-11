#!/bin/bash

# User information
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
git config --global user.signingkey "ID of gpg key"

# Aliases
git config --global alias.st "status --short --branch"
git config --global alias.last "log -1 HEAD"
git config --global alias.co "checkout"
git config --global alias.br "branch"
git config --global alias.it '!git init && git commit -m “root” --allow-empty'
git config --global alias.lg "log --graph --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%cr)%C(reset) %C(white)%s%C(reset) %C(bold white)— %cn%C(reset)%C(bold yellow)%d%C(reset)' --abbrev-commit --date=relative"
git config --global alias.lga "log --graph --all --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%cr)%C(reset) %C(white)%s%C(reset) %C(bold white)— %cn%C(reset)%C(bold yellow)%d%C(reset)' --abbrev-commit --date=relative"

# Color settings
git config --global color.ui "always"
git config --global color.diff "always"

# Merge settings
git config --global merge.ff "true"
git config --global merge.conflictStyle "zdiff3"

# Push settings
git config --global push.autoSetupRemote "true"
git config --global commit.gpgSign "true"

# Core settings
git config --global core.pager "delta"

# Interactive settings
git config --global interactive.diffFilter "delta --color-only"

# Delta settings
git config --global delta.navigate "true"

# Conditional include for specific directory
# git config --global includeIf.gitdir:~/src/xxx/.path "~/src/xxx/.gitconfig"
