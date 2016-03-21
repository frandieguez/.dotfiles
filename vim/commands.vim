" Save read-only files
cmap w!! w !sudo tee > /dev/null %

" Autocommands
autocmd BufWritePre * :call Preserve("%s/\\s\\+$//e")
autocmd VimEnter * call StartUp()
autocmd VimEnter * wincmd p
autocmd BufRead,BufNewFile *.done,*.todo,*.task set filetype=taskpaper
autocmd BufRead,BufNewFile *.tpl,*.twig set filetype=html

" Keep cursor on column when leaving INSERT mode
let CursorColumnI = 0
autocmd InsertEnter * let CursorColumnI = col('.')
autocmd CursorMovedI * let CursorColumnI = col('.')
autocmd InsertLeave * if col('.') != CursorColumnI | call cursor(0, col('.')+1) | endif

augroup AutoSyntastic
    autocmd!
    autocmd BufWritePost *.* call CheckSyntax()
augroup END
