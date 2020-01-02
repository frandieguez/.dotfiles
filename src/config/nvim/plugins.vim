" CtrlP
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command='ag %s --max-count 25 -l --nocolor -g ""'
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
  let g:deoplete#num_processes = 1
  let g:deoplete#enable_at_startup = 1
  let g:deoplete#max_list = 10
endif

" Disable deoplete when in multi cursor mode
function! Multiple_cursors_before()
    let b:deoplete_disable_auto_complete = 1
endfunction
function! Multiple_cursors_after()
    let b:deoplete_disable_auto_complete = 0
endfunction

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
    \ 'colorscheme': 'nord',
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
    \ 'subseparator': { 'left': '', 'right': '' }
\ }

" Limelight
let g:limelight_conceal_ctermfg = 10

" NERD Tree
let NERDTreeHighlightCursorline = 1

" Neomake
let g:neomake_css_csslint_maker = {
      \ 'args': [ '--format=compact' ],
      \ 'errorformat':
      \   '%-G,'.
      \   '%-G%f: lint free!,'.
      \   '%f: line %l\, col %c\, %trror - %m,'.
      \   '%f: line %l\, col %c\, %tarning - %m,'.
      \   '%f: line %l\, col %c\, %m,'.
      \   '%f: %tarning - %m'
      \ }

let g:neomake_php_phpcs_maker = {
    \ 'args': [ '--report=csv' ],
    \ 'errorformat':
        \ '%-GFile\,Line\,Column\,Type\,Message\,Source\,Severity%.%#,'.
        \ '"%f"\,%l\,%c\,%t%*[a-zA-Z]\,"%m"\,%*[a-zA-Z0-9_.-]\,%*[0-9]%.%#',
\ }

let g:neomake_php_phpmd_maker = {
    \ 'args': [ '%p', 'text', 'cleancode,codesize,controversial,design,unusedcode' ],
    \ 'errorformat': '%W%f:%l%\s%\s%#%m'
    \ }

let g:neomake_javascript_jshint_maker = {
    \ 'args': [ '--verbose' ],
    \ 'errorformat': '%A%f: line %l\, col %v\, %m \(%t%*\d\)',
    \ }
" UltiSnips
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"

" Vim-fake
let g:fake_src_paths = [ '~/.vim/autoload/vim-fake' ]

" Vim-move
let g:move_map_keys = 0

" Simplenote
if filereadable(expand('~/.simplenoterc'))
  source ~/.simplenoterc
endif

" Syntastic
let g:syntastic_check_on_open=1
let g:syntastic_eruby_ruby_quiet_messages =
      \ {"regex": "possibly useless use of a variable in void context"}
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
let g:syntastic_javascript_checkers = [ 'jshint' ]
let g:syntastic_php_phpcs_args="--standard=PSR2 -n --report=csv"
let g:syntastic_php_phpmd_post_args="cleancode,codesize,controversial,design,unusedcode"

" Golang
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1

let g:go_auto_type_info = 1

let g:go_addtags_transform = "snakecase"

let g:go_auto_sameids = 1
let g:go_fmt_command = "goimports"

" Error and warning signs.
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'

" Enable integration with airline.
let g:airline#extensions#ale#enabled = 1

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

au Filetype go nmap <leader>ga <Plug>(go-alternate-edit)
au Filetype go nmap <leader>gah <Plug>(go-alternate-split)
au Filetype go nmap <leader>gav <Plug>(go-alternate-vertical)
au FileType go nmap <F10> :GoTest -short<cr>
au FileType go nmap <F9> :GoCoverageToggle -short<cr>
au FileType go nmap <F12> <Plug>(go-def)
" Required for operations modifying multiple buffers like rename.
set hidden

" let g:LanguageClient_serverCommands = {
"   \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
"   \ 'javascript': ['/opt/javascript-typescript-langserver/lib/language-server-stdio.js'],
"   \ }

" Automatically start language servers.
" let g:LanguageClient_autoStart = 1

" nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
" nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
" nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

let g:vdebug_options = {
  \ 'port' : 9001,
  \ 'path_maps' : {
  \   'path/in/container' : 'path/in/computer'
  \ }
\ }


" Vim
let g:indentLine_color_term = 239

let g:coc_global_extensions = [
    \ 'coc-snippets',
    \ 'coc-pairs',
    \ 'coc-tsserver',
    \ 'coc-eslint',
    \ 'coc-json',
    \ 'coc-prettier'
    \ ]
