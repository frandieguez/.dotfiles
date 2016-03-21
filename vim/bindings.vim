" Disable arrow keys
noremap <Up>    <NOP>
noremap <Down>  <NOP>
noremap <Left>  <NOP>
noremap <Right> <NOP>

" Vim shortcuts
nnoremap ; :
nmap <leader>r :source $MYVIMRC<CR>
nmap <leader>e :tabedit $MYVIMRC<CR>
nmap <leader>w :w!<CR>

" Split shortcuts
nmap <C-w>- :rightb new<CR>
nmap <C-w>\| :vnew<CR>
nmap <C-w>t :tabnew<CR>
nmap <C-w><C-h> :tabprevious<CR>
nmap <C-w><C-l> :tabnext<CR>
nmap <C-w><S-h> :vertical res -5<CR>
nmap <C-w><S-j> :res +5<CR>
nmap <C-w><S-k> :res -5<CR>
nmap <C-w><S-l> :vertical res +5<CR>

" Function shortcuts
nnoremap <silent> <C-h> :call WinMove('h')<cr>
nnoremap <silent> <C-j> :call WinMove('j')<cr>
nnoremap <silent> <C-k> :call WinMove('k')<cr>
nnoremap <silent> <C-l> :call WinMove('l')<cr>
nnoremap <silent> <C-z> :call ZoomToggle()<CR>

" Plugin shortcuts
nmap <leader>= :call Preserve("normal gg=G")<CR>
nmap <leader>a= :Tabularize /=<CR>
nmap <leader>a=> :Tabularize /=><CR>
nmap <leader>a: :Tabularize /:<CR>
nmap <leader>bb :CtrlPBuffer<CR>
nnoremap <Leader>fu :CtrlPFunky<Cr>
nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
noremap <F12> :NERDTreeTabsToggle<CR>

" Movement for neocomplete
inoremap <expr> <C-j> ("\<C-n>")
inoremap <expr> <C-k> ("\<C-p>")

" Vim-move
map <Down> <Plug>MoveLineDown
nmap <Up> <Plug>MoveLineUp
vmap <Down> <Plug>MoveBlockDown
vmap <Up> <Plug>MoveBlockUp

" Remap leader
let mapleader = "\<Space>"
nmap <Leader><Leader> V " Enter visual line mode with <Space><Space>
nnoremap <Leader>o :CtrlP<CR> " <Space>o to open a new file
nnoremap <Leader>w :w<CR> " Save file
nnoremap <Leader>wq :wq<CR> " Save and quit
nnoremap <Leader>q :q<CR> " Quit
vmap <Leader>y "+y copy to system clipboar
vmap <Leader>d "+d cut to system clipboar
vmap <Leader>p "+p paste from system clipboar
nmap <Leader>P "+P

" Golang shortcuts
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

" Use region expanding
" vmap v <Plug>(expand_region_expand)
" vmap <C-v> <Plug>(expand_region_shrink)

