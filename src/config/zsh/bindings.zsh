# # zsh-users/zsh-autosuggestions
bindkey -e
bindkey -M vicmd ' ' autosuggest-accept
bindkey -M vicmd 'L' autosuggest-accept

# zsh-users/zsh-history-substring-search
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

bindkey '^ ' snippet-expand
bindkey '^F' fuck-command-line
