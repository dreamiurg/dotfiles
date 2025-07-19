#!/usr/bin/env zsh

if [[ -d "$HOME/.dotfiles.d" ]]; then
  for script in "$HOME/.dotfiles.d"/*; do
    [ -f "$script" ] && source "$script"
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
case "$(uname)" in
  Linux)   platform='linux' ;;
  Darwin)  platform='macos' ;;
  *)       platform='unknown' ;;
esac

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
fi

# Git
export GIT_EDITOR='vim'
alias gs='git status'
alias gl='git lg'
alias gla='git lga'
alias gb='git branch'

function git_delete_merged_branches {
  git fetch --all
  git branch --merged master --no-color | \
    grep -v "\* master" | xargs -n 1 git branch -d
}
alias git-delete-merged-branches=git_delete_merged_branches

# Astyle FTW!
alias astyle='astyle --indent=spaces=2 \
  --attach-namespaces --attach-classes --attach-inlines \
  --indent-switches --indent-preproc-define \
  --pad-oper --pad-header --align-pointer=type \
  --align-reference=type --add-brackets \
  --max-code-length=120 --break-after-logical'

# Network
alias tt='traceroute'

# Misc
alias sr='tmux attach || tmux'
alias h='history -1000'
alias wi='type -a'
alias sz='source ~/.zshrc' 
alias vz='vim ~/.zshrc' 

# ---------------------------------------------------------------------
# Functions
# ---------------------------------------------------------------------
# Handy extract program
extract() {
  local file=$1
  if [[ -f "$file" ]]; then
    case "$file" in
      *.jar)     jar -xf "$file"      ;;
      *.tar.bz2) tar xvjf "$file"     ;;
      *.tar.gz)  tar xvzf "$file"     ;;
      *.bz2)     bunzip2 "$file"      ;;
      *.rar)     unrar x "$file"      ;;
      *.gz)      gunzip "$file"       ;;
      *.tar)     tar xvf "$file"      ;;
      *.tbz2)    tar xvjf "$file"     ;;
      *.tgz)     tar xvzf "$file"     ;;
      *.zip)     unzip "$file"        ;;
      *.Z)       uncompress "$file"   ;;
      *.7z)      7z x "$file"         ;;
      *)         echo "'$file' cannot be extracted via >extract<" ;;
    esac
  else
    echo "'$file' is not a valid file"
  fi
}

wii() {
  which -- "$1" | xargs ls -l
}

unextract() {
  if [[ $# -ne 1 ]]; then
    echo "Usage: unextract <directory>"
    return 1
  fi

  local dir="$1"
  local zipfile="${dir%/}.zip"

  if [[ ! -d "$dir" ]]; then
    echo "Error: '$dir' is not a directory"
    return 1
  fi

  echo "Zipping '$dir' into '$zipfile'..."
  zip -r "$zipfile" "$dir"
}

function wii () {
    which $1 | xargs ls -l
}

psgrep() {
  ps axuf | grep -v grep | grep -i --color=auto "$@"
}


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
zstyle ':vcs_info:*' enable hg git 

zstyle ':vcs_info:*' unstagedstr '*'
zstyle ':vcs_info:*' stagedstr '+'

zstyle ':vcs_info:(hg*|git*):*' get-revision true
zstyle ':vcs_info:(hg*|git*):*' check-for-changes true

# rev+changes branch misc
zstyle ':vcs_info:hg*' formats "[%s:%i%F{red}%u%F{blue} %b %m]"
zstyle ':vcs_info:hg*' actionformats "[%s|%a:%i%F{red}%u%F{blue} %b %m]"

# hash changes branch misc
zstyle ':vcs_info:git*' formats "[%s:%12.12i %F{red}%u%F{blue} %b %m]"
zstyle ':vcs_info:git*' actionformats "[%s|%a:%12.12i %F{red}%u%F{blue} %b %m]"

zstyle ':vcs_info:hg*:netbeans' use-simple true

zstyle ':vcs_info:hg*:*' get-bookmarks true

zstyle ':vcs_info:hg*:*' get-mq true
zstyle ':vcs_info:hg*:*' get-unapplied true
zstyle ':vcs_info:hg*:*' patch-format "mq(%g):%n/%c %p"
zstyle ':vcs_info:hg*:*' nopatch-format "mq(%g):%n/%c %p"

zstyle ':vcs_info:hg*:*' unstagedstr "+"
zstyle ':vcs_info:hg*:*' hgrevformat "%r" # only show local rev.
zstyle ':vcs_info:hg*:*' branchformat "%b" # only show branch

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

PROMPT="%(?.%#.%F{red}%#%{$reset_color%}) "
RPROMPT=""
LPROMPT=""

# ---------------------------------------------------------------------
# pyenv
# ---------------------------------------------------------------------
export PYENV_ROOT="$HOME/.pyenv"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"

# ---------------------------------------------------------------------
# PATH
# ---------------------------------------------------------------------
if [[ $platform == 'macos' ]]; then
    PATH="$PYENV_ROOT/shims:/usr/local/bin:/usr/local/sbin:$PATH"
fi

PATH=$HOME/bin:$HOME/.tfenv/bin:$PATH

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ---------------------------------------------------------------------
# z.sh (only if the file exists)
# ---------------------------------------------------------------------
if [[ -f /usr/local/etc/profile.d/z.sh ]]; then
  . /usr/local/etc/profile.d/z.sh
fi

# ---------------------------------------------------------------------
# rbenv (only if installed)
# ---------------------------------------------------------------------
if command -v rbenv >/dev/null 2>&1; then
  export RBENV_ROOT=/usr/local/var/rbenv
  eval "$(rbenv init -)"
fi
