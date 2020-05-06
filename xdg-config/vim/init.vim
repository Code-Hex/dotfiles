set directory=$XDG_CACHE_HOME/vim,~/,/tmp
set backupdir=$XDG_CACHE_HOME/vim,~/,/tmp
set runtimepath+=$XDG_CONFIG_HOME/vim,$XDG_CONFIG_HOME/vim/after
let $MYVIMRC="$XDG_CONFIG_HOME/vim/init.vim"

" truecolor
" For Vim 7.4.1799 or later
if has('termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" 行番号を表示する
set number
set splitright
set tabstop=4
set shiftwidth=4
set backspace=indent,eol,start
" 8進数インクリメントをオフにする
set nrformats-=octal
"ファイル切替時にファイルを隠す
set hidden
"日本語ヘルプを優先的に検索
" set helplang=ja,en
" wrap if long lines
set wrap

set nobackup
set noswapfile
set ttyfast
set lazyredraw
nnoremap <ESC><ESC> :<C-u>nohlsearch<CR>

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=$HOME/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state($HOME.'/.cache/dein')
  call dein#begin($HOME.'/.cache/dein')

  " Let dein manage dein
  " Required:
  call dein#add($HOME.'/.cache/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here like this:
  "call dein#add('Shougo/neosnippet.vim')
  "call dein#add('Shougo/neosnippet-snippets')
  let s:plugin = $XDG_CONFIG_HOME.'/vim/dein/plugins.toml'
  let s:lazy_plugin = $XDG_CONFIG_HOME.'/vim/dein/lazy.toml'
  call dein#load_toml(s:plugin, {'lazy': 0})
  call dein#load_toml(s:lazy_plugin, {'lazy': 1})

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------


" open new split panes to right and below
set splitright
set splitbelow
" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>
" open terminal on ctrl+n
function! s:openTerminal(vertical)
  exe a:vertical ? 'vert term' : 'term'
  exe 'startinsert'
endfunction
command! -nargs=* Term call  s:openTerminal(0)
command! -nargs=* VTerm call s:openTerminal(1)

" enable to input any escape sequence
tmap <expr> <Esc>]b SendToTerm("\<Esc>]b")
func SendToTerm(what)
  call term_sendkeys('', a:what)
  return ''
endfunc


nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)

" This comes first, because we have mappings that depend on leader
" With a map leader it's possible to do extra key combinations
" i.e: <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
" noremap <Leader>w :w!<cr>
" Fast quit
noremap <Leader>q :quit!<CR>
" Fast escape
inoremap jk <Esc>
" Fast moving window
nnoremap <Leader>w <C-w>
" Fast moving back window
noremap <Leader><Leader> <C-w>p
noremap <Leader>: :Term<CR>
noremap <Leader>; :VTerm<CR>
noremap <C-a>\| :VTerm<CR>
noremap <C-a>- :Term<CR>

" Open terminal on new tab
nnoremap <c-a>c :tab term<CR>

" Go to tab by number
" https://superuser.com/a/675119
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

" Move tab
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

" Search
set ignorecase
set smartcase
set wrapscan
set incsearch hlsearch
nnoremap <ESC><ESC> :<C-u>nohlsearch<CR>
cnoremap <C-n> <C-g>
cnoremap <C-b> <C-t>

" Move on insert mode
imap <C-h> <Left>
imap <C-j> <Down>
imap <C-k> <Up>
imap <C-l> <Right>
