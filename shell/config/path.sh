# Path variables
if [ -d /usr/share/bin ]; then
    export PATH=/usr/share/bin:$PATH
fi

if [ -e $HOME/bin ]; then
  export PATH=$PATH:$HOME/bin
fi

if [ -d $HOME/.git-hooks ]; then
  export PATH=$HOME/.git-hooks:$PATH
fi
