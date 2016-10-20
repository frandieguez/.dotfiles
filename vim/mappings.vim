" Remap leader
let mapleader = "\<Space>"

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
nmap <Leader>w :w<CR> " Save file
nmap <Leader>wq :wq<CR> " Save and quit
nmap <Leader>q :q<CR> " Quit
cmap ww w !sudo tee > /dev/null %

" Clean searches with Enter
nnoremap <CR> :nohl<CR><CR>

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
nmap <leader>g :Gstatus<CR>
nnoremap <Leader>fu :CtrlPFunky<Cr>
nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
noremap <F12> :NERDTreeTabsToggle<CR>
noremap <F8> :TagbarToggle<CR>

" CamelCaseMotion
map <silent> ,w <Plug>CamelCaseMotion_w
map <silent> ,b <Plug>CamelCaseMotion_b
map <silent> ,e <Plug>CamelCaseMotion_e
map <silent> ,ge <Plug>CamelCaseMotion_ge

" Movement for neocomplete
inoremap <expr> <C-j> ("\<C-n>")
inoremap <expr> <C-k> ("\<C-p>")

" Neomake
nmap <leader>tn :let g:neomake_open_list=1<CR>
nmap <leader>tN :let g:neomake_open_list=0<CR>

" Vim-move
nmap <Down> <Plug>MoveLineDown
nmap <Up> <Plug>MoveLineUp
vmap <Down> <Plug>MoveBlockDown
vmap <Up> <Plug>MoveBlockUp

vmap <Leader>y "+y copy to system clipboard
vmap <Leader>d "+d cut to system clipboard
vmap <Leader>p "+p paste from system clipboard
nmap <Leader>P "+P
nmap <Leader><Leader> V " Enter visual line mode with <Space><Space>
nmap <Leader>o :CtrlP<CR> " <Space>o to open a new file

" Use region expanding
" vmap v <Plug>(expand_region_expand)
" vmap <C-v> <Plug>(expand_region_shrink)
