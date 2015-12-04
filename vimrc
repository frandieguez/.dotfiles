" This is the personal .vimrc file of Fran Dieguez.
" While much of it is beneficial for general use, I would
" recommend picking out the parts you want and understand.
"
" You can find me at http://frandieguez.com
" Vundle
" ----------------------------------------------------------------------
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Plugin 'Shougo/neocomplete.vim'
Plugin 'SirVer/ultisnips'
Plugin 'Yggdroot/indentLine'
Plugin 'airblade/vim-gitgutter'
Plugin 'algotech/ultisnips-php'
Plugin 'bkad/CamelCaseMotion'
Plugin 'davidoc/taskpaper.vim'
Plugin 'duggiefresh/vim-easydir'
Plugin 'easymotion/vim-easymotion'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'epmatsw/ag.vim'
Plugin 'ervandew/supertab'
Plugin 'gmarik/vundle'
Plugin 'godlygeek/tabular'
Plugin 'honza/vim-snippets'
Plugin 'itchyny/lightline.vim'
Plugin 'jeetsukumaran/vim-buffergator'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'junegunn/vim-easy-align'
Plugin 'kien/ctrlp.vim'
Plugin 'mattn/emmet-vim'
Plugin 'matze/vim-move'
Plugin 'mhinz/vim-startify'
Plugin 'scrooloose/NERDCommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'sickill/vim-monokai'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-obsession'
Plugin 'dhruvasagar/vim-prosession'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'wesQ3/vim-windowswap'
Plugin 'fatih/vim-go'

filetype plugin indent on


" Colors -----------------------------------------------------------------------
set t_Co=256
colorscheme monokai
syntax enable
let &colorcolumn="".join(range(81,121),",")

" Misc -------------------------------------------------------------------------
set nobackup
set noswapfile
set mouse=a
let mapleader="\<Space>"

if has('unnamedplus')
    set clipboard=unnamed,unnamedplus
endif

" Spaces & Tabs ----------------------------------------------------------------
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set cindent

" UI Layout --------------------------------------------------------------------
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

" Searching --------------------------------------------------------------------
set hlsearch
set ignorecase
set incsearch
set smartcase

" Folding ----------------------------------------------------------------------
set foldenable
set foldlevelstart=10
set foldmethod=indent
set foldnestmax=10

" CtrlP ------------------------------------------------------------------------
let g:ctrp_max_depth=20
let g:ctrlp_max_files=0
let g:ctrlp_switch_buffer=0
let g:ctrlp_user_command='ag %s -l --nocolor -g ""'
let g:ctrp_working_path_mode="ra"
let g:ctrlp_status_func = {
            \ 'main': 'CtrlPStatusFunc_1',
            \ 'prog': 'CtrlPStatusFunc_2',
            \ }


" Easy-align -------------------------------------------------------------------
nmap ga <Plug>(EasyAlign)
vmap <Enter> <Plug>(EasyAlign)

" Easy-motion -------------------------------------------------------------------
nmap s <Plug>(easymotion-s)
nmap ss <Plug>(easymotion-s2)
nmap t <Plug>(easymotion-t)
nmap tt <Plug>(easymotion-t2)

" Editorconfig -----------------------------------------------------------------
let g:EditorConfig_exec_path = '/usr/bin/editorconfig'

" Emmet ------------------------------------------------------------------------
let g:user_emmet_leader_key='<C-w>'

" Lightline --------------------------------------------------------------------
let g:lightline = {
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], ['ctrlpmark'] ],
            \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
            \ },
            \ 'component_function': {
            \     'ctrlpmark': 'CtrlPMark',
            \     'fileencoding': 'LightlineFileencoding',
            \     'fileformat': 'LightlineFileformat',
            \     'filename': 'LightlineFilename',
            \     'filetype': 'LighlineFiletype',
            \     'fugitive': 'LightlineFugitive',
            \     'mode': 'LightlineMode',
            \ },
            \ 'component_expand': {
            \   'syntastic': 'SyntasticStatuslineFlag',
            \ },
            \ 'component_type': {
            \   'syntastic': 'error',
            \ }
            \ }

