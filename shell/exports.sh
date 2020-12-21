# export JAVA_HOME='/Library/Java/JavaVirtualMachines/amazon-corretto-15.jdk/Contents/Home'
if [ -d /usr/lib/jvm/default-runtime ]; then
  export JAVA_HOME=/usr/lib/jvm/default-runtime
fi
export GEM_HOME="$HOME/.gem"
export GOPATH="$HOME/.go"

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
    --color=fg:#e5e9f0,bg:#3b4252,hl:#81a1c1
    --color=fg+:#e5e9f0,bg+:#3b4252,hl+:#81a1c1
    --color=info:#eacb8a,prompt:#bf6069,pointer:#b48dac
    --color=marker:#a3be8b,spinner:#b48dac,header:#a3be8b
    --reverse'

export path=(
  "$HOME/bin"
  "$DOTLY_PATH/bin"
  "$DOTFILES_PATH/bin"
  "$JAVA_HOME/bin"
  "$GEM_HOME/bin"
  "$GOPATH/bin"
  "$HOME/.cargo/bin"
  "$HOME/.gem/ruby/2.7.0/bin"
  "$HOME/.composer/vendor/bin"
  "$HOME/.config/yarn/global/node_modules/.bin/"
  "/usr/local/opt/ruby/bin"
  "/usr/local/opt/python/libexec/bin"
  "/usr/local/bin"
  "/usr/local/sbin"
  "/bin"
  "/usr/bin"
  "/usr/sbin"
  "/sbin"
)

# Editor  ------------------------------------------
if type nvim >/dev/null; then
  export VIM="nvim"
else
  export VIM="vim"
fi
export EDITOR=$VIM
export VISUAL=$VIM
alias vim=$VIM

# Language -----------------------------------------
export LC_ALL=en_US.UTF-8
export LC_COLLATE=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8
export LC_MONETARY=en_US.UTF-8
export LC_NUMERIC=en_US.UTF-8
export LC_TIME=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# Set the vim runtime for nvim
if [ -x "$(command -v nvim)" ]; then
  # export VIMRUNTIME=$(find /usr/share -type d -name runtime 2> /dev/null|grep nvim |head -1)
  export VIMRUNTIME=/usr/share/nvim/runtime
fi

if [[ -n "${NVIM_LISTEN_ADDRESS}" ]]; then
  # TODO update the path each time Vim has a major upgrade
  export VIMRUNTIME=/usr/share/vim/vim81
fi
