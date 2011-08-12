alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias md='mkdir -p'

alias h='history'
alias j='jobs -l'
alias which='type -a'
alias path='echo -e ${PATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'
alias more=less

alias du='du -kh'       # Makes a more readable output.
alias df='df -kTh'

alias psu='ps -o pid,rss,command -w'

alias l='ls -alFG'

alias mkv='mkvirtualenv --distribute --no-site-packages' 
alias gs='git status'
alias gl='git lg --all'
