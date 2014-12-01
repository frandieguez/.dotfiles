# Pl editor
export EDITOR="vim"

# oh-my-zsh confs
# This is the project page: https://github.com/robbyrussell/oh-my-zsh/
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="openhost"
plugins=(git git-flow git-extras ant symfony2 tmux safe-paste docker)
source $ZSH/oh-my-zsh.sh

setopt nocorrect_all

export TERM=screen-256color

# Force activation on venvs
cd .

if [ -e $HOME/.goenv ]; then
    export PATH="$HOME/.goenv/bin:$PATH"
    eval "$(goenv init -)"
    export GOROOT="`echo $HOME`/.goenv/versions/$(goenv version)/"
fi


# Avoid zsh to complain about bg processes
setopt NO_HUP
setopt NO_CHECK_JOBS


CHRUBY_PATH="/usr/local/share/chruby/chruby.sh"
if [ -e "$CHRUBY_PATH" ]; then
    source $CHRUBY_PATH
fi

. /etc/zsh_command_not_found
#. ~/Temp/z/z.sh

# Add powerline support
#source '/usr/lib/python2.7/dist-packages/powerline/bindings/zsh/powerline.zsh'

# Load external configuration files
for file in ~/.{extra,exports,aliases,functions,profile}; do
    [ -r "$file" ] && source "$file"
done
unset file