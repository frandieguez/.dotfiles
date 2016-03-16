#!/bin/bash

GREEN='\e[0;32m'
RED='\e[0;31m'
RESET='\e[0m' # No Color
PWD=`pwd`

function ok {
    echo -e "[${GREEN} OK ${RESET}] $1"
}

function warning {
    echo -e "[${RED} WARNING ${RESET}] $1"
}

#
# Install oh-my-zsh
#
if [ ! -d ~/.oh-my-zsh ]; then
    git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    ok "oh-my-zsh installed"
else
    warning "~/.oh-my-zsh already exists, remove it and try again!"
fi

ok "Installing oh-my-zsh themes"
ln -s $PWD/oh-my-zsh-themes/frandieguez-v1.zsh-theme ~/.oh-my-zsh/themes/
ln -s $PWD/oh-my-zsh-themes/frandieguez-v2.zsh-theme ~/.oh-my-zsh/themes/

#
# Install vim fonts
#
if [ ! -d ~/.fonts ]; then
    git clone https://github.com/Lokaltog/powerline-fonts.git ~/.fonts
    fc-cache -vf
    ok "vim fonts installed"
else
    warning "You already have some personal fonts, install the vim fonts manually: https://github.com/Lokaltog/powerline-fonts"
fi

# Install Vundle and vim plugins
if [ ! -d ~/.vim/bundle/vundle  ]; then
  echo "Installing Vundle for vim.."
  git clone https://github.com/gmarik/Vundle.vim ~/.vim/bundle/vundle

  echo "Installing vim plugins..."
  vim -c BundleInstall -c q
else
  cd vim/bundle/vundle;
  git pull;
  cd ../../..;
fi;

# Install powerline configuration
#
if [ ! -d ~/.config/powerline ]; then
    ln -s $PWD/powerline ~/.config/powerline
    ok "Powerline configurations installed"
else
    warning "There is a powerline configuration folder already installed"
fi

# Create symlinks
files=`ls | sed -e "/\(install.sh\)/d"`
for file in $files; do
    if [ $file != "LICENSE" ] && [ ! -f ~/.$file ] && [ ! -d ~/.$file ]; then
        echo "Symlinking $file..."
        ln -s $PWD/$file ~/.$file
    fi
done;

# Install shell config files
ln -s $PWD/zshrc ~/.zshrc &> /dev/null
ln -s $PWD/bashrc ~/.bashrc &> /dev/null
ln -s $PWD/shell-configs/aliases ~/.aliases &> /dev/null
ln -s $PWD/shell-configs/profile ~/.profile &> /dev/null
ln -s $PWD/shell-configs/functions ~/.functions &> /dev/null
ln -s $PWD/shell-configs/exports ~/.exports &> /dev/null
ln -s $PWD/gitconfig ~/.gitconfig &> /dev/null
ln -s $PWD/gitignore ~/.gitignore &> /dev/null
ln -s $PWD/screenrc ~/.screenrc &> /dev/null
ln -s $PWD/tmux.conf ~/.tmux.conf &> /dev/null
ln -s $PWD/vimrc ~/.vimrc &> /dev/null
ln -s $PWD/vim ~/.vim &> /dev/null

ok "Configurations linked properly"

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

if [ ! -f ~/.gitconfig-additional ]; then
  cp $PWD/gitconfig-additional ~/.gitconfig-additional &> /dev/null
fi

