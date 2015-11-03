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
    npm
    safe-paste
    symfony2
    systemd
    systemadmin
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


#. /etc/zsh_command_not_found

# Add powerline support
#source '/usr/lib/python3.4/site-packages/powerline/bindings/zsh/powerline.zsh'

# Load external configuration files
for file in ~/.{aliases,extra,exports,functions,profile}; do
    [ -r "$file" ] && source "$file"
done
unset file
