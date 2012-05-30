# Filesystem
alias l='ls -alFG --color'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias md='mkdir -p'
alias du='du -kh'       # Makes a more readable output.
alias df='df -kTh'

# Other
alias h='history'
alias j='jobs -l'
alias which='type -a'
alias path='echo -e ${PATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'
alias psu='ps -o pid,rss,command -w'
alias more=less
alias mnt='mount | column -t | sort -k 3 -d'

# Python
alias mkv='mkvirtualenv --distribute --no-site-packages' 

# Git
alias gs='git status'
alias gb='git branch'
alias gl='git lg1'
