set hlsearch
set ignorecase
set smartcase
set incsearch

" active mouse on terminal
set mouse=a

" Turn off swap files
set noswapfile
set nobackup
set nowb

" Avoid problem with robot framework tags
set tags=/dev/null

" Move codeblocks
vnoremap < <gv
vnoremap > >gv

" Better copy&paste
set clipboard=unnamed

" Autoreload
autocmd! bufwritepost .vimrc source %
autocmd! bufwritepost ~/.vim/rcs/* source %

"NERDTree
" I don't want to show it by default now
"autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
map <F9> :NERDTreeToggle<CR>
let NERDTreeShowBookmarks=1

" no idea lol
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" ctrlp ignores
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll|pyc)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

" let's write properly
set spell

" no beeps at all
set noeb vb t_vb=

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>
