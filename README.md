Fran's dot configuration files
==============================
The file on this repository are the important configurations that I'm using
all the day and I don't want to lost. Feel free of use them and provide me
any trick if you think that it could make me life easier.

*If you are going to clone this repo, please, do it with the `--recursive`
option.*


Install all
-----------
You can install all the configurations at one time using:

    git clone --recursive https://github.com/frandieguez/.dots.git
    ./install.sh

After the installation you must install the vim plugins by using the vim command line:

    vim -c "PluginInstall"

and your are done
It's the recommended way if you know what are you doing :)

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


Dependencies
------------
Some vim bundles need some pip programs, this is the list:

- flake8
- pyflakes
- ropevim

To install them:

    sudo pip install flake8 pyflakes ropevim
