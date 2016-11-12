" for golang http://mattn.kaoriya.net/software/vim/20130531000559.htm
set rtp+=$GOROOT/misc/vim
exe "set rtp+=".globpath($GOPATH, "src/github.com/nsf/gocode/vim")
set completeopt=menu,preview
