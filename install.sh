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



function install_if_does_not_exist {
    if [ "`cat /tmp/pip_freeze|grep $1|wc -l`" -eq "0" ]; then
        sudo pip install $1
    fi
}

# install_if_does_not_exist flake8
# install_if_does_not_exist ropevim
# install_if_does_not_exist pyflakes

#
# Create all the links
#
function warning_if_exists {
    if [ "$?" == 1 ]; then
        warning "$1 configuration already exists, remove it and try again!"
    else
        ok "$1 configurations installed"
    fi
}

ln -s $PWD/aliases ~/.aliases &>> /dev/null
warning_if_exists aliases

ln -s $PWD/bashrc ~/.bashrc &>> /dev/null
warning_if_exists bashrc

ln -s $PWD/exports ~/.exports &>> /dev/null
warning_if_exists exports

ln -s $PWD/functions ~/.functions &>> /dev/null
warning_if_exists functions

ln -s $PWD/gitconfig ~/.gitconfig &>> /dev/null
warning_if_exists gitconfig

ln -s $PWD/gitignore ~/.gitignore &>> /dev/null
warning_if_exists gitignore

ln -s $PWD/screenrc ~/.screenrc &>> /dev/null
warning_if_exists screenrc

ln -s $PWD/tmux.conf ~/.tmux.conf &>> /dev/null
warning_if_exists tmux

ln -s $PWD/tmuxinator ~/.tmuxinator &>> /dev/null
warning_if_exists tmuxinator

ln -s $PWD/vimrc ~/.vimrc &>> /dev/null
ln -s $PWD/vim ~/.vim &>> /dev/null
warning_if_exists vim
rm $HOME/.vim/vim  # just remove it, don't even bother checking

ln -s $PWD/zshrc ~/.zshrc &>> /dev/null
warning_if_exists zsh

ok "Configurations linked properly"

git submodule update --init --recursive
ok "Submodules installed & updated"
