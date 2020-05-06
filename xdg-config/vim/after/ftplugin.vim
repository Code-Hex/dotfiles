set number
set splitright
set tabstop=4
set shiftwidth=4
set modifiable
" 改行時にコメントしない
" set formatoptions-=c
" set formatoptions-=r
" set formatoptions-=o
au FileType * set fo-=c fo-=r fo-=o
au BufWritePre * :%s/\s\+$//e

" vertical split bordar
"set statusline=─
set fillchars+=vert:\│
"set fillchars+=stlnc:\─
"set fillchars+=stl:\─
au FileType * hi VertSplit cterm=none
"au FileType * hi StatusLineNC cterm=none
"au FileType * hi StatusLineNC cterm=none
