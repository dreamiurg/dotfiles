#!/bin/sh
# 
# This file contains settings specific for bash shell
#

function __define_colors
{
  # Configure Colors:
  BLACK='\[\033[0;30m\]'
  BLUE='\[\033[0;34m\]'
  LIGHTBLUE='\[\033[1;34m\]'
  BROWN='\[\033[0;33m\]'
  LIGHTBROWN='\[\033[1;33m\]'
  CYAN='\[\033[0;36m\]'
  LIGHTCYAN='\[\033[1;36m\]'
  GRAY='\[\033[1;30m\]'
  LIGHTGRAY='\[033[0;37m\]'
  GREEN='\[\033[0;32m\]'
  LIGHTGREEN='\[\033[1;32m\]'
  PINK='\[\033[1;35m\]'
  PURPLE='\[\033[0;35m\]'
  RED='\[\033[0;31m\]'
  LIGHTRED='\[\033[1;31m\]'
  WHITE='\[\033[1;37m\]'
  YELLOW='\[\033[0;33m\]'
  LIGHTYELLOW='\[\033[1;33m\]'
  DEFAULT='\[\033[0m\]'
}

function __venv_ps1 ()
{
	local VENV=""
	if [ -n "$VIRTUAL_ENV" ]; then
		v=`basename "${VIRTUAL_ENV}"`
		printf -- "${1}" "$v"
	fi
}

function __set_prompt ()
{
  local USER="${GREEN}\u@\h"
  local DIR="${YELLOW}\w"
	local VENV="${RED}\$(__venv_ps1 '[ve:%s] ')"
  local GIT="${BLUE}\$(__git_ps1 '[git:%s] ')"
	local END="${DEFAULT}"
	
  export PS_SHORT="${USER}:${DIR} ${VENV}${GIT}${END}\\$ "
  export PS_LONG="\n${USER} ${DIR} ${VENV}${GIT}${END}\n$ "
  export PS1=$PS_SHORT
	
  # disable prompt modification by default ~/.virtualenv/<envname>/bin/activate
	export VIRTUAL_ENV_DISABLE_PROMPT=1
}

function long.prompt() {
  export PS1=$PS_LONG
}

function short.prompt() {
  export PS1=$PS_SHORT
}

# this script dir
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# load custom settings and functions
source $DIR/env.sh
source $DIR/functions.sh
source $DIR/aliases.sh

# Filesystem operations
if [[ $platform == 'macos' ]]; then
  if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
  fi
fi

# define colors and set prompt
__define_colors
__set_prompt

