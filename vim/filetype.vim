" local filetype file
" loads various extra filetypes

if exists("did_load_filetypes")
    finish
endif

augroup filetypedetect
    au! BufRead,BufNewFile *.pde  setfiletype arduino

    autocmd BufRead *.{vala,vapi} set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
    au BufRead,BufNewFile *.{vala,vapi} setfiletype vala

    au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn} setfiletype mkd

    au BufRead,BufNewFile *.go setfiletype go

    au BufWinEnter *.scss set filetype=css

    au BufWinEnter *.thrift set filetype=thrift

    au BufWinEnter *.json set filetype=javascript
augroup END
