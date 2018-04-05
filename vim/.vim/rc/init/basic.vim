" display
set number
set title
set showcmd

" click
set mouse=a
set ttymouse=xterm2

" color
syntax enable
colorscheme molokai
" colorscheme spring-night
let g:molokai_original = 1
" let g:rehash256 = 1

" Search
set ignorecase
set smartcase
set wrapscan
set incsearch hlsearch
nnoremap <ESC><ESC> :<C-u>nohlsearch<CR>
cnoremap <C-n> <C-g>
cnoremap <C-b> <C-t>

" Edit
set autoindent
set showmatch
set smartindent
set cindent

"set paste
set cursorline

" Tab
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set shiftround
set nowrap

" datetime
inoremap <Leader>c <C-R>=strftime('%Y-%m-%dT%H:%M:%S+09:00')<CR>

filetype plugin indent on


" MacのClipBoardと共有する
set clipboard=unnamed,autoselect

" brewでインストールした専用にdeleteキー対応をしておく
set backspace=indent,eol,start

" insertモードでhjkl移動を利用する
imap <C-h> <Left>
imap <C-j> <Down>
imap <C-k> <Up>
imap <C-l> <Right>

" jjでインサートモードからコマンドモード
inoremap <silent> jj <ESC>

" skelton
augroup SkeleatonAu
    autocmd!
    autocmd BufNewFile *.pl 0r ~/.vim/skeltons/skelton.pl
augroup END
