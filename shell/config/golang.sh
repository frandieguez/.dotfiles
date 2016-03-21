if [ -e $HOME/.goenv ]; then
  export PATH="$HOME/.goenv/bin:$PATH"
  eval "$(goenv init -)"
  export GOROOT="`echo $HOME`/.goenv/versions/$(goenv version)/"
fi

export GOPATH="$HOME/Projects/go"
export PATH=$GOPATH/bin:$PATH
export GO15VENDOREXPERIMENT=1
