" Vundle
set nocompatible
filetype off
set shell=bash

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Plugin 'gmarik/vundle'

Plugin 'altercation/vim-colors-solarized'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'algotech/ultisnips-php'
Plugin 'bkad/CamelCaseMotion'
Plugin 'davidoc/taskpaper.vim'
Plugin 'duggiefresh/vim-easydir'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'easymotion/vim-easymotion'
Plugin 'epmatsw/ag.vim'
Plugin 'ervandew/supertab'
Plugin 'godlygeek/tabular'
Plugin 'honza/vim-snippets'
Plugin 'itchyny/lightline.vim'
Plugin 'jeetsukumaran/vim-buffergator'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'jiangmiao/auto-pairs'
Plugin 'junegunn/vim-easy-align'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'loremipsum'
Plugin 'mattn/emmet-vim'
Bundle 'matze/vim-move'
Plugin 'mhinz/vim-startify'
Plugin 'scrooloose/NERDCommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'Shougo/neocomplete.vim'
Plugin 'SirVer/ultisnips'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-obsession'
Plugin 'dhruvasagar/vim-prosession'
Plugin 'tacahiroy/ctrlp-funky'
Plugin 'tpope/vim-repeat'
Plugin 'wesQ3/vim-windowswap'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'Yggdroot/indentLine'
Plugin 'ryanoasis/vim-devicons'

Plugin 'fatih/vim-go'
Plugin 'w0ng/vim-hybrid'

filetype plugin indent on

" Colors
set t_Co=256

set background=dark
colorscheme hybrid

syntax enable
let &colorcolumn="".join(range(81,121),",")

" Misc
set encoding=utf8
set nobackup
set noswapfile
set mouse=a
let mapleader="\<Space>"

if has('unnamedplus')
    set clipboard=unnamed,unnamedplus
endif

" Spaces & Tabs
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set cindent

" UI Layout
set cursorline
set fillchars+=vert:\│
set lazyredraw
set noshowmode
set nowrap
set number
set showmatch
set splitbelow
set splitright
set ttyfast
set wildmenu
set previewheight=15

" Searching
set hlsearch
set ignorecase
set incsearch
set smartcase

" Folding
set foldenable
set foldlevelstart=10
set foldmethod=indent
set foldnestmax=10

source ~/.vim/functions.vim
source ~/.vim/bindings.vim
source ~/.vim/commands.vim
source ~/.vim/plugins.vim
