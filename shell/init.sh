# This is a useful file to have the same aliases/functions in bash and zsh

source "$DOTFILES_PATH/shell/aliases.sh"
source "$DOTFILES_PATH/shell/exports.sh"
source "$DOTFILES_PATH/shell/functions.sh"


if [[ $OSTYPE =~ ^[darwin] ]]; then
    ssh-add --use-apple-keychain >/dev/null 2>&1
fi
