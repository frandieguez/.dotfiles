# Editor  ------------------------------------------
export EDITOR=vim
export VISUAL=vim

# Use neovim if available
if type nvim > /dev/null; then
    export EDITOR=nvim
    alias vim=nvim
fi

# Language
export LC_ALL=en_US.UTF-8
export LC_COLLATE=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8
export LC_MONETARY=en_US.UTF-8
export LC_NUMERIC=en_US.UTF-8
export LC_TIME=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
