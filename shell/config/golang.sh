if [ -e $HOME/.goenv ]; then
  export PATH="$HOME/.goenv/bin:$PATH"
  eval "$(goenv init -)"
  export GOROOT="`echo $HOME`/.goenv/versions/$(goenv version)/"
fi

export GOPATH="$HOME/Code/go"
export PATH=$GOPATH/bin:$PATH

alias gopath='cd $GOPATH'
