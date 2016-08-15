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
let g:molokai_original = 1
" let g:rehash256 = 1

" Search
set ignorecase
set smartcase
set wrapscan
set hlsearch

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
set clipboard+=unnamed

" brewでインストールした専用にdeleteキー対応をしておく
set backspace=indent,eol,start

if 0 | endif

if has('vim_starting')
    if &compatible
        set nocompatible               " Be iMproved
    endif

    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

" ファイルをtree表示してくれる
NeoBundle 'scrooloose/nerdtree'

" コメントON/OFFを手軽に実行
NeoBundle 'tomtom/tcomment_vim'
" ファイル操作の強化
NeoBundle 'Shougo/vimfiler'

" ステータスバーの強化
NeoBundle 'itchyny/lightline.vim'

" ^P でファイルのインクリメンタルサーチ
NeoBundle 'kien/ctrlp.vim'

call neobundle#end()

filetype plugin indent on

NeoBundleCheck


" lightline起動コード
" lightline {{{
set laststatus=2

let g:lightline = {
        \ 'colorscheme': 'solarized',
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
        \ },
        \ 'component_function': {
        \   'modified': 'LightLineModified',
        \   'readonly': 'LightLineReadonly',
        \   'fugitive': 'LightLineFugitive',
        \   'filename': 'LightLineFilename',
        \   'fileformat': 'LightLineFileformat',
        \   'filetype': 'LightLineFiletype',
        \   'fileencoding': 'LightLineFileencoding',
        \   'mode': 'LightLineMode'
        \ }
        \ }

function! LightLineModified()
    return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
    return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! LightLineFilename()
  return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
    try
        if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
            return fugitive#head()
        endif
    catch
    endtry
    return ''
endfunction

function! LightLineFileformat()
    return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
    return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
    return winwidth(0) > 60 ? lightline#mode() : ''
endfunction
" }}}

" insertモードでhjkl移動を利用する
imap <C-h> <Left>
imap <C-j> <Down>
imap <C-k> <Up>
imap <C-l> <Right>

" jjでインサートモードからコマンドモード
inoremap <silent> jj <ESC>

" for golang http://mattn.kaoriya.net/software/vim/20130531000559.htm
set rtp+=$GOROOT/misc/vim
exe "set rtp+=".globpath($GOPATH, "src/github.com/nsf/gocode/vim")
set completeopt=menu,preview

