Fran's dot configuration files
==============================
Files on this repository are the important configurations that I'm using
all the day and I don't want to lost. Feel free of use them and provide me
any trick if you think that it could make me life easier.

Among these files you will find highly opinionated configurations for:
  * Bash
  * Git
  * Gitignore
  * Tmux
  * Vim
  * Zsh
  * screen

An experimental support for NVim is included, by symlinking to Vim configs.

Install all
-----------
You can install all the configurations at one once using:

  git clone https://github.com/frandieguez/.dots.git ~/.dots
  cd ~/.dots
  ./install.sh

and your are done.

This is the recommended way if you know what are you doing :)
If you don't want to do this, continue reading...

Installation by components
--------------------------
Clone the repo and link the files that you want in your $HOME path.

Example:

    cd $HOME;ln -s .dots/vimrc .vimrc



Specific cases
--------------

Some files like zsh must be included in the normal .zshrc configuration file. For example:

### zsh
Add `. ~/.dots/zsh` at the end of your `~/.zshrc`.

### hg
Add `%include ~/.dots/hg` at the end of your `~/.hgrc`.
