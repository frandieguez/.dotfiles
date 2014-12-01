" more than 80c will be red colored
" autocmd ColorScheme * hi ErrorMsg ctermbg=NONE ctermfg=red
" Color for the 80 char column
" autocmd ColorScheme * hi ColorColumn ctermbg=Black guibg=Black ctermfg=NONE guifg=NONE

set expandtab
au BufWinEnter * set autoindent|set ts=4|set sw=4

" flake8
autocmd FileType python map <buffer> <F5> :call Flake8()<CR>
let g:flake8_max_line_length=80

map <Leader>g :call RopeGotoDefinition()<CR>
let ropevim_enable_shortcuts = 1
let g:pymode_rope_goto_def_newwin = "vnew"
let g:pymode_rope_extended_complete = 1
let g:pymode_breakpoint = 0
let g:pymode_syntax = 1
let g:pymode_syntax_builtin_objs = 0
let g:pymode_syntax_builtin_funcs = 0
map <Leader>b Oimport ipdb; ipdb.set_trace()<C-c>
let g:pymode_virtualenv = 1

" Better navigating through omnicomplete option list
" http://stackoverflow.com/questions/2170023/how-to-map-keys-for-popup-menu-in-vim
set completeopt=longest,menuone
function! OmniPopup(action)
    if pumvisible()
        if a:action == 'j'
            return "\<C-N>"
        elseif a:action == 'k'
            return "\<C-P>"
        endif
    endif
    return a:action
endfunction

inoremap <silent><C-j> <C-R>=OmniPopup('j')<CR>
inoremap <silent><C-k> <C-R>=OmniPopup('k')<CR>

" Don't use pylint each save
let g:pymode_lint_write = 0

" 80c & 120c limit, after that, red alert! :)
au BufWinEnter *.py set colorcolumn=80
au BufWinEnter *.py set wrap!
au BufWinEnter *.py let w:m1=matchadd('ErrorMsg', '\%>120v.\+', -1)

"
" This is from a plugin to manage folders
"
" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
finish
endif
let b:did_ftplugin = 1

map <buffer> <S-e> :w<CR>:!/usr/bin/env python % <CR>
map <buffer> gd /def <C-R><C-W><CR>

set foldmethod=expr
set foldexpr=PythonFoldExpr(v:lnum)
set foldtext=PythonFoldText()

map <buffer> f za
map <buffer> F :call ToggleFold()<CR>
let b:folded = 1

function! ToggleFold()
    if( b:folded == 0 )
        exec "normal! zM"
        let b:folded = 1
    else
        exec "normal! zR"
        let b:folded = 0
    endif
endfunction

function! PythonFoldText()

    let size = 1 + v:foldend - v:foldstart
    if size < 10
        let size = " " . size
    endif
    if size < 100
        let size = " " . size
    endif
    if size < 1000
        let size = " " . size
    endif

    if match(getline(v:foldstart), '"""') >= 0
        let text = substitute(getline(v:foldstart), '"""', '', 'g' ) . ' '
    elseif match(getline(v:foldstart), "'''") >= 0
        let text = substitute(getline(v:foldstart), "'''", '', 'g' ) . ' '
    else
        let text = getline(v:foldstart)
    endif

    return size . ' lines:'. text . ' '

endfunction

function! PythonFoldExpr(lnum)

    if indent( nextnonblank(a:lnum) ) == 0
        return 0
    endif

    if getline(a:lnum-1) =~ '^\(class\|def\)\s'
        return 1
    endif

    if getline(a:lnum) =~ '^\s*$'
        return "="
    endif

    if indent(a:lnum) == 0
        return 0
    endif

    return '='

endfunction

" In case folding breaks down
function! ReFold()
    set foldmethod=expr
    set foldexpr=0
    set foldnestmax=1
    set foldmethod=expr
    set foldexpr=PythonFoldExpr(v:lnum)
    set foldtext=PythonFoldText()
    echo
endfunction

" Do not autocomplete after ".", use C-Space instead
let g:jedi#popup_on_dot = 0
let g:jedi#use_tabs_not_buffers = 1
