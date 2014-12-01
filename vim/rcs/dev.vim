au BufWinEnter *.html,*.js,*.css,*.scss,*.scala set ts=2|set sw=2

" Sort selected text
vnoremap <Leader>s :sort<CR>

" Remove extra spaces at the end of the line
autocmd BufWritePre * :%s/\s\+$//e

set nofoldenable

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" copy the previous indentation
set copyindent

" tabs depending of shiftwidht, not tabstop
set smarttab
