# Filesystem operations
if [[ $platform == 'linux' ]]; then
  alias ls='ls --color=auto'
  alias l='ls -lF --color=auto'
  alias ll='ls -alF --color=auto'
elif [[ $platform == 'macos' ]]; then
  alias ls='ls -G'
  alias l='ls -lFG'
  alias ll='ls -AlFG'
fi

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias md='mkdir -p'
alias du='du -kh'       # Makes a more readable output.
alias df='df -kTh'

# Other
alias h='history -1000'
alias wi='type -a'
alias path='echo -e ${PATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'
alias mnt='mount | column -t | sort -k 3 -d'
alias rebash='source ~/.bashrc'
alias sz='source ~/.zshrc'
alias vz='vim ~/.zshrc'

# Python
alias mkv='mkvirtualenv --distribute --no-site-packages'

# Git
alias gs='git status --ignore-submodules=dirty'
alias gb='git branch'
alias gl='git lg'

alias tt='traceroute'
alias sr='tmux attach || tmux'