" Neocomplete ------------------------------------------------------------------
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#max_list = 10

" NERD Tree --------------------------------------------------------------------
let NERDTreeHighlightCursorline = 1

" Powerline --------------------------------------------------------------------
set laststatus=2

" Syntastic --------------------------------------------------------------------
let g:syntastic_php_phpcs_args="--standard=PSR2 -n --report=csv"
let g:syntastic_javascript_checkers = [ 'jshint' ]

" UltiSnips --------------------------------------------------------------------
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"

" Command shortcuts ------------------------------------------------------------
cmap w!! w !sudo tee > /dev/null %
cmap reload source ~/.vimrc

" Disable arrow keys -----------------------------------------------------------
noremap <Up>    <NOP>
noremap <Down>  <NOP>
noremap <Left>  <NOP>
noremap <Right> <NOP>

" Leader shortcuts -------------------------------------------------------------
nmap <leader>a= :Tabularize /=<CR>
nmap <leader>= :call Preserve("normal gg=G")<CR>
nmap <leader>a=> :Tabularize /=><CR>
nmap <leader>a: :Tabularize /:<CR>
nmap <leader>bb :CtrlPBuffer<CR>

" Line shortcuts ---------------------------------------------------------------
let g:move_map_keys = 0 "Diable arrow cursors to move

nmap <C-w>- :rightb new<CR>
nmap <C-w>\| :vnew<CR>
nmap <C-w>t :tabnew<CR>
nmap <C-w><C-h> :tabprevious<CR>
nmap <C-w><C-l> :tabnext<CR>
nmap <C-w><S-h> :vertical res -5<CR>
nmap <C-w><S-j> :res +5<CR>
nmap <C-w><S-k> :res -5<CR>
nmap <C-w><S-l> :vertical res +5<CR>

nnoremap ; :
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

nnoremap <silent> <C-h> :call WinMove('h')<cr>
nnoremap <silent> <C-j> :call WinMove('j')<cr>
nnoremap <silent> <C-k> :call WinMove('k')<cr>
nnoremap <silent> <C-l> :call WinMove('l')<cr>

nnoremap <silent> <C-z> :call ZoomToggle()<CR>

noremap <F12> :NERDTreeToggle<CR>
noremap <C-F12> :NERDTreeFocus<CR>

inoremap <expr> <C-j> ("\<C-n>")
inoremap <expr> <C-k> ("\<C-p>")

vmap <Up> <Plug>MoveBlockUp
vmap <Down> <Plug>MoveBlockDown

nmap <Up> <Plug>MoveLineUp
nmap <Down> <Plug>MoveLineDown

" Autocommands -----------------------------------------------------------------
autocmd BufWritePre * :call Preserve("%s/\\s\\+$//e")
autocmd VimEnter * call StartUp()
autocmd VimEnter * wincmd p
autocmd BufRead,BufNewFile *.done,*.todo,*.task set filetype=taskpaper
autocmd BufRead,BufNewFile *.tpl set filetype=html
autocmd FocusLost * :wa

" Keep cursor on column when leaving INSERT mode
let CursorColumnI = 0
autocmd InsertEnter * let CursorColumnI = col('.')
autocmd CursorMovedI * let CursorColumnI = col('.')
autocmd InsertLeave * if col('.') != CursorColumnI | call cursor(0, col('.')+1) | endif

" Custom functions -------------------------------------------------------------
" Open NERDTree on stat up when no arguments
function! StartUp()
    if 0 == argc()
        NERDTree
    end
endfunction

" Closes vim if the only buffer that's left is the NERDTree buffer
function! s:CloseIfOnlyNerdTreeLeft()
    if exists("t:NERDTreeBufName")
        if bufwinnr(t:NERDTreeBufName) != -1
            if winnr("$") == 1
                q
            endif
        endif
    endif
endfunction

" Executes a command keeping the cursor position
function! Preserve(command)
    "Save last search, and cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")

    " Do the business:
    execute a:command

    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

