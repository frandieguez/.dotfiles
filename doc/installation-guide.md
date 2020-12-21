# Installation Guide

## On a new MacOS (migrating from another)
* Backup `~/.ssh` and `~/.gnupg` from the previous computer to the new one
  - `chmod -R 700 ~/.ssh`
  - `chmod -R 700 ~/.gnupg`
* Execute the dotfiles installer
* Login in Google Chrome
* Open JetBrains Toolbox and login
  - Login
  - Enable "generate shell scripts in ~/bin"
  - Install IntelliJ
* Open IntelliJ
  - Import from JetBrains account
  - Sync plugins
  - Execute `dot intellij add_code_templates`
* Open Spotify
  - Set streaming quality to very high
* Restart
  - When Google Drive is synced, install all the fonts
    - Also download Osaka Mono from Font Book
* Execute `dot shell zsh reload_completions` and then `compinit`