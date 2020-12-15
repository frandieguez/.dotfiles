#!/bin/bash

# ---
# Installs configurations.
#
# @param $1 The list of applications to install.
# @param $2 The list of applications to ignore.
# ---
install_configs() {
    dotfiles=`ls src/config`

    if [[ "$1" != "" ]]; then
        dotfiles=$1
    fi

    if [[ "$2" != "" ]]; then
        toignore=$(echo $2 | sed -e "s/\s\+/\\\|/g")
        dotfiles=$(echo $tools | sed -e "s/$toignore//g")
    fi

    for dotfile in $dotfiles; do
        if [ -f src/config/$dotfile ]; then
            install_local $dotfile false
        fi

        if [ -d src/config/$dotfile ]; then
            install_local config/$dotfile true
        fi
    done;
}

# ---
# Installs dotfiles.
#
# @param $1 The list of applications to install.
# @param $2 The list of applications to ignore.
# ---
install_dotfiles() {
    dotfiles=`ls src --hide config`

    if [[ "$1" != "" ]]; then
        dotfiles=$1
    fi

    if [[ "$2" != "" ]]; then
        toignore=$(echo $2 | sed -e "s/\s\+/\\\|/g")
        dotfiles=$(echo $tools | sed -e "s/$toignore//g")
    fi

    for dotfile in $dotfiles; do
        if [ -f src/$dotfile ]; then
            install_local $dotfile false
        fi

        if [ -d src/$dotfile ]; then
            install_local $dotfile true
        fi
    done;

    zim_installer=~/.zim/zimfw.sh
    if [ ! -f $zim_installer ]; then
        mkdir -p ~/.zim
        curl -fsSL -o $zim_installer https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
        zsh $zim_installer install -q
    fi
}

# ---
# Installs a configuration file or directory in $HOME or $HOME/.config.
#
# @param $1 The file or directory to install.
# @param $2 Whether to install in $HOME (false) or $HOME/.config (true).
# ---
install_local() {
    target="$HOME/.$1"

    if [ -f $target ] || [ -d $target ]; then
        return
    fi

    echo -n "Installing $1..."
    ln -s $PWD/src/$1 $target > /dev/null 2>&1

    if [ $? -ne 0 ]; then
        echo -e "\E[31;5mFAIL\033[0m"
        return
    fi

    echo -e "\E[37;32mDONE\033[0m"

    # Execute post_install function if exists
    name=$(echo $1 | sed -e "s/config\///g")
    type "post_install_$name" > /dev/null 2>&1 && post_install_$name
}

# ---
# Installs a library from a remote repository in $HOME or $HOME/.config.
#
# @param $1 The library to install.
# @param $2 Whether to install in $HOME (false) or $HOME/.config (true).
# @param $3 The URL of the remote repository.
# ---
install_remote() {
    target="$HOME/.$1"

    if [[ $2 == true ]]; then
        target="$HOME/.config/$1"
    fi

    if [ -f $target ] || [ -d $target ]; then
        return
    fi

    echo -n "Installing $1..."
    git clone $3 $target > /dev/null 2>&1

    if [ $? -ne 0 ]; then
        echo -e "\E[31;5mFAIL\033[0m"
        return
    fi

    echo -e "\E[37;32mDONE\033[0m"
}

# ---
# Installs fonts.
#
# ---
install_fonts() {
    return;
    #echo $tools | grep "fonts" > /dev/null && \
        #install_remote fonts false https://github.com/powerline/fonts.git
}

# ---
# Installs external applications.
#
# @param $1 The list of applications to install.
# @param $2 The list of applications to ignore.
# ---
install_tools() {
    tools="git-hooks zgen asdf"

    if [[ $1 != "" ]]; then
        tools=$1
    fi

    if [[ "$2" != "" ]]; then
        toignore=$(echo $2 | sed -e "s/\s\+/\\\|/g")
        tools=$(echo $tools | sed -e "s/$toignore//g")
    fi

    echo $tools | grep "git-hooks" > /dev/null && \
        install_remote git-hooks false https://github.com/dhellmann/git-hooks.git

    echo $tools | grep "asdf" > /dev/null && \
        install_remote asdf false https://github.com/asdf-vm/asdf.git

    if [ -d $HOME/.config/tmux/.plugins/tpm ]; then
        git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
    fi

    curl -q https://raw.githubusercontent.com/arcticicestudio/nord-xresources/develop/src/nord --output ~/.Xresources

    curl -q https://raw.githubusercontent.com/derailed/k9s/master/skins/stock.yml --output ~/.k9s/skin.yml
}

# ---
# Installs external applications.
#
# @param $1 The list of applications to install.
# @param $2 The list of applications to ignore.
# ---
install_systools() {
    grep -v '#' ./src/packages/archlinux| strings | yay -S --noconfirm
}

# ---
# Executes post-installation commands after installing fonts.
# ---
post_install_fonts() {
    if [ -d $HOME/.fonts ]; then
        fc-cache -vf
    fi
}

# ---
# Executes post-installation commands after symlinking gitconfig file.
# ---
post_install_gitconfig() {
    if [ "`grep user $HOME/.gitconfig`" != "" ]; then
        return
    fi

    read -e -p "Do you want to add your credentials to your .gitconfig? (Y/n) " q

    if [ "$q" == "Y" ] || [ "$q" == "y" ] || [ "$q" == "" ]; then
        read -e -p "  Name: " username
        read -e -p "  Email: " email

        echo "[user]" >> $HOME/.gitconfig
        echo "    name = " $username >> $HOME/.gitconfig
        echo "    email = " $email >> $HOME/.gitconfig
    fi
}

