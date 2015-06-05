# Pl editor
export EDITOR="vim"

# oh-my-zsh confs
# This is the project page: https://github.com/robbyrussell/oh-my-zsh/
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="openhost"
plugins=(
    bower
    bundler
    capistrano
    common-aliases
    compleat
    composer
    debian
    docker
    git
    git-extras
    git-flow
    golang
    jira
    npm
    safe-paste
    sublime
    symfony2
    systemd
    tmux
    tmuxinator
    vagrant
)
source $ZSH/oh-my-zsh.sh

setopt nocorrect_all
setopt no_rm_star_silent
unalias rm # dont prompt on every removal

# export TERM=screen-256color

# Force activation on venvs
cd .

# Avoid zsh to complain about bg processes
setopt NO_HUP
setopt NO_CHECK_JOBS


CHRUBY_PATH="/usr/local/share/chruby/chruby.sh"
if [ -e "$CHRUBY_PATH" ]; then
    source $CHRUBY_PATH
fi

#. /etc/zsh_command_not_found

# Add powerline support
#source '/usr/lib/python2.7/dist-packages/powerline/bindings/zsh/powerline.zsh'

# Load external configuration files
for file in ~/.{aliases,extra,exports,functions,profile}; do
    [ -r "$file" ] && source "$file"
done
unset file
