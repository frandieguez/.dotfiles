set nocompatible
filetype off

call plug#begin('~/.vim/plugged')

Plug 'altercation/vim-colors-solarized'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'airblade/vim-gitgutter'
Plug 'BufOnly.vim'
Plug 'algotech/ultisnips-php'
Plug 'bkad/CamelCaseMotion'
Plug 'davidoc/taskpaper.vim'
Plug 'duggiefresh/vim-easydir'
Plug 'editorconfig/editorconfig-vim'
Plug 'easymotion/vim-easymotion'
Plug 'epmatsw/ag.vim'
Plug 'ervandew/supertab'
Plug 'godlygeek/tabular'
Plug 'flazz/vim-colorschemes'
Plug 'honza/vim-snippets'
Plug 'itchyny/lightline.vim'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-easy-align'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'lifepillar/vim-solarized8'
Plug 'loremipsum'
Plug 'mattn/emmet-vim'
Plug 'matze/vim-move'
Plug 'mhinz/vim-startify'
Plug 'scrooloose/NERDCommenter'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins'  }
else
  Plug 'Shougo/neocomplete.vim'
endif

Plug 'SirVer/ultisnips'
Plug 'stanangeloff/php.vim'
Plug 'ingydotnet/yaml-vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-cucumber'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'dhruvasagar/vim-prosession'
Plug 'tacahiroy/ctrlp-funky'
Plug 'tpope/vim-repeat'
Plug 'wesQ3/vim-windowswap'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'Yggdroot/indentLine'
Plug 'ryanoasis/vim-devicons'

Plug 'fatih/vim-go'
Plug 'w0ng/vim-hybrid'
Plug 'majutsushi/tagbar'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-easytags'

call plug#end()

filetype plugin indent on

" Colors
set t_Co=256

set background=dark
colorscheme monokai-chris

syntax enable
let &colorcolumn="".join(range(81,121),",")

" Misc
set encoding=utf8
set nobackup
set noswapfile
set mouse=a
let mapleader="\<Space>"
set updatetime=250

if has('clipboard')
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

if !has('nvim')
  set ttymouse=xterm2
endif


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
