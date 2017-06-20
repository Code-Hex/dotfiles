let s:path = expand('$CACHE/dein')
if !dein#load_state(s:path)
  finish
endif

call dein#begin(s:path, expand('<sfile>'))
call dein#load_toml('~/.vim/rc/dein/dein.toml', {'lazy': 0})
call dein#load_toml('~/.vim/rc/dein/deinlazy.toml', {'lazy' : 1})

" disable neobundle
call dein#disable('neobundle.vim')

call dein#end()
call dein#save_state()

if dein#check_install()
  call dein#install()
endif
