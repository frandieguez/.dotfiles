#!/bin/bash

# Install oh-my-zsh
if [ ! -d ~/.oh-my-zsh ]; then
    git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    echo "oh-my-zsh installed"
fi

# Install vim fonts
if [ ! -d ~/.fonts ]; then
  echo "Installing patched fonts..."
  git clone https://github.com/Lokaltog/powerline-fonts.git ~/.fonts
  fc-cache -vf
fi

# Create symlinks
files=`ls | sed -e "/\(install.sh\)/d"`
for file in $files; do
    if [ $file != "LICENSE" ] && [ $file != "README.md" ] \
       && [ ! -f ~/.$file ] && [ ! -d ~/.$file ]; \
    then
        echo "Symlinking $file..."
        ln -s $PWD/$file ~/.$file
    fi
done;

# Install oh-my-zsh themes
for i in frandieguez-v1 frandieguez-v2; do
  if [ ! -f ~/.oh-my-zsh/themes/$i.zsh-theme  ]; then
    echo "Installing oh-my-zsh theme: "$i
    ln -s ~/.zsh/oh-my-zsh-themes/$i.zsh-theme ~/.oh-my-zsh/themes/
  fi
done

# Install Vundle and vim plugins
if [ ! -d ~/.vim/bundle/vundle  ]; then
  echo "Installing Vundle for vim.."
  git clone https://github.com/gmarik/Vundle.vim ~/.vim/bundle/vundle

  vim -c BundleInstall -c q
fi;

if [ ! -d ~/.tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Ask for user and email for gitconfig
if [ ! -f ~/.gitconfig-additional  ]; then
  read -e -p "Do you want to add your credentials to your .gitconfig? (Y/n) " q

  if [ "$q" == "Y"  ] || [ "$q" == "y"  ] || [ "$q" == ""  ]; then
    read -e -p "Name: " username
    read -e -p "Email: " email

    echo "[user]" >> ~/.gitconfig-additional
    echo "    name = " $username >> ~/.gitconfig-additional
    echo "    email = " $email >> ~/.gitconfig-additional
  fi
fi
