[[ $(uname -m) = "arm64" ]] && HOMEBREW_PREFIX="/opt/homebrew" || HOMEBREW_PREFIX="/usr/local"

# For Mac
export EDITOR=vim
export LANG=ja_JP.UTF-8
export PATH=$HOME/bin:$PATH

# go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

# postgresql
export PGDATA=$HOMEBREW_PREFIX/var/postgres

# openssl
export OPENSSL_INCLUDE="$HOMEBREW_PREFIX/opt/openssl/include"
export OPENSSL_LIB="$HOMEBREW_PREFIX/opt/openssl/lib"
export LDFLAGS=-L$HOMEBREW_PREFIX/opt/openssl/lib
export CPPFLAGS=-I$HOMEBREW_PREFIX/opt/openssl/include

# homebrew
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_EDITOR="$EDITOR"
export PATH=/opt/homebrew/bin:/usr/local/bin:$PATH

export LDFLAGS="-L$HOMEBREW_PREFIX/opt/ncurses/lib"
export CPPFLAGS="-I$HOMEBREW_PREFIX/opt/ncurses/include"

# nodebrew
export NODEBREW_ROOT=$HOMEBREW_PREFIX/var/.nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH=$HOMEBREW_PREFIX/var/nodebrew/current/bin:$PATH
export PATH=$HOMEBREW_PREFIX/opt/llvm/bin:$PATH

# rust
export PATH=$HOME/.cargo/bin:$PATH
#export PATH=/usr/local/opt/python/libexec/bin:$PATH

# phpenv
export PATH="$HOME/.phpenv/bin:$PATH"

# google
export PATH="$HOME/google-cloud-sdk/bin:$PATH"

# lldb
export LLDB_DEBUGSERVER_PATH=/Library/Developer/CommandLineTools/Library/PrivateFrameworks/LLDB.framework/Versions/A/Resources/debugserver

# deno
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# gsed
export PATH="$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin:$PATH"
