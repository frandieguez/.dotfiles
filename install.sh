#!/bin/bash

# Install oh-my-zsh
if [ ! -f ~/.git-prompt.sh ]; then
    wget -O ~/.git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh > /dev/null
    echo "git-prompt.sh installed"
fi

# Install oh-my-zsh
if [ ! -d ~/.zgen ]; then
    echo "Installing zgen..."
    git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
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

# Custom links for neovim
if type nvim > /dev/null; then
  if [ ! -d ~/.config/nvim  ]; then
    echo "Symlinking ~/.config/nvim..."
    ln -s ~/.vim ~/.config/nvim
  fi

  if [ ! -f ~/.config/nvim/init.vim  ]; then
    echo "Symlinking ~/.config/nvim/init.vim..."
    ln -s ~/.vimrc ~/.config/nvim/init.vim
  fi
fi

# Install vim plugins
echo "Installing vim plugins..."
vim -c PlugInstall -c q -c q

# Install neovim plugins
if type nvim > /dev/null; then
  echo "Installing neovim plugins..."
  nvim -c PlugInstall -c q -c q
fi

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

echo "All DONE"
