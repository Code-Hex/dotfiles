# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

autoload -U compinit
compinit

# 色を使用出来るようにする
autoload -Uz colors
colors

setopt extended_glob          # 高機能なワイルドカード展開を使用する
setopt no_beep                # beep を無効にする
setopt no_flow_control        # フローコントロールを無効にする
setopt interactive_comments   # '#' 以降をコメントとして扱う
setopt auto_cd                # ディレクトリ名だけでcdする
setopt auto_pushd pushdtohome # cd したら自動的にpushdする(cdの履歴)
setopt pushd_ignore_dups      # 重複したディレクトリを追加しない
setopt magic_equal_subst      # = の後はパス名として補完する
setopt share_history          # 同時に起動したzshの間でヒストリを共有する
setopt hist_ignore_all_dups   # 同じコマンドをヒストリに残さない
setopt hist_save_nodups       # ヒストリファイルに保存するとき、すでに重複したコマンドがあったら古い方を削除する
setopt hist_ignore_space      # スペースから始まるコマンド行はヒストリに残さない
setopt hist_reduce_blanks     # ヒストリに保存するときに余分なスペースを削除する
setopt auto_menu              # 補完候補が複数あるときに自動的に一覧表示する

case ${OSTYPE} in
    darwin*)
        cd $(head -n 1 $HOME/.zdirs)

        # For Mac
        export LANG=ja_JP.UTF-8
        
        # go
        export GOROOT=/usr/local/opt/go/libexec
        export GOPATH=$HOME/Desktop/go
        export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
 
        # NeoCowsay using fortune
        fortune -s -n 100 | cowsay --rainbow --bold --random
        # (afplay start_up.mp3&)

        PROMPT="%n@%m%  %F{red}[%f%~%F{red}]%f %# "
        # 検索サイト クエリ で検索可能
        function web_search {
            local url=$1       && shift
            local delimiter=$1 && shift
            local prefix=$1    && shift
            local query

            while [ -n "$1" ]; do
                if [ -n "$query" ]; then
                    query="${query}${delimiter}${prefix}$1"
                else
                    query="${prefix}$1"
                fi
                shift
            done

            open "${url}${query}"
        }

        # googleで検索
        function google() {
            web_search "https://www.google.co.jp/search?&q=" "+" "" $@
        }

        # githubで検索
        function github() {
            web_search "https://github.com/search?type=Code&q=" "+" "" $@
        }

        # stackoverflowで検索
        function stack() {
            web_search "http://stackoverflow.com/search?q=" "+" "" $@
        }

        # directory stack
        DIRSTACKSIZE=9
        DIRSTACKFILE=~/.zdirs
        if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
            dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
            [[ -d $dirstack[1] ]] && cd $dirstack[1] && cd $OLDPWD
        fi

        eval $(gdircolors ~/dircolors.256dark) # for ls

        # alias ls='ls -aG -F -T'
        alias ls='gls -aG -F -T 0 --color=auto'
        function chpwd () {
            gls -aG -F -T 0 --color=auto
            print -l $PWD ${(u)dirstack} > $DIRSTACKFILE
        }
        alias ll='ls -al'
        # 補間
        plugins=(github cpanm brew ps)
        fpath=(/path/to/homebrew/share/zsh-completions $fpath)
        export HOMEBREW_CASK_OPTS="--appdir=/Applications"

        export PGDATA=/usr/local/var/postgres # postgresql

        if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
        export PYENV_VIRTUALENV_DISABLE_PROMPT=1

       
        # openssl
        export OPENSSL_INCLUDE="/usr/local/opt/openssl/include"
        export OPENSSL_LIB="/usr/local/opt/openssl/lib"
        # sublime-text3
        # export PATH=/Applications/Sublime\ Text.app/Contents/SharedSupport/bin:$PATH

        alias vim='/usr/local/bin/vim'
        alias vi='/usr/local/bin/vim'
        alias objdump='gobjdump' # objdump
        alias man="env LANG=C man" # man
        alias readelf='greadelf' # readelf
        alias gti='git'
        
        alias subl='reattach-to-user-namespace subl' # subl for tmux
        alias code='reattach-to-user-namespace /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code' # code for tmux

        # suffix aliases
        alias -s {pdf,png,jpg,bmp,PDF,PNG,JPG,BMP}='open -a Preview' # like ./filename.pdf
        alias -s html='open -a Google\ Chrome' # like ./page.html
        export DYLD_LIBRARY_PATH=$GOPATH/src/github.com/cloudson/gitql/libgit2/install/lib
        ;;
    linux*)
        # For linux(Debian)
        export LANG=en_US.UTF-8
        PROMPT="%n@%m%  %F{blue}[%f%~%F{blue}]%f %# "
        alias ls='ls -aG -F -T 0'
        function chpwd () { ls }
        export GOPATH=$HOME/go
        export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin
        ;;
esac

export LESS='-g -i -M -R -S -W'
export PATH=$HOME/.rakudobrew/bin:$PATH # rakudobrew

alias restart='exec zsh -l' # restart zsh
alias remem='du -sx / &> /dev/null & sleep 25 && kill $!' # remem

# plenv
export PATH="$HOME/.plenv/bin:$PATH"
if which plenv >/dev/null; then
    eval "$(plenv init -)"
fi

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if which pyenv >/dev/null; then
    eval "$(pyenv init -)"
fi

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
if which rbenv >/dev/null; then
    eval "$(rbenv init -)"
fi

# alias reply='PERL_RL=Caroline reply'

if which peco >/dev/null; then

    if which ghq >/dev/null; then
        function peco-ghq() {
            local selected=$(ghq list -p | peco)
            if [ -n "$selected" ]; then
                BUFFER="cd ${selected}"
                zle accept-line
            fi
        }
        zle -N peco-ghq
        bindkey '^]' peco-ghq
    fi

    function prkill() {
        # ps aux | peco | awk '{print $2}' | xargs kill -15
        ps aux | peco | awk '{print $2}' | xargs kill -9
    }

    function exec_peco_history() {
        BUFFER=$(history -n 1 | tail -r | awk '!a[$0]++' | peco)
        CURSOR=$#BUFFER
        zle reset-prompt
    }
    zle -N exec_peco_history
    bindkey '^r' exec_peco_history
fi

export COVERALLS_TOKEN=""
export LDAP_HOST="127.0.0.1"
export LDAP_MANAGER_PASSWORD="horizen-of-akatsuki"
export DB_HOST="127.0.0.1"
export DB_USER_NAME="hibiki"
export DB_USER_PASSWORD="sixth-destroyer-squadron"
