# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

#起動時にfortuneでcowsay
function random_cowsay() {
   fortune -s -n 100 | cowsay -f `ls -1 /usr/local/Cellar/cowsay/3.03/share/cows/ | sed s/\.cow// | tail -n +\`echo $(( 1 + (\\\`od -An -N2 -i /dev/random\\\`) % (\\\`ls -1 /usr/local/Cellar/cowsay/3.03/share/cows/ | wc -l\\\`) ))\` |  head -1` | toilet --gay -f term
}

if which fortune cowsay >/dev/null; then
    (afplay $HOME/coin.wav &)
    echo $(date +%Y\ %m\ %d\ %H:%M:%S) | toilet --gay -f term
    while :
    do
        random_cowsay 2>/dev/null && break
    done
fi && unset -f random_cowsay

# プロンプト
# 1行表示
# PROMPT="%~ %# "
PROMPT="%n@%m%  %F{red}[%f%~%F{red}]%f %# "

# 環境変数
export LANG=ja_JP.UTF-8

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
function google () {
  web_search "https://www.google.co.jp/search?&q=" "+" "" $@
}

# githubで検索
function github () {
  web_search "https://github.com/search?type=Code&q=" "+" "" $@
}

# stackoverflowで検索
function stack () {
  web_search "http://stackoverflow.com/search?q=" "+" "" $@
}

# 補間
plugins=(github cpanm brew ps)
fpath=(/path/to/homebrew/share/zsh-completions $fpath)

autoload -U compinit
compinit

# 色を使用出来るようにする
autoload -Uz colors
colors

# オプション
# 日本語ファイル名を表示可能にする
setopt extended_glob

# beep を無効にする
setopt no_beep

# フローコントロールを無効にする
setopt no_flow_control

# '#' 以降をコメントとして扱う
setopt interactive_comments

# ディレクトリ名だけでcdする
setopt auto_cd
function chpwd () { ls -aG -F -T }

# cd したら自動的にpushdする(cdの履歴)
setopt auto_pushd

# 重複したディレクトリを追加しない
setopt pushd_ignore_dups

# = の後はパス名として補完する
setopt magic_equal_subst

# 同時に起動したzshの間でヒストリを共有する
setopt share_history

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# ヒストリファイルに保存するとき、すでに重複したコマンドがあったら古い方を削除する
setopt hist_save_nodups

# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# 補完候補が複数あるときに自動的に一覧表示する
setopt auto_menu

# 高機能なワイルドカード展開を使用する
setopt extended_glob

#remem
alias remem='du -sx / &> /dev/null & sleep 25 && kill $!'

#plenv
export PATH="$HOME/.plenv/bin:$PATH"
eval "$(plenv init -)"

#jman
alias jman='env LANG=ja_JP.UTF-8 man'

#groff
alias groff='/usr/local/bin/groff'

#python
#export PATH=/usr/local/share/python:$PATH

#シェルの再起動
alias restart='exec zsh -l'

#ls
eval $(gdircolors ~/dircolors.256dark)
#alias ls='ls -aG -F -T'
alias ls='gls -aG -F -T 0 --color=auto'

#coin at enter
#autoload -Uz add-zsh-hook
#function coin(){
#    (afplay coin.wav &)
#}
#add-zsh-hook precmd coin

#function jump(){
#    (afplay $HOME/jump.wav &)
#}
#add-zsh-hook chpwd jump

#function die(){
#    (afplay $HOME/exit.wav &)
#}
#add-zsh-hook zshexit die

#alias reply='PERL_RL=Caroline reply'
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# You should check using vim version
alias vim='/usr/local/Cellar/vim/7.4.903/bin/vim'
alias vi='/usr/local/Cellar/vim/7.4.903/bin/vim'

export THEOS=/opt/theos

#go
export GOPATH=$HOME/Desktop/go
export PATH=$PATH:$GOPATH/bin
