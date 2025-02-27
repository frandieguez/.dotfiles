# LINUX ############################################
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    
    asdf_dir="${asdf_dir:-$HOME/.asdf}"
    
    if [[ -d $asdf_dir ]]; then
        source $asdf_dir/asdf.sh
        source $asdf_dir/completions/asdf.bash
    fi
    
    export ANDROID_HOME=$HOME/.android/sdk
    
    if [ -d /usr/lib/jvm/default-runtime ]; then
        export JAVA_HOME=/usr/lib/jvm/default-runtime
    fi
    
    [ ! command -v google-chrome-stable ] &>/dev/null && export CHROME_EXECUTABLE=google-chrome-stable
    
    # MACOS ############################################
elif [[ "$OSTYPE" == "darwin"* ]];
then
    export ANDROID_HOME=$HOME/Library/Android/sdk
    
    export JAVA_HOME=$(/usr/libexec/java_home -v 17)
    
    . /opt/homebrew/opt/asdf/libexec/asdf.sh
    export LDFLAGS="-L/opt/homebrew/opt/ruby/lib"
    export CPPFLAGS="-I/opt/homebrew/opt/ruby/include"
    
    [ ! command -v google-chrome-stable &> /dev/null ] &&
    export CHROME_EXECUTABLE="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
fi

export path=(
    "$ANDROID_HOME/emulator"
    "$ANDROID_HOME/platform-tools"
    "$ANDROID_HOME/tools"
    "$ANDROID_HOME/tools/bin"
    "$DOTFILES_PATH/bin"
    "$DOTLY_PATH/bin"
    "$GEM_HOME/bin"
    "$GOPATH/bin"
    "$HOME/.go/bin"
    "$HOME/.cargo/bin"
    "$HOME/.composer/vendor/bin"
    "$HOME/.config/yarn/global/node_modules/.bin/"
    "$HOME/.gem/ruby/2.7.0/bin"
    "$HOME/.yarn/bin/"
    "$HOME/Library/Python/3.9/bin"
    "$JAVA_HOME/bin"
    "$HOME/Library/flutter/bin"
    "$HOME/bin"
    "/opt/homebrew/bin"
    "/opt/homebrew/sbin"
    "/opt/homebrew/opt/ruby/bin"
    "/var/lib/flatpak/exports/bin"
    "/usr/local/opt/ruby/bin"
    "/usr/local/opt/python/libexec/bin"
    "/usr/local/bin"
    "/usr/local/sbin"
    "/bin"
    "/usr/bin"
    "/usr/sbin"
    "/sbin"
)

# Set the vim runtime for nvim
# if [ -x "$(command -v nvim)" ]; then
#    export VIMRUNTIME=$(find /usr/share -type d -name runtime 2> /dev/null|grep nvim |head -1)
#    export VIMRUNTIME=/usr/share/nvim/runtime
# fi

# if [[ -n "${NVIM_LISTEN_ADDRESS}" ]]; then
#   # TODO update the path each time Vim has a major upgrade
#  export VIMRUNTIME=/usr/share/vim/vim81
# fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
[[ -s "$HOME/.sdkman" ]] && export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

[ -s "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# Autojump
[[ -s /etc/profile.d/autojump.zsh ]] && source /etc/profile.d/autojump.zsh
if [[ "$OSTYPE" == "darwin"* ]];
then
    [[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh
fi

[[ -d $HOME/.gem ]] && export GEM_HOME="$HOME/.gem"
[[ -d $HOME/.go ]] && export GOPATH="$HOME/.go"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
fi

eval "$(mise activate zsh)"
