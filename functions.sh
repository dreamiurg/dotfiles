#
# This extenstion sets bash prompt to include 
#
function __define_colors
{
    # Configure Colors:
    WHITE='\[\033[1;37m\]'
    LIGHTGRAY='\[033[0;37m\]'
    GRAY='\[\033[1;30m\]'
    BLACK='\[\033[0;30m\]'
    RED='\[\033[0;31m\]'
    LIGHTRED='\[\033[1;31m\]'
    GREEN='\[\033[0;32m\]'
    LIGHTGREEN='\[\033[1;32m\]'
    BROWN='\[\033[0;33m\]'
    YELLOW='\[\033[1;33m\]'
    BLUE='\[\033[0;34m\]'
    LIGHTBLUE='\[\033[1;34m\]'
    PURPLE='\[\033[0;35m\]'
    PINK='\[\033[1;35m\]'
    CYAN='\[\033[0;36m\]'
    LIGHTCYAN='\[\033[1;36m\]'
    DEFAULT='\[\033[0m\]'
}

function __set_prompt
{
    export PS1="${GREEN}\u@\h:${BROWN}\w${LIGHTCYAN}"' $(__git_ps1 "(%s) ")'"${DEFAULT}\\$ "
}

function extract()      # Handy Extract Program.
{
    if [ -f $1 ] ; then
	case $1 in
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


