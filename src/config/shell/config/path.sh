# Array that will contain the list of paths --------
PATH_ARRAY=()

# Android ------------------------------------------
if [ -e $HOME/Code/Android ]; then
  export ANDROID_HOME=$HOME/Code/Android
  export ANDROID_SDK_ROOT=$HOME/Code/Android
  PATH_ARRAY+=$ANDROID_HOME/tools
  PATH_ARRAY+=$ANDROID_HOME/platform-tools
fi

# Composer -----------------------------------------
PATH_ARRAY+=$HOME/.composer/vendor/bin

# Node.js ------------------------------------------
PATH_ARRAY+=$HOME/.config/yarn/global/node_modules/.bin/

if [ -f /usr/share/nvm/init-nvm.sh ]; then
    source /usr/share/nvm/init-nvm.sh
fi


# GitHooks -----------------------------------------
PATH_ARRAY+=$HOME/.git-hooks/

# Golang ------------------------------------------
PATH_ARRAY+=$HOME/.goenv/bin

export GOPATH="$HOME/Code/go"
PATH_ARRAY+=$GOPATH/bin

if [ -e $HOME/.goenv ]; then
  eval "$(goenv init -)"
  export GOROOT="`echo $HOME`/.goenv/versions/$(goenv version)/"
fi

alias gopath='cd $GOPATH'

# Java --------------------------------------------
if [ -d /usr/lib/jvm/default-runtime ]; then
  export JAVA_HOME=/usr/lib/jvm/default-runtime
fi

# Local .bin folder -------------------------------
PATH_ARRAY+=$HOME/.bin

# Path variable -----------------------------------
PATH_ARRAY+=/usr/share/bin

# Ruby --------------------------------------------
if [[ -d ~/.gem/ruby ]]; then
    for i in $(ls -1 --color=never ~/.gem/ruby); do
        if [[ -d "$HOME/.gem/ruby/$i/bin" ]]; then
            PATH_ARRAY+=$HOME/.gem/ruby/$i/bin
        fi
    done;
fi

# Add the list of paths into $PATH
for i in "${PATH_ARRAY[@]}"
do
    export PATH=$PATH:$i
done
