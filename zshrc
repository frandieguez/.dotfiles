bindkey -v

# Load zsh configuration
for file in ~/.zsh/(config|functions)/*; do
    source "$file"
done

# Aliases
if [ -f ~/.profile ]; then
    source ~/.profile;
fi
