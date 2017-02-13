if [ -d $HOME/.devtools/vendor/bin ]; then
    export PATH=$HOME/.devtools/vendor/bin:$PATH
fi

if [ -d $HOME/.devtools/node_modules/.bin ]; then
    export PATH=$HOME/.devtools/node_modules/.bin:$PATH
fi
