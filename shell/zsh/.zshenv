export DOTFILES_PATH="$HOME/.dotfiles"
export DOTLY_PATH="$DOTFILES_PATH/modules/dotly"
export ZIM_HOME="$DOTLY_PATH/modules/zimfw"

# zsh-users/zsh-autosuggestions plugin
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=30'
ZSH_AUTOSUGGEST_STRATEGY='match_prev_cmd'

# History --------------------------------------------------------
HISTSIZE=5000               #How many lines of history to keep in memory
HISTFILE=~/.zsh_history     #Where to save history to disk
SAVEHIST=5000               #Number of history entries to save to disk
HISTDUP=erase               #Erase duplicates in the history file

# Spaceship zsh plugin -------------------------------------------
SPACESHIP_PROMPT_ORDER=(
    # vi_mode   # Vi-mode indicator
    time      # Time stamps section
    user      # Username section
    dir       # Current directory section
    host      # Hostname section
    git       # Git section (git_branch + git_status)
    hg        # Mercurial section (hg_branch  + hg_status)
    package   # Package version
    node      # Node.js section
    ruby      # Ruby section
    elixir    # Elixir section
    xcode     # Xcode section
    swift     # Swift section
    golang    # Go section
    php       # PHP section
    rust      # Rust section
    haskell   # Haskell Stack section
    julia     # Julia section
    docker    # Docker section
    aws       # Amazon Web Services section
    gcloud    # Google Cloud Platform section
    venv      # virtualenv section
    conda     # conda virtualenv section
    # pyenv     # Pyenv section
    dotnet    # .NET section
    # ember     # Ember.js section
    kubectl   # Kubectl context section
    terraform # Terraform workspace section
    exec_time # Execution time
    battery   # Battery level and status
    line_sep  # Line break
    jobs      # Background jobs indicator
    exit_code # Exit code section
    char      # Prompt character
)

SPACESHIP_TIME_COLOR="blue"
SPACESHIP_USER_PREFIX=""
SPACESHIP_USER_SUFFIX=""
# SPACESHIP_DIR_PREFIX=":"
SPACESHIP_DIR_COLOR="red"
SPACESHIP_HOST_SHOW=false
SPACESHIP_HOST_SHOW_FULL=true
SPACESHIP_TIME_SHOW=false
SPACESHIP_GIT_SYMBOL=""
# SPACESHIP_GIT_PREFIX="("
# SPACESHIP_GIT_SUFFIX=") "
SPACESHIP_GIT_BRANCH_PREFIX=""
SPACESHIP_GIT_BRANCH_COLOR="green"
SPACESHIP_GIT_STATUS_COLOR="green"
# SPACESHIP_GIT_STATUS_PREFIX=" "
# SPACESHIP_GIT_STATUS_SUFFIX=""
SPACESHIP_PROMPT_DEFAULT_PREFIX="with"
SPACESHIP_PROMPT_BOLD=false
SPACESHIP_PACKAGE_SHOW=false
SPACESHIP_RUBY_SHOW=false
SPACESHIP_RUBY_SYMBOL="R "
SPACESHIP_DOCKER_SHOW=false
# SPACESHIP_USER_SHOW=always
SPACESHIP_KUBECTL_CONTEXT_SHOW=false
SPACESHIP_NODE_SHOW=false
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_EXEC_TIME_ELAPSED=1

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color=fg:#e5e9f0,bg:#3b4252,hl:#81a1c1
--color=fg+:#e5e9f0,bg+:#3b4252,hl+:#81a1c1
--color=info:#eacb8a,prompt:#bf6069,pointer:#b48dac
--color=marker:#a3be8b,spinner:#b48dac,header:#a3be8b
--reverse'

# Editor  ------------------------------------------
if command -v vim &> /dev/null
then
    export VIM_EXECUTABLE="nvim"
else
    export VIM_EXECUTABLE="vim"
fi
export EDITOR=$VIM_EXECUTABLE
export VISUAL=$VIM_EXECUTABLE
#alias vim=$VIM_EXECUTABLE

# Language -----------------------------------------
export LC_ALL=en_US.UTF-8
export LC_COLLATE=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8
export LC_MONETARY=en_US.UTF-8
export LC_NUMERIC=en_US.UTF-8
export LC_TIME=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
