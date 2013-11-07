#!/bin/sh
# This file contains only zsh shell-specific settings

setopt COMPLETE_IN_WORD

setopt prompt_subst
unsetopt correctall

# Appends every command to the history file once it is executed
setopt inc_append_history
# Reloads the history whenever you use it
setopt share_history

HISTSIZE=1000
if (( ! EUID )); then
  HISTFILE=~/.history_root
else
  HISTFILE=~/.history
fi
SAVEHIST=1000

# Load and run compinit
autoload -U compinit
compinit -i

# bind ESC-v to full-screen vim editing of command line
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

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

precmd() { 
  vcs_info
  print -rP "%F{red}%n%{$reset_color%}@%F{blue}%m %{$reset_color%}%F{yellow}%~ $VENV%F{blue}"'${vcs_info_msg_0_}'"%{$reset_color%}"
}

export PROMPT="%# "
export RPROMPT=""
export LPROMPT=""

PATH=$PATH:/usr/local/share/python

