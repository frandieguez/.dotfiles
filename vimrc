set nocompatible
filetype off

call plug#begin('~/.vim/plugged')

Plug 'altercation/vim-colors-solarized'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'vim-scripts/BufOnly.vim'
Plug 'airblade/vim-gitgutter'
Plug 'algotech/ultisnips-php'
Plug 'bkad/CamelCaseMotion'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'danro/rename.vim'
Plug 'davidoc/taskpaper.vim'
Plug 'dbestevez/keepcursor.vim'
Plug 'duggiefresh/vim-easydir'
Plug 'editorconfig/editorconfig-vim'
Plug 'easymotion/vim-easymotion'
Plug 'epmatsw/ag.vim'
Plug 'ervandew/supertab'
Plug 'flazz/vim-colorschemes'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-easymotion.vim'
Plug 'haya14busa/vim-easyoperator-line'
Plug 'honza/vim-snippets'
Plug 'itchyny/lightline.vim'
Plug 'janko-m/vim-test'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-journal'
Plug 'kana/vim-textobj-function'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-user'
Plug 'kentaro/vim-textobj-function-php'
Plug 'lifepillar/vim-solarized8'
Plug 'vim-scripts/loremipsum'
Plug 'mattn/emmet-vim'
Plug 'matze/vim-move'
Plug 'mhinz/vim-startify'
Plug 'mrtazz/simplenote.vim'
Plug 'neomake/neomake'
Plug 'plasticboy/vim-markdown'
Plug 'scrooloose/NERDCommenter'
Plug 'scrooloose/nerdtree'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins'  }
elseif has('lua')
  Plug 'Shougo/neocomplete.vim'
endif

Plug 'tpope/vim-obsession'
Plug 'dhruvasagar/vim-prosession'
Plug 'ingydotnet/yaml-vim'
Plug 'ryanoasis/vim-devicons'
Plug 'stanangeloff/php.vim'
Plug 'tacahiroy/ctrlp-funky'
Plug 'terryma/vim-multiple-cursors'
Plug 'thinca/vim-textobj-function-javascript'
Plug 'tkhren/vim-fake'
Plug 'tpope/vim-cucumber'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'SirVer/ultisnips'
Plug 'wesQ3/vim-windowswap'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'Yggdroot/indentLine'

Plug 'dhruvasagar/vim-table-mode'

Plug 'fatih/vim-go'
Plug 'w0ng/vim-hybrid'
Plug 'leafgarland/typescript-vim'
Plug 'majutsushi/tagbar'
Plug 'stephpy/vim-php-cs-fixer'
Plug 'w0ng/vim-hybrid'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-easytags'

call plug#end()

filetype plugin indent on

" Colors
set t_Co=256

set background=dark
"colorscheme monokai-chris
colorscheme solarized8_dark_high
let g:solarized_termcolors = 16

syntax enable
let &colorcolumn="".join(range(81,121),",")

" Misc
let mapleader="\<Space>"
set laststatus=2
set mouse=a
set nobackup
set noswapfile
set updatetime=250

if !has('nvim')
    set encoding=utf8
    set ttymouse=xterm2
endif

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

" Autocomplete
" Set spellfile to location that is guaranteed to exist, can be symlinked to
" Dropbox or kept in Git and managed outside of thoughtbot/dotfiles using rcm.
set spellfile=$HOME/.vim-spell-en.utf-8.add
" Autocomplete with dictionary words when spell check is on
set complete+=kspella

" Always use vertical diffs
set diffopt+=vertical

source ~/.vim/plugins.vim
source ~/.vim/functions.vim
source ~/.vim/mappings.vim
source ~/.vim/commands.vim
