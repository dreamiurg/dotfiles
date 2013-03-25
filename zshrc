#!/bin/sh
# This file contains only zsh shell-specific settings

setopt COMPLETE_IN_WORD                                                                                                             

# Load and run compinit
autoload -U compinit
compinit -i

# set up colors
autoload -U colors
colors

# load custom settings and functions
source $(dirname $0)/env.sh
source $(dirname $0)/functions.sh
source $(dirname $0)/aliases.sh

# set up completions
# Filesystem operations
if [[ $platform == 'macos' ]]; then
  if [ -d $(brew --prefix)/share/zsh-completions ]; then
    fpath=($(brew --prefix)/share/zsh-completions $fpath)
  fi
fi

# configure VCS prompt
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git 
zstyle ':vcs_info:*' unstagedstr '*'
zstyle ':vcs_info:*' stagedstr '+'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git*' formats "%F{blue}[%s:%b%F{red}%u%c%F{blue}] "
precmd() {
  vcs_info
}

# configure prompt
setopt prompt_subst
PROMPT="%{$fg[green]%}%n@%m%{$reset_color%}:%{$fg_no_bold[yellow]%}%~ %{$fg_no_bold[blue]%}"'${vcs_info_msg_0_}'"%{$reset_color%}%# "
RPROMPT=""
LPROMPT=""
