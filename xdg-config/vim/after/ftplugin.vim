set number
set splitright
set tabstop=4
set shiftwidth=4
set modifiable
au FileType * set fo-=c fo-=r fo-=o
au BufWritePre * :%s/\s\+$//e

" vertical split border
set fillchars+=vert:\│
au FileType * hi VertSplit cterm=none
