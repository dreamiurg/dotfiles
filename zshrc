#!/bin/sh

if [[ -d $HOME/.dotfiles.d ]]; then
  for script in $HOME/.dotfiles.d/*; do
    # echo "Running $script ..."
    source $script
  done
fi

# ---------------------------------------------------------------------
# Options
# ---------------------------------------------------------------------

setopt COMPLETE_IN_WORD

setopt prompt_subst
unsetopt correctall

# Appends every command to the history file once it is executed
setopt inc_append_history
# Reloads the history whenever you use it
setopt share_history

# ---------------------------------------------------------------------
# Modules
# ---------------------------------------------------------------------

# Colors
autoload -U colors
colors

# Completion system
autoload -U compinit
compinit -i

# Bind ESC-v to full-screen vim editing of command line
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# ---------------------------------------------------------------------
# Env variables
# ---------------------------------------------------------------------

# Detect current OS
platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
    platform='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
    platform='macos'
fi

# save root history in a separate file
HISTSIZE=1000
if (( ! EUID )); then
    HISTFILE=~/.history_root
else
    HISTFILE=~/.history
fi
SAVEHIST=1000

EDITOR=vim

# ---------------------------------------------------------------------
# Aliases
# ---------------------------------------------------------------------

# Filesystem operations
if [[ $platform == 'linux' ]]; then
    alias ls='ls --color=always'
    alias l='ls -alF --color=always'
elif [[ $platform == 'macos' ]]; then
    alias ls='ls -G'
    alias l='ls -alFG'
fi

# File system operations
alias cp='cp -i' # confirm overwrite
alias rm='rm -i' # confirm
alias mv='mv -i'
alias md='mkdir -p'

# Information
alias df='df -kTh' 
alias du='du -kh' # 1024-byte blocks + Gb/Mb suffix; 
alias mnt='mount | column -t | sort -k 3 -d'

# Paths
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'
alias path='echo -e ${PATH//:/\\n}'

# Viewers
alias less='less -r'
alias more='less -r'

# Python
if [ -f /usr/local/bin/virtualenvwrapper.sh ] ; then
  source /usr/local/bin/virtualenvwrapper.sh
  alias mkv='mkvirtualenv'
fi

# Git
alias gs='git st'
alias gl='git lg'
alias gla='git lga'

# Astyle FTW!
alias astyle='astyle --indent=spaces=2 --attach-namespaces --attach-classes --attach-inlines --indent-switches --indent-preproc-define --pad-oper --pad-header --align-pointer=type --align-reference=type --add-brackets --max-code-length=120 --break-after-logical'

# Network
alias tt='traceroute'
alias sr='tmux attach || tmux'

# Misc
alias h='history -1000'
alias wi='type -a'
alias sz='source ~/.zshrc' 
alias vz='vim ~/.zshrc' 

# ---------------------------------------------------------------------
# Functions
# ---------------------------------------------------------------------
function extract()      # Handy Extract Program.
{
    if [ -f $1 ] ; then
        case $1 in
            *.jar)       jar -xf $1      ;;
            *.tar.bz2)   tar xvjf $1     ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1      ;;
            *.rar)       unrar x $1      ;;
            *.gz)        gunzip $1       ;;
            *.tar)       tar xvf $1      ;;
            *.tbz2)      tar xvjf $1     ;;
            *.tgz)       tar xvzf $1     ;;
            *.zip)       unzip $1        ;;
            *.Z)         uncompress $1   ;;
            *.7z)        7z x $1         ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

function wii () {
    which $1 | xargs ls -l
}

function psgrep() { ps axuf | grep -v grep | grep "$@" -i --color=auto; }


# ---------------------------------------------------------------------
# Platform detection
# ---------------------------------------------------------------------

# set up zsh completions
if [[ $platform == 'macos' ]]; then
    if [[ -d $(brew --prefix)/share/zsh-completions ]]; then
        fpath=($(brew --prefix)/share/zsh-completions $fpath)
    fi
fi

# ---------------------------------------------------------------------
# Prompt
# ---------------------------------------------------------------------

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

PROMPT="%# "
RPROMPT=""
LPROMPT=""

# ---------------------------------------------------------------------
# PATH
# ---------------------------------------------------------------------

if [[ $platform == 'macos' ]]; then
    PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH
fi
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

