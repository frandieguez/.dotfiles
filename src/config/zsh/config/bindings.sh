# zsh-users/zsh-autosuggestions
bindkey '^[[C' autosuggest-accept
bindkey '^ ' autosuggest-accept
bindkey -M vicmd ' ' autosuggest-accept
bindkey -M vicmd 'L' autosuggest-accept

# zsh-users/zsh-history-substring-search
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
bindkey -a '^[[3~' delete-char

bindkey '^ ' snippet-expand
bindkey '^F' fuck-command-line
