" CtrlP
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command='ag -Q -l --nocolor --hidden -g "" %s'
  " ag is fast enough that CtrlP
  let g:ctrlp_use_caching = 0
  let g:ctrlp_dont_split = 'nerdtree'
  let g:ctrlp_extensions = ['funky']
  let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:20,results:20'
  let g:ctrlp_max_depth=20
  let g:ctrlp_max_files=0
  let g:ctrlp_switch_buffer=0
  let g:ctrlp_working_path_mode="ra"
  let g:ctrlp_status_func = {
        \ 'main': 'CtrlPStatusMain',
        \ 'prog': 'CtrlPStatusProg',
        \ }
  let g:ctrlp_funky_syntax_highlight = 1

  if !exists(":Ag")
    command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
    nnoremap \ :Ag<SPACE>
  endif
endif

" Deoplete/Neocomplete
if has('nvim')
    let g:deoplete#enable_at_startup = 1
else
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#max_list = 10
endif

" Easy-align
nmap ga <Plug>(EasyAlign)
vmap <Enter> <Plug>(EasyAlign)

" Easy-motion
nmap <leader>s <Plug>(easymotion-s)
nmap <leader>ss <Plug>(easymotion-s2)

" Editorconfig
let g:EditorConfig_exec_path = '/usr/bin/editorconfig'

" Emmet
let g:user_emmet_leader_key='<C-w>'

" Lightline
let g:lightline = {
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], ['ctrlpmark'] ],
    \   'right': [ [ 'lineinfo' ], [ 'percent', 'debug', 'neomake' ] ]
    \ },
    \ 'colorscheme': 'solarized_custom',
    \ 'component_function': {
    \     'ctrlpmark': 'LightlineCtrlP',
    \     'fileencoding': 'LightlineFileEncoding',
    \     'fileformat': 'LightlineFileFormat',
    \     'filename': 'LightlineFileName',
    \     'filetype': 'LighlineFileType',
    \     'fugitive': 'LightlineFugitive',
    \     'mode': 'LightlineMode',
    \ },
    \ 'component_expand': {
    \   'neomake': 'LightlineNeomake',
    \   'debug': 'LightlineDebug'
    \ },
    \ 'component_type': {
    \   'debug': 'warning',
    \   'neomake': 'error',
    \ },
    \ 'separator': { 'left': '', 'right': ''  },
    \ 'subseparator': { 'left': '', 'right': ''  }
\ }

" Limelight
" let g:limelight_conceal_ctermfg = 10

" NERD Tree
let NERDTreeHighlightCursorline = 1

" Powerline
set laststatus=2

" Syntastic
let g:syntastic_php_phpmd_post_args="cleancode,codesize,controversial,design,unusedcode"
let g:syntastic_php_phpcs_args="--standard=PSR2 -n --report=csv"
let g:syntastic_javascript_checkers = [ 'jshint' ]

" UltiSnips
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"

" Vim-move
let g:move_map_keys = 0

" Golang
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let g:syntastic_go_checkers = ['go', 'golint', 'errcheck']
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go']  }

au Filetype go nnoremap <leader>v :vsp <CR>:exe "GoDef" <CR>
au Filetype go nnoremap <leader>s :sp <CR>:exe "GoDef"<CR>
au Filetype go nnoremap <leader>t :tab split <CR>:exe "GoDef"<CR>
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-GoyoLeavetab)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <leader>i <Plug>(go-implements)
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>rt <Plug>(go-run-tab)
au FileType go nmap <Leader>rs <Plug>(go-run-split)
au FileType go nmap <Leader>rv <Plug>(go-run-vertical)

" Simplenote
if filereadable(expand('~/.simplenoterc'))
  source ~/.simplenoterc
endif

" Neomake
let g:neomake_php_phpmd_maker = {
    \ 'args': [ '%p', 'text', 'cleancode,codesize,controversial,design,unusedcode'  ],
    \ 'errorformat': '%E%f:%l%\s%m'
    \ }

let g:neomake_php_phpcs_maker = {
    \ 'args': [ '--report=csv', '--standard=PSR2' ],
    \ 'errorformat':
        \ '%-GFile\,Line\,Column\,Type\,Message\,Source\,Severity%.%#,'.
        \ '"%f"\,%l\,%c\,%t%*[a-zA-Z]\,"%m"\,%*[a-zA-Z0-9_.-]\,%*[0-9]%.%#',
    \ }
