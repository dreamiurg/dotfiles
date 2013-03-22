# This file contains common functions. See bashrc and zshrc for
# shell-specific functions and settings.

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
