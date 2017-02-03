if [ -d /usr/share/bin ]; then
    export PATH=/usr/share/bin:$PATH
fi

if [ -d $HOME/.devtools/vendor/bin ]; then
    export PATH=$HOME/.devtools/vendor/bin:$PATH
fi

if [ -d $HOME/.devtools/node_modules/.bin ]; then
    export PATH=$HOME/.devtools/node_modules/.bin:$PATH
fi

if [ -d $HOME/.gem/ruby/2.3.0/bin ]; then
    export PATH=$HOME/.gem/ruby/2.3.0/bin:$PATH
fi

if [ -d $HOME/.gem/ruby/2.4.0/bin ]; then
    export PATH=$HOME/.gem/ruby/2.3.0/bin:$PATH
fi

if [ -f /usr/share/nvm/init-nvm.sh ]; then
    source /usr/share/nvm/init-nvm.sh
fi
