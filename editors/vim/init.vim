set nocompatible
filetype off

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-obsession' " Required to be at the top because others depend on it

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'AndrewRadev/splitjoin.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'arcticicestudio/nord-vim'
Plug 'bkad/CamelCaseMotion'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'danro/rename.vim'
Plug 'davidoc/taskpaper.vim'
Plug 'dbestevez/keepcursor.vim'
Plug 'dhruvasagar/vim-prosession'
Plug 'dhruvasagar/vim-table-mode'
Plug 'duggiefresh/vim-easydir'
Plug 'easymotion/vim-easymotion'
Plug 'editorconfig/editorconfig-vim'
Plug 'epmatsw/ag.vim'
Plug 'ervandew/supertab'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'flazz/vim-colorschemes'
Plug 'haya14busa/incsearch-easymotion.vim'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/vim-easyoperator-line'
Plug 'honza/vim-snippets'
Plug 'ingydotnet/yaml-vim'
Plug 'itchyny/lightline.vim'
Plug 'janko-m/vim-test'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'jiangmiao/auto-pairs'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-journal'
Plug 'kana/vim-textobj-function'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-user'
Plug 'kentaro/vim-textobj-function-php'
Plug 'lifepillar/vim-solarized8'
Plug 'majutsushi/tagbar'
Plug 'mattn/emmet-vim'
Plug 'matze/vim-move'
Plug 'mhinz/vim-startify'
Plug 'mrtazz/simplenote.vim'
Plug 'neomake/neomake'
Plug 'plasticboy/vim-markdown'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'stanangeloff/php.vim'
Plug 'stephpy/vim-php-cs-fixer'
Plug 'tacahiroy/ctrlp-funky'
Plug 'terryma/vim-multiple-cursors'
Plug 'thinca/vim-textobj-function-javascript'
Plug 'tkhren/vim-fake'
Plug 'tpope/vim-cucumber'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/BufOnly.vim'
Plug 'vim-scripts/SyntaxAttr.vim'
Plug 'vim-scripts/loremipsum'
Plug 'vim-scripts/po.vim--Jelenak'
Plug 'w0ng/vim-hybrid'
Plug 'wesQ3/vim-windowswap'
Plug 'xolox/vim-misc'

if has('nvim')
 "Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins'  }
 "Plug 'zchee/deoplete-go'
 Plug 'Shougo/denite.nvim' " (Optional) Multi-entry selection UI.
 Plug 'Shougo/echodoc.vim' " (Optional) Showing function signature and inline doc.
 Plug 'autozimu/LanguageClient-neovim', { 'branch' : 'next', 'do': 'bash install.sh'  }
 Plug 'junegunn/fzf' " (Optional) Multi-entry selection UI.
 Plug 'ncm2/ncm2'
 Plug 'ncm2/ncm2-bufword'
 Plug 'ncm2/ncm2-cssomni'
 Plug 'ncm2/ncm2-go'
 Plug 'ncm2/ncm2-html-subscope'
 Plug 'ncm2/ncm2-jedi'
 Plug 'ncm2/ncm2-markdown-subscope'
 Plug 'ncm2/ncm2-neoinclude'
 Plug 'ncm2/ncm2-path'
 Plug 'ncm2/ncm2-rst-subscope'
 "Plug 'ncm2/ncm2-term'
 Plug 'ncm2/ncm2-tmux'
 Plug 'ncm2/ncm2-ultisnips'
 Plug 'ncm2/ncm2-vim-lsp'
 Plug 'phpactor/ncm2-phpactor'
 Plug 'prabirshrestha/async.vim' " Required by ncm2-vim-lsp
 Plug 'prabirshrestha/vim-lsp' " Required by ncm2-vim-lsp
 Plug 'roxma/nvim-yarp'
endif

"if has('python3')
    "Plug 'joonty/vdebug'
"endif

call plug#end()

filetype plugin indent on

" Colors
set t_Co=256
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:block-Cursor/lCursor-blinkon100,r-cr:hor20-Cursor/lCursor

"set background=dark
"colorscheme nord
"let g:nord_italic_comments=1
"let g:nord_uniform_diff_background=1
"set g:solarized_termcolors = 256

syntax enable
let &colorcolumn="".join(range(81,121),",")
highlight ColorColumn ctermbg=0 guibg=lightgrey

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
set relativenumber
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
set complete+=kspell

" Always use vertical diffs
set diffopt+=vertical

" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

source ~/.vim/plugins.vim
source ~/.vim/functions.vim
source ~/.vim/mappings.vim
source ~/.vim/commands.vim
