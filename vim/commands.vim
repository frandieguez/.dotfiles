" Autocommands
autocmd VimEnter * call StartUp()
autocmd VimEnter * wincmd p

autocmd BufRead,BufNewFile *.done,*.todo,*.task set filetype=taskpaper
autocmd BufWritePre * :call Preserve(":call TrimWhiteSpace()")
autocmd BufRead,BufNewFile *.tpl,*.twig set filetype=html
autocmd BufWritePost *.* Neomake

autocmd User NeomakeFinished call lightline#update()

autocmd BufEnter,BufWritePost *.php let g:debug = system('ag var_dump ' . expand('%:T') . ' | wc -l') | call lightline#update()
autocmd BufEnter,BufWritePost *.js  let g:debug = system('ag console.log ' . expand('%:T') . ' | wc -l') | call lightline#update()
autocmd BufLeave *.* let g:debug = '' | call lightline#update()
autocmd BufWritePost *.less :silent !find public/themes public/assets -name main.less | xargs touch
