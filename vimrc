" This is the personal .vimrc file of Fran Dieguez.
" While much of it is beneficial for general use, I would
" recommend picking out the parts you want and understand.
"
" You can find me at http://frandieguez.com

" Basics {
    "Syntax highlight
    syntax enable
    """Set line numbering
    set number
    "Set line highlight
    set cursorline
    ""Setting no vim compat
    set nocp
    filetype plugin indent on

" }

" Modeline and Notes {
    " vim: set foldmarker={,} foldlevel=0 foldmethod=marker spell:
    set modelines=1
    " vim:foldmethod=marker:foldlevel=0dd
" }

" Mouse {
    "allows mouse selection to go into visual mode and more
    set mouse=a
" }

" Moving through windows {
    map <C-h> <C-w>h
    map <C-j> <C-w>j
    map <C-k> <C-w>k
    map <C-l> <C-w>l
" }

" Splits {
    "Open splits down and right
    set splitbelow
    set splitright
    " Resizing splits
    nnoremap <silent> + :vertical resize +5<CR>
    nnoremap <silent> - :vertical resize -5<CR>
    nnoremap <silent> <leader>+ :resize +5<CR>
    nnoremap <silent> <leader>- :resize -5<CR>
" }

" Tabs {
    "Insert spaces instead of tabs it inserts (if defined) 'softtabstop' space chars
    set expandtab
    "Tab equivalent to n spaces
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
    set autoindent
    set smarttab
" }

" avoid side effects
set nocompatible
filetype off

" vundle {
    "Vundle installs plugins configured in vimrc with :BundleInstall
    set rtp+=~/.vim/bundle/vundle
    call vundle#begin()
    """"""""""""""""""""""""""""""""""""""Plugins
    Plugin 'gmarik/vundle' "Required Bundle

    ""Bundles to install
    Plugin 'airblade/vim-gitgutter'
    Plugin 'altercation/vim-colors-solarized'
    Plugin 'bling/vim-airline'
    Plugin 'ekalinin/Dockerfile.vim'
    Plugin 'elzr/vim-json'
    Plugin 'ervandew/supertab'
    Plugin 'fatih/vim-go'
    Plugin 'flazz/vim-colorschemes'
    Plugin 'garbas/vim-snipmate'
    Plugin 'godlygeek/tabular'
    Plugin 'gregsexton/MatchTag'
    Plugin 'honza/vim-snippets'
    Plugin 'kana/vim-textobj-entire'
    Plugin 'kana/vim-textobj-user'
    Plugin 'kchmck/vim-coffee-script'
    Plugin 'kien/ctrlp.vim'
    Plugin 'klen/python-mode'
    Plugin 'Lokaltog/powerline'
    Plugin 'MarcWeber/vim-addon-mw-utils'
    Plugin 'mileszs/ack.vim'
    Plugin 'nelstrom/vim-textobj-rubyblock'
    Plugin 'rjohnsondev/vim-compiler-go'
    Plugin 'puppetlabs/puppet-syntax-vim'
    Plugin 'rodjek/vim-puppet'
    Plugin 'saghul/vim-colortoggle'
    Plugin 'scrooloose/nerdtree'
    Plugin 'scrooloose/syntastic'
    Plugin 'Shougo/neomru.vim'
    Plugin 'Shougo/unite.vim'
    Plugin 'Shougo/vimproc.vim'
    Plugin 'terryma/vim-multiple-cursors'
    Plugin 'tomtom/tcomment_vim'
    Plugin 'tomtom/tlib_vim'
    Plugin 'tpope/vim-bundler'
    Plugin 'tpope/vim-commentary'
    Plugin 'tpope/vim-endwise'
    Plugin 'tpope/vim-fugitive'
    Plugin 'tpope/vim-rails'
    Plugin 'tpope/vim-repeat'
    Plugin 'tpope/vim-sensible'
    Plugin 'tpope/vim-surround'
    Plugin 'tpope/vim-unimpaired'
    Plugin 'Valloric/YouCompleteMe'
    Plugin 'vim-scripts/HTML-AutoCloseTag'
    Plugin 'vim-scripts/JSON.vim'
    Plugin 'vim-scripts/YankRing.vim'
    Plugin 'xolox/vim-colorscheme-switcher'
    Plugin 'xolox/vim-misc'
    Plugin 'xolox/vim-notes'
    Plugin 'Yggdroot/indentLine'

    call vundle#end()
" }

filetype plugin indent on
"Matchit is included in vimcore since vim 6.0 this activates it:
"(runtime == source+relative path to vim installation dir)
runtime macros/matchit.vim

" Keyboard mappings {
    map <F8> :SyntasticCheck<CR>
    ""Open tag under cursor in new tab
    map <C-T> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
    "Switch between buffers
    "nnoremap <silent> [b :bprevious<CR>
    "nnoremap <silent> ]b :bnext<CR>
    "nnoremap <silent> [B :bfirst<CR>
    "nnoremap <silent> ]B :blast<CR>
    "
    ""macro for pasting from clipboard (cp = clipboard paste)
    nnoremap cp "*p

    " hlsearch disable with space
    "nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
    " Search in command history without losing history filter
    cnoremap <C-p> <Up>
    cnoremap <C-n> <Down>

    nmap <leader>a :AV<CR> "Open Alternate file in vertical split
" }

" Colors & color scheme {
    syntax enable
    "set t_Co=16
    "set background=dark
    "let g:solarized_termcolors=256
    " colorscheme solarized
" }

" NerdTREE {
    map <F5> :NERDTreeToggle .<CR>

    " Don't ask to remove buffers when renaming or deleting files
    let g:NERDTreeAutoDeleteBuffer = 1
    " Ignore *.o files
    let NERDTreeIgnore = [ '\.o$', '\.meta$' ]

    " Open NERDTree when vim starts
    " autocmd vimenter * NERDTree

    " Set nerdtree to be launched on start and cursor set to editing window
    " autocmd VimEnter * wincmd p
" }

" Syntastic {
    let g:syntastic_error_symbol = '✗'
    let g:syntastic_auto_loc_list = 2
    let g:syntastic_mode_map = { 'mode': 'active',
                                 \ 'active_filetypes': [],
                                 \ 'passive_filetypes': ['puppet'] }
    map <F8> :SyntasticCheck<CR>
"}

" Youcompleteme {

    let g:ycm_path_to_python_interpreter = '/usr/bin/python2'
"}

" Yankring {
    " Where to store yankring history
    let g:yankring_history_dir = '~/.vim'
    " K and Q as previous and next register
    let g:yankring_replace_n_pkey = 'K'
    let g:yankring_replace_n_nkey = 'Q'
" }

" Powerline {
    "Export python path for powerline
    let $PYTHONPATH="/usr/lib/python2.7/dist-packages"
    " always show powerline
    set laststatus=2
    " instant go to normal mode (powerline)
    if ! has('gui_running')
	set ttimeoutlen=10
        augroup FastEscape
            autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
        augroup END
    endif
" }

" Tabularize {
    " tabularize by selection in visual mode
    vmap <leader>t y:Tabularize /<C-R>"/<CR>
    " tabularize =
    nmap <leader>t= :Tabularize /^[^=]*\zs=/<CR>
    nmap <leader>te :Tabularize /^[^=]*\zs=/<CR>
    " tabularize =>
    nmap <leader>th :Tabularize /^[^=>]*\zs=>/<CR>
    " tabularize {
    nmap <leader>t{ :Tabularize /^[^{]*\zs{/<CR>
    nmap <leader>tB :Tabularize /^[^{]*\zs{/<CR>
    " tabularize (
    nmap <leader>t( :Tabularize /^[^(]*\zs(/<CR>
    nmap <leader>tb :Tabularize /^[^(]*\zs(/<CR>
" }

" Unite {
    "Set ag as default finder
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
    let g:unite_source_grep_recursive_opt = ''
    "Set unite to open window in bottom right
    let g:unite_split_rule = "botright"
    let g:unite_force_overwrite_statusline = 1
    let g:unite_winheight = 8
    "Use fuzzy matcher
    call unite#filters#matcher_default#use(['matcher_fuzzy'])
    "Set sort method
    call unite#filters#sorter_default#use(['sorter_rank'])
    let g:unite_matcher_fuzzy_max_input_length = 60
    " In window settings
    autocmd FileType unite call s:unite_settings()
    function! s:unite_settings()
        A
        let b:SuperTabDisabled=1
        inoremap <silent><buffer><expr> <C-i> unite#do_action('split')
        inoremap <silent><buffer><expr> <C-s> unite#do_action('vsplit')
        imap <buffer> <ESC> <Plug>(unite_exit)
    endfunction
    "maps \e to open unite fuzzy finding
    nnoremap <Leader>e :Unite -silent -buffer-name=files -auto-resize -start-insert file_rec/async:!<CR>
    "maps \ag to open ag content fuzzy finding
    nnoremap <Leader>ag :Unite -silent -start-insert grep:.<CR>
    "maps \r to open recent buffers open
    nnoremap <silent> <Leader>r :Unite -silent -buffer-name=recent -auto-resize file_mru<cr>
    "maps \b to navigate open buffers
    nnoremap <Leader>b :Unite -silent -buffer-name=buffers -auto-resize buffer<cr>
    "Search in command history without losing history filter
    cnoremap <C-p> <Up>
    cnoremap <C-n> <Down>
" }

" Backup files {
    " Write backup files in /tmp folder
    set backup
    set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
    set backupskip=/tmp/*,/private/tmp/*
    set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
    set writebackup
" }
