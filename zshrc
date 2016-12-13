bindkey -v

source ~/.zgen/zgen.zsh

if ! zgen saved; then
  zgen oh-my-zsh
  zgen oh-my-zsh plugins/git
  zgen oh-my-zsh plugins/archlinux
  zgen oh-my-zsh plugins/bower
  zgen oh-my-zsh plugins/colored-man-pages
  zgen oh-my-zsh plugins/colorize
  zgen oh-my-zsh plugins/composer
  zgen oh-my-zsh plugins/git
  zgen oh-my-zsh plugins/git-extras
  zgen oh-my-zsh plugins/git-flow
  zgen oh-my-zsh plugins/history
  zgen oh-my-zsh plugins/redis-cli
  zgen oh-my-zsh plugins/sublime
  zgen oh-my-zsh plugins/thefuck
  zgen oh-my-zsh plugins/tmux
  zgen oh-my-zsh plugins/tmuxinator
  zgen oh-my-zsh plugins/vagrant
  zgen oh-my-zsh plugins/vi-mode
  zgen oh-my-zsh plugins/wd
  zgen oh-my-zsh plugins/web-search
  #zgen oh-my-zsh themes/murilasso

  zgen load zsh-users/zsh-syntax-highlighting
  zgen load zsh-users/zsh-autosuggestions

  zgen load zsh-users/zsh-history-substring-search

  zgen load /home/fran/.zsh/oh-my-zsh-themes/frandieguez-v1.zsh-theme

  zgen save
fi

# Load zsh configuration
for file in ~/.zsh/(config|functions)/*; do
    source "$file"
done

# Aliases
if [ -f ~/.aliases ]; then
    source ~/.aliases;
fi

# Load zsh configuration
for file in ~/.zsh/(config|functions)/*; do
    source "$file"
done

# Aliases
if [ -f ~/.profile ]; then
    source ~/.profile;
fi
