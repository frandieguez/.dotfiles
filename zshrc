# oh-my-zsh confs

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="openhost"
#ZSH_THEME="frandieguez"
#ZSH_THEME="robbyrussell"

plugins=(
    bower
    bundler
    capistrano
    common-aliases
    compleat
    composer
    docker
    git
    git-extras
    git-flow
    golang
    jira
    npm
    safe-paste
    symfony2
    systemd
    systemadmin
    tmux
    tmuxinator
    vagrant
    vi-mode
)

# User configuration

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

JIRA_RAPID_BOARD=true
export JAVA_HOME=/usr/lib/jvm/default-runtime

bindkey -v
