<h1 align="center">
  .dotfiles created using <a href="https://github.com/CodelyTV/dotly">🌚 dotly</a>
</h1>

## Restore your Dotfiles

* Install git
* Clone your dotfiles repository `git clone [your repository of dotfiles] $HOME/.dotfiles`
* Go to your dotfiles folder `cd $HOME/.dotfiles`
* Install git submodules `git submodule update --init --recursive`
* Install your dotfiles `DOTFILES_PATH="$HOME/.dotfiles" DOTLY_PATH="$DOTFILES_PATH/modules/dotly" "$DOTLY_PATH/bin/dot" self install`
* Restart your terminal
* Import your packages `dot package import`


🚀 Fran Dieguez dot configuration files
==============================
Repository containing all the automations required to setup my development machine in just a few seconds after a fresh install.

Files on this repository are the important configurations that I'm using all the day and I don't want to lose. Feel free to use them and provide me any trick if you think that it could make me life easier. 😬

Among these files you will find highly opinionated configurations for:
  * Bash
  * bspwm
  * Git
  * Gitignore
  * mutt
  * screen
  * Tmux
  * Vim/Nvim
  * Zsh

☝️ How to install it
-----------
You can install all the configurations at one once using:
```
  git clone https://github.com/frandieguez/.dots.git ~/.dots;
  cd ~/.dots;
  ./install.sh
```

and your are done.

This is the recommended way if you know what are you doing :)
If you don't want to do this, continue reading... 😬

🍫 Installation by components
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

What's in it?
-------------
🐌 Shell
* In order to make as much configurations available for all shells I have all the common aliases, functions and general configurations available at `src/config/shell`.
* Custom shell prompt to show git information
![shell prompt](https://imgur.com/download/5hbNf8q)

* Tons Shell aliases and scripts:

  * `b` for `bundle`.
  * `g` with no arguments is `git status` and with arguments acts like `git`.
  * `git-churn` to show churn for the files changed in the branch.
  * `migrate` for `rake db:migrate && rake db:rollback && rake db:migrate`.
  * `mcd` to make a directory and change into it.
  * `replace foo bar **/*.rb` to find and replace within a given list of files.
  * `tat` to attach to tmux session named the same as the current directory.
  * `v` for `$VISUAL`.

💾 zsh + [on-my-zsh](https://ohmyz.sh/)
* Specific configurations available at `src/zsh/`
* Use ohmyzsh for plugin management
  * Enabled vi mode
  * Plugins installed for technologies that I use: bower, capistrano, docker, composer, git, git-flow, golang, kubectl, redis, tmux, tmuxinator, yarn, autosuggestions, among others

🖊️ [vim](http://www.vim.org/) configuration:

* Use [vim-plug](https://github.com/junegunn/vim-plug) to manage plugins.
* [Ctrl-P](https://github.com/kien/ctrlp.vim) for fuzzy file/buffer/tag finding.
* Run many kinds of tests [from vim]([https://github.com/janko-m/vim-test)
* Set `<leader>` to a single space.
* Syntax highlighting for CoffeeScript, Textile, Cucumber, Haml, Markdown, and
  HTML.
* Use [Ag](https://github.com/ggreer/the_silver_searcher) instead of Grep when available.
* Map `<leader>ct` to re-index [Exuberant Ctags](http://ctags.sourceforge.net/).
* Use [vim-mkdir](https://github.com/pbrisbin/vim-mkdir) for automatically
  creating non-existing directories before writing the buffer.

✉️ [tmux](http://robots.thoughtbot.com/a-tmux-crash-course) configuration:

* Improve color resolution.
* Set prefix to `Ctrl+a`
* Use custom colorscheme for status bar.

🐙 [git](http://git-scm.com/) configuration:

* Adds a `create-branch` alias to create feature branches.
* Adds a `delete-branch` alias to delete feature branches.
* Adds a `merge-branch` alias to merge feature branches into master.
* Adds an `up` alias to fetch and rebase `origin/master` into the feature
  branch. Use `git up -i` for interactive rebases.
* Adds `post-{checkout,commit,merge}` hooks to re-index your ctags.
* Adds `pre-commit` and `prepare-commit-msg` stubs that delegate to your local
  config.

📋 Languages:
I try to simplify configuration for languages that I use:

* [PHP](https://www.php.net) configurations:
  * Composer in $PATH
* [node](https://nodejs.org) configurations:
  * nvm
  * yarn
  * npm
* [Golang](https://golang.org) configurations:
  * goenv
  * gopath
* [Ruby](https://www.ruby-lang.org/en/) configuration:
  * Add trusted binstubs to the `PATH`.
  * Load rbenv into the shell, adding shims onto our `PATH`.

🤝 Contributing
---
The idea of this repo is to add new settings to it during my own setup process and allow you to contribute to it 🙂

It would be awesome to learn from your experience automating the setup of your environment. So please, feel free to send me your tips and tricks via Twitter (@frandieguez), or opening an issue.

⚖️ License
---
The MIT License (MIT). Please see License for more information.

dotfiles is copyright © 2016-2019 Fran Dieguez. It is free software, and may be redistributed under the terms specified in the [`LICENSE`] file.

ℹ️ About the author
----------------

![frandieguez](http://www.mabishu.com/wp-content/uploads/2013/04/gafas.png)

dotfiles is maintained by Fran Dieguez.
