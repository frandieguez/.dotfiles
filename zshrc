# oh-my-zsh confs

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="frandieguez-v1"

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
  wd
)

# User configuration
source $ZSH/oh-my-zsh.sh

setopt nocorrect_all
setopt no_rm_star_silent
unalias rm # dont prompt on every removal

# Force activation on venvs
cd .

# Avoid zsh to complain about bg processes
setopt NO_HUP
setopt NO_CHECK_JOBS

#. /etc/zsh_command_not_found

# Add powerline support
#source '/usr/lib/python3.4/site-packages/powerline/bindings/zsh/powerline.zsh'

#bindkey -v
source ~/.profile
