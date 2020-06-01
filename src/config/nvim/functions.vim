function! CtrlPStatusMain(focus, byfname, regex, prev, item, next, marked)
    let g:lightline.ctrlp_regex = a:regex
    let g:lightline.ctrlp_prev  = a:prev
    let g:lightline.ctrlp_item  = a:item
    let g:lightline.ctrlp_next  = a:next
    return lightline#statusline(0)
endfunction

function! CtrlPStatusProg(str)
    return lightline#statusline(0)
endfunction

" Goyo
function! GoyoEnter()
  set noshowmode
  set noshowcmd
  set scrolloff=999
  call lightline#disable()
  Limelight
endfunction

function! GoyoLeave()
  set showmode
  set showcmd
  set scrolloff=5
  call lightline#enable()
  Limelight!
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

" Lightline
function! LightlineCtrlP()
    if expand('%:t') =~ 'ControlP'
        call lightline#link('iR'[g:lightline.ctrlp_regex])
        return lightline#concatenate([ g:lightline.ctrlp_prev,
                    \g:lightline.ctrlp_item, g:lightline.ctrlp_next], 0)
    else
        return ''
    endif
endfunction

function! LightlineDebug()
    if g:debug != 0
        return 'D:' . substitute(g:debug, "\n", "", "")
    endif

    return ''
endfunction

function! LightlineFileEncoding()
    return winwidth(0) > 83 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! LightlineFileFormat()
  return winwidth(0) > 80 ? WebDevIconsGetFileFormatSymbol().' '. &fileformat : ''
endfunction

function! LightlineFileName()
    let sname = expand('%:t')
    let fname = expand('%:T')
    return fname == 'ControlP' ? g:lightline.ctrlp_item :
        \ fname == '__Tagbar__' ? '' :
        \ fname =~ '__Gundo\' ? '' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ WebDevIconsGetFileTypeSymbol() . ' ' .
        \ ('' != fname ? (winwidth(0) > 100 ? fname : sname) : '[No Name]') .
        \ ('' != LightlineReadonly() ? ' ' . LightlineReadonly() : '') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFileType()
    return winwidth(0) > 60 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! LightlineFugitive()
    try
        if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
            let mark = ' '  " edit here for cool mark
            let _ = fugitive#head()
            return strlen(_) ? mark._ : ''
        endif
    catch
    endtry


    return ''
endfunction

function! LightlineMode()
    let fname = expand('%:t')
    let mode  = lightline#mode()
    return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~ 'NERD_tree' ? '' :
        \ &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ ''
endfunction

function! LightlineModified()
    return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
    return &ft !~? 'help' && &readonly ? '' : ''
endfunction

function! LightlineNeomake()
    return neomake#statusline#LoclistStatus()
endfunction

function! LightlineNeomakeErrors()
    return substitute(
        \ substitute(neomake#statusline#LoclistStatus(), 'W:.*', '', ''),
        \ 'E:\([0-9]\+\).*',
        \ ' \1',
        \ ''
    \ )
endfunction

function! LightlineNeomakeWarnings()
    return substitute(
        \ substitute(neomake#statusline#LoclistStatus(), 'E:\([0-9]\+\)', '', ''),
        \ '.*W:\([0-9]\+\)',
        \ ' \1',
        \ ''
    \ )
endfunction

" Called once right before you start selecting multiple cursors
function! Multiple_cursors_before()
    call keepcursor#disable()
endfunction

" Called once only when the multiple selection is canceled (default <Esc>)
function! Multiple_cursors_after()
    call keepcursor#enable()
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

" Opens NERDTree on stat up when no arguments
function! StartUp()
    if 0 == argc()
        NERDTree
    end
endfunction

function! TrimWhiteSpaces()
    " Ignore vmail buffer list
    if &filetype == 'vmailMessageList' || &filetype == 'mail'
        return
    endif

    %s/\s\+$//e
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

" Zooms in/out the current split
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

function! s:find_file(dir, file, default)
    let l:found = globpath(a:dir, a:file)
    if filereadable(l:found)
        return l:found
    endif

    let l:parent = fnamemodify(a:dir, ':h')
    if l:parent != a:dir
        return s:find_file(l:parent, a:file, a:default)
    endif

    return a:default
endfunction

function! UpdateNeomakeCssLint()
    let l:dir = expand('%:p:h')
    let l:jshintrc = s:find_file(l:dir, '.csslintrc', '~/.csslintrc')
    call add(g:neomake_css_csslint_maker.args, '--config=' . l:jshintrc)
endfunction

function! UpdateNeomakeJsHint()
    let l:dir = expand('%:p:h')
    let l:jshintrc = s:find_file(l:dir, '.jshintrc', '~/.jshintrc')
    call add(g:neomake_javascript_jshint_maker.args, '--config=' . l:jshintrc)
endfunction

function! UpdateNeomakePHPCS()
    let l:dir = expand('%:p:h')
    let l:phpcs_xml = s:find_file(l:dir, 'phpcs.xml', 'PSR2')
    call add(g:neomake_php_phpcs_maker.args, '--standard=' . l:phpcs_xml)
endfunction

function! UpdateNeomakePHPMD()
    let l:dir = expand('%:p:h')
    let l:phpmd_xml = s:find_file(l:dir, 'phpmd.xml', 'codesize,design,unusedcode,naming')
    call add(g:neomake_php_phpmd_maker.args, l:phpmd_xml)
endfunction
