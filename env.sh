# Detect current OS
platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
  platform='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
  platform='macos'
fi

# sets global env options

export TERM=xterm-256color
export EDITOR=vim

if [[ $platform == 'macos' ]]; then
  export PATH=$HOME/.rvm/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin
fi
