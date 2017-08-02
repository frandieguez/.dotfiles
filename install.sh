#!/bin/bash

# Install oh-my-zsh
if [ ! -f $HOME/.git-prompt.sh ]; then
    wget -O $HOME/.git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh > /dev/null
    echo "git-prompt.sh installed"
fi

# Install oh-my-zsh
if [ ! -d $HOME/.zgen ]; then
    echo "Installing zgen..."
    git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
fi

# Install patched fonts
if [ ! -d $HOME/.fonts ]; then
  echo "Installing patched fonts..."
  git clone https://github.com/Lokaltog/powerline-fonts.git $HOME/.fonts
  fc-cache -vf
fi

# Install git-hooks
if [ ! -d $HOME/.git-hooks ]; then
  echo "Installing git-hooks..."
  git clone https://github.com/dhellmann/git-hooks.git $HOME/.git-hooks
fi

# Create symlinks
files=`ls | sed -e "/\(install.sh\)/d"`
for file in $files; do
    if [ $file != "LICENSE" ] && [ $file != "README.md" ] \
       && [ ! -f $HOME/.$file ] && [ ! -d $HOME/.$file ]; \
    then
        echo "Symlinking $file..."
        ln -s $PWD/$file $HOME/.$file
    fi
done;

# Install oh-my-zsh themes
for i in frandieguez-v1 frandieguez-v2; do
  if [ ! -f $HOME/.oh-my-zsh/themes/$i.zsh-theme  ]; then
    echo "Installing oh-my-zsh theme: "$i
    ln -s $HOME/.zsh/oh-my-zsh-themes/$i.zsh-theme $HOME/.oh-my-zsh/themes/
  fi
done

# Set permissions for git_hooks
chmod -R 755 $HOME/.git_hooks

# Custom links for neovim
if type nvim > /dev/null; then
  if [ ! -d $HOME/.config/nvim  ]; then
    echo "Symlinking $HOME/.config/nvim..."
    ln -s $HOME/.vim $HOME/.config/nvim
  fi

  if [ ! -f $HOME/.config/nvim/init.vim  ]; then
    echo "Symlinking $HOME/.config/nvim/init.vim..."
    ln -s $HOME/.vimrc $HOME/.config/nvim/init.vim
  fi
fi

# Install vim-plug
if [ ! -f $HOME/.vim/autoload/plug.vim ]; then
    curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Install vim plugins
echo "Installing vim plugins..."
vim -c PlugInstall -c q -c q

# Install neovim plugins
if type nvim > /dev/null; then
  echo "Installing neovim plugins..."
  nvim -c PlugInstall -c q -c q
fi

if [ ! -d $HOME/.tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
fi

# Ask for user and email for gitconfig
if [ ! -f $HOME/.gitconfig-additional  ]; then
  read -e -p "Do you want to add your credentials to your .gitconfig? (Y/n) " q

  if [ "$q" == "Y"  ] || [ "$q" == "y"  ] || [ "$q" == ""  ]; then
    read -e -p "Name: " username
    read -e -p "Email: " email

    echo "[user]" >> $HOME/.gitconfig-additional
    echo "    name = " $username >> $HOME/.gitconfig-additional
    echo "    email = " $email >> $HOME/.gitconfig-additional
  fi
fi

echo "All DONE"
