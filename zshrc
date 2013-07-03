#!/bin/sh
# This file contains only zsh shell-specific settings

setopt COMPLETE_IN_WORD

setopt prompt_subst
unsetopt correctall

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
if [[ $platform == 'macos' ]]; then
  if [ -d $(brew --prefix)/share/zsh-completions ]; then
    fpath=($(brew --prefix)/share/zsh-completions $fpath)
  fi
fi

if [ -f /usr/local/share/python/virtualenvwrapper.sh ]; then
  source /usr/local/share/python/virtualenvwrapper.sh
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

function __venv_ps1 ()
{
  local VENV=""
  if [ -n "$VIRTUAL_ENV" ]; then
    v=`basename "${VIRTUAL_ENV}"`
    printf -- "${1}" "$v"
  fi
}

VENV="%F{red}\$(__venv_ps1 '[ve:%s] ')"
# disable prompt modification by default ~/.virtualenv/<envname>/bin/activate
VIRTUAL_ENV_DISABLE_PROMPT=1

PROMPT="╭─ %F{green}%n@%m %{$reset_color%}%F{yellow}%~ $VENV%F{blue}"'${vcs_info_msg_0_}'"
%{$reset_color%}╰─$ "
RPROMPT=""
LPROMPT=""

PATH=$PATH:/usr/local/share/python

# Set up vi mode
#bindkey -M vicmd '^R' history-incremental-search-backward
#function zle-line-init zle-keymap-select {
#    RPROMPT="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
#    zle reset-prompt
#}
#zle -N zle-line-init
#zle -N zle-keymap-select

