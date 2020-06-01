" Autocommands
autocmd VimEnter * call StartUp()
autocmd VimEnter * wincmd p
autocmd VimEnter * call UpdateNeomakePHPCS()
autocmd VimEnter * call UpdateNeomakeCssLint()
autocmd VimEnter * call UpdateNeomakeJsHint()

autocmd BufRead,BufNewFile *.md setlocal spell
autocmd BufRead,BufNewFile *.done,*.todo,*.task set filetype=taskpaper
autocmd BufWritePre * :call Preserve(":call TrimWhiteSpaces()")
autocmd BufRead,BufNewFile *.tpl,*.twig set filetype=html
autocmd BufWritePost *.less :silent !find public/themes public/assets -name main.less | xargs touch

autocmd User NeomakeFinished call lightline#update()


if has('ncm2')
  autocmd BufEnter * call ncm2#enable_for_buffer()
endif

autocmd BufEnter,BufWritePost *.php let g:debug = system('ag var_dump ' . expand('%:T') . ' | wc -l') | call lightline#update()
autocmd BufEnter,BufWritePost *.js  let g:debug = system('ag console.log ' . expand('%:T') . ' | wc -l') | call lightline#update()
autocmd BufLeave *.* let g:debug = '' | call lightline#update()

autocmd! User GoyoEnter nested call GoyoEnter()
autocmd! User GoyoLeave nested call GoyoLeave()

autocmd FocusLost * :w
