export EDITOR=vim
alias vi='vim'
alias v="vim"

if type nvim > /dev/null; then
    export EDITOR=nvim
    alias vim=nvim
fi
