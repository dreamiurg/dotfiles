# sets global env options

export TERM=xterm-256color
export EDITOR=vim

if [[ $platform == 'macos' ]]; then
  export PATH=$HOME/.rvm/bin:/usr/local/bin:/usr/bin:/bin:/sbin:$PATH
fi
