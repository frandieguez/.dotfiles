Fran's dot configuration files
==============================
Files on this repository are the important configurations that I'm using
all the day and I don't want to lost. Feel free of use them and provide me
any trick if you think that it could make me life easier.

Among these files you will find highly opinionated configurations for:
  * Bash
  * Git
  * Gitignore
  * Tmux
  * Vim/Nvim
  * Zsh
  * screen

An experimental support for NVim is included, by symlinking to Vim configs.

Install all
-----------
You can install all the configurations at one once using:

  git clone https://github.com/frandieguez/.dots.git ~/.dots;
  cd ~/.dots;
  ./install.sh

and your are done.

This is the recommended way if you know what are you doing :)
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

What's in it?
-------------

[vim](http://www.vim.org/) configuration:

* [Ctrl-P](https://github.com/kien/ctrlp.vim) for fuzzy file/buffer/tag finding.
* [Rails.vim](https://github.com/tpope/vim-rails) for enhanced navigation of
  Rails file structure via `gf` and `:A` (alternate), `:Rextract` partials,
  `:Rinvert` migrations, etc.
* Run many kinds of tests [from vim]([https://github.com/janko-m/vim-test)
* Set `<leader>` to a single space.
* Syntax highlighting for CoffeeScript, Textile, Cucumber, Haml, Markdown, and
  HTML.
* Use [Ag](https://github.com/ggreer/the_silver_searcher) instead of Grep when available.
* Map `<leader>ct` to re-index [Exuberant Ctags](http://ctags.sourceforge.net/).
* Use [vim-mkdir](https://github.com/pbrisbin/vim-mkdir) for automatically
  creating non-existing directories before writing the buffer.
* Use [vim-plug](https://github.com/junegunn/vim-plug) to manage plugins.

[tmux](http://robots.thoughtbot.com/a-tmux-crash-course) configuration:

* Improve color resolution.
* Set prefix to `Ctrl+a`
* Use custom colorscheme for status bar.

[git](http://git-scm.com/) configuration:

* Adds a `create-branch` alias to create feature branches.
* Adds a `delete-branch` alias to delete feature branches.
* Adds a `merge-branch` alias to merge feature branches into master.
* Adds an `up` alias to fetch and rebase `origin/master` into the feature
  branch. Use `git up -i` for interactive rebases.
* Adds `post-{checkout,commit,merge}` hooks to re-index your ctags.
* Adds `pre-commit` and `prepare-commit-msg` stubs that delegate to your local
  config.

[Ruby](https://www.ruby-lang.org/en/) configuration:

* Add trusted binstubs to the `PATH`.
* Load rbenv into the shell, adding shims onto our `PATH`.

Shell aliases and scripts:

* `b` for `bundle`.
* `g` with no arguments is `git status` and with arguments acts like `git`.
* `git-churn` to show churn for the files changed in the branch.
* `migrate` for `rake db:migrate && rake db:rollback && rake db:migrate`.
* `mcd` to make a directory and change into it.
* `replace foo bar **/*.rb` to find and replace within a given list of files.
* `tat` to attach to tmux session named the same as the current directory.
* `v` for `$VISUAL`.

License
-------

dotfiles is copyright © 20016-2017 Fran Dieguez. It is free software, and may be
redistributed under the terms specified in the [`LICENSE`] file.

About Fran Dieguez
------------------

![frandieguez](http://www.mabishu.com/wp-content/uploads/2013/04/gafas.png)

dotfiles is maintained by Fran Dieguez.