# ---
# Sets permissions for git_hooks after symlinking git_hooks folder.
# ---
post_install_githooks() {
    chmod -R 755 $HOME/.config/githooks
}

# ---
# Executes post-installation commands after symlinking muttrc file.
# ---
post_install_muttrc() {
    # Ask for user and email for mutt
    if [ "`grep -e '<email>' $HOME/.muttrc`" == "" ] \
            && [ "`grep -e '<email>' $HOME/.config/mutt/mapping`" == "" ]; then
        return
    fi

    read -e -p "Do you want to add your email to your .muttrc? (Y/n) " q

    if [ "$q" == "Y" ] || [ "$q" == "y" ] || [ "$q" == "" ]; then
        read -e -p "  Account: " account
        read -e -p "  Email: " email

        sed --follow-symlinks -i -e "s/<account>/$account/g" $HOME/.muttrc
        sed --follow-symlinks -i -e "s/<email>/$email/g"     $HOME/.muttrc
        sed --follow-symlinks -i -e "s/<email>/$email/g"     $HOME/.config/mutt/mapping
    fi
}

# ---
# Executes post-installation commands after symlinking basic vim configuration.
# ---
post_install_nvim() {
    # Custom links for vim
    if [ ! -d $HOME/.vim ]; then
        echo "  Installing $HOME/.vim..."
        ln -s $HOME/.config/nvim $HOME/.vim
    fi

    if [ ! -f $HOME/.vimrc ]; then
        echo "  Installing $HOME/.config/nvim/init.vim..."
        ln -s $HOME/.config/nvim/init.vim $HOME/.vimrc
    fi

    # Install vim-plug
    if [ ! -f $HOME/.config/nvim/autoload/plug.vim ]; then
        curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi

    # Install neovim plugins
    if type /usr/bin/nvim > /dev/null 2>&1; then
        echo "  Installing neovim plugins..."
        /usr/bin/nvim -c PlugInstall -c q -c q
    fi

    # Install vim plugins
    echo "  Installing vim plugins..."
    if type /usr/bin/vim > /dev/null 2>&1; then
        /usr/bin/vim -c PlugInstall -c q -c q
    fi
}

# ---
# Executes post-installation commands after symlinking offlineimaprc file.
# ---
post_install_offlineimaprc() {
    if [ "`grep -e '<email>' $HOME/.offlineimaprc`" == "" ]; then
        return
    fi

    read -e -p "Do you want to add your email to your .offlineimaprc? (Y/n) " q

    if [ "$q" == "Y" ] || [ "$q" == "y" ] || [ "$q" == "" ]; then
        read -e -p " Account: " account
        read -e -p " Email: " email
        read -s -e -p " Password: " password

        sed --follow-symlinks -i -e "s/<account>/$account/g"   $HOME/.offlineimaprc
        sed --follow-symlinks -i -e "s/<email>/$email/g"       $HOME/.offlineimaprc
        sed --follow-symlinks -i -e "s/<password>/$password/g" $HOME/.offlineimaprc
    fi
}

main() {
    configs=true
    dotfiles=true
    fonts=true
    tools=true
    systools=true
    ignore=false
    ignoring=false
    toinstall=""
    toignore=""

    while [[ $# -gt 0 ]]; do
        case "$1" in
            -h | --help )        usage ;;

            -d | --no-dotfiles ) ignoring=false; dotfiles=false ;;

            -f | --no-fonts ) ignoring=false; fonts=false ;;

            -i | --ignore )      ignoring=true ;;
            --ignore=*    )      toignore=`echo $1 | sed -e "s/--ignore=//g"` ;;

            -t | --no-tools )    ignoring=false; tools=false ;;

            -s | --no-systools ) ignoring=false; systools=false ;;

            -*)                  usage "Unknown option '$1'" ;;
            * )                  [ $ignoring == true ] && \
                                    toignore="$toignore $1" || \
                                    toinstall="$toinstall $1" ;;
        esac

        shift;
    done

    [ $fonts ]    && install_fonts    "$toinstall" "$toignore"
    [ $tools ]    && install_tools    "$toinstall" "$toignore"
    [ $dotfiles ] && install_dotfiles "$toinstall" "$toignore"
    [ $configs ]  && install_configs  "$toinstall" "$toignore"
    [ $systools ] && install_systools "$toinstall" "$toignore"
}

# ---
# Displays the command help and an error message if parameter provided.
#
# @param $1 The error message.
# ---
usage() {
    if [ "$*" != "" ] ; then
        echo -e "\E[31;5minstall.sh: $*\033[0m"
        echo "";
    fi

    echo "Usage: install.sh [OPTION] [TOOL]"
    echo "Installs all dotfiles and tools or the list of selected tools"
    echo ""
    echo "  -c, --no-configs     The script does not install configurations"
    echo "  -d, --no-dotfiles    The script does not install dotfiles"
    echo "  -i, --ignore <tool>  The list of tools to ignore"
    echo "  -t, --no-tools       The script does not install tools"
    echo "  -s, --no-systools    The script does not install system tools"
    echo "  -t, --no-fonts       The script does not install fonts"

    exit 0;
}

main "$@"