" Create a split if no movement
function! WinMove(key)
    let t:curwin = winnr()
    exec "wincmd ".a:key
    if (t:curwin == winnr())
        if (match(a:key,'[jk]'))
            vnew
        else
            new
        endif
        exec "wincmd ".a:key
    endif
endfunction

" Zoom / Restore window.
function! ZoomToggle()
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction

function! LightlineReadonly()
    return &ft !~? 'help' && &readonly ? '' : ''
endfunction

function! LightLineModified()
    return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineFilename()
    let fname = expand('%:t')
    return fname == 'ControlP' ? g:lightline.ctrlp_item :
                \ fname == '__Tagbar__' ? g:lightline.fname :
                \ fname =~ '__Gundo\' ? '' :
                \ fname =~ 'NERD_tree' ? 'NERDTree' :
                \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
                \ &ft == 'unite' ? unite#get_status_string() :
                \ &ft == 'vimshell' ? vimshell#get_status_string() :
                \ ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
                \ ('' != fname ? fname : '[No Name]') .
                \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightlineFugitive()
    try
        if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
            let mark = '⭠ '  " edit here for cool mark
            let _ = fugitive#head()
            return strlen(_) ? mark._ : ''
        endif
    catch
    endtry

    return ''
endfunction

function! LightlineFileformat()
    return winwidth(0) > 80 ? &fileformat : ''
endfunction

function! LightlineFiletype()
    return winwidth(0) > 60 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
    return winwidth(0) > 83 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! LightlineMode()
    let fname = expand('%:t')
    return fname == '__Tagbar__' ? 'Tagbar' :
                \ fname == 'ControlP' ? 'CtrlP' :
                \ fname == '__Gundo__' ? 'Gundo' :
                \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
                \ fname =~ 'NERD_tree' ? '' :
                \ &ft == 'unite' ? 'Unite' :
                \ &ft == 'vimfiler' ? 'VimFiler' :
                \ &ft == 'vimshell' ? 'VimShell' :
                \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! CtrlPMark()
    if expand('%:t') =~ 'ControlP'
        call lightline#link('iR'[g:lightline.ctrlp_regex])
        return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
                    \ , g:lightline.ctrlp_next], 0)
    else
        return ''
    endif
endfunction

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
    let g:lightline.ctrlp_regex = a:regex
    let g:lightline.ctrlp_prev = a:prev
    let g:lightline.ctrlp_item = a:item
    let g:lightline.ctrlp_next = a:next
    return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
    return lightline#statusline(0)
endfunction

augroup AutoSyntastic
    autocmd!
    autocmd BufWritePost *.c,*.cpp,*.php call s:syntastic()
augroup END

function! s:syntastic()
    SyntasticCheck
    call lightline#update()
endfunction

" Golang shortcuts  -----------------------------------------------------------------------
autocmd FileType go compiler golang

au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)

au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)

au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)

au FileType go nmap <leader>i <Plug>(go-implements)
au FileType go nmap <leader>r <Plug>(go-run)
let g:golang_goroot = "/home/fran/Projects/go"

" Backup files {
    " Write backup files in /tmp folder
    set backup
    set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
    set backupskip=/tmp/*,/private/tmp/*
    set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
    set writebackup
" }

" Leader tune {
    " Ideas from
    " http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/

    " Remap leader
    let mapleader = "\<Space>"

    " <Space>o to open a new file:
    nnoremap <Leader>o :CtrlP<CR>

    " Type <Space>w to save file
    nnoremap <Leader>w :w<CR>
    nnoremap <Leader>wq :wq<CR>
    nnoremap <Leader>q :q<CR>

    " Copy & paste to system clipboard with <Space>p and <Space>y
    " copy
    vmap <Leader>y "+y
    " cut
    vmap <Leader>d "+d
    " paste
    vmap <Leader>p "+p
    nmap <Leader>P "+P

    " Enter visual line mode with <Space><Space>
    nmap <Leader><Leader> V

    " Use region expanding
    vmap v <Plug>(expand_region_expand)
    vmap <C-v> <Plug>(expand_region_shrink)
" }
"


