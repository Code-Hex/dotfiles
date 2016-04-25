# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# プロンプト
# 1行表示
# PROMPT="%~ %# "
PROMPT="%n@%m%  %F{blue}[%f%~%F{blue}]%f %# "

# 補間
autoload -U compinit
compinit

# 色を使用出来るようにする
autoload -Uz colors
colors

# オプション
# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# beep を無効にする
setopt no_beep

# フローコントロールを無効にする
setopt no_flow_control

# '#' 以降をコメントとして扱う
setopt interactive_comments

# ディレクトリ名だけでcdする
setopt auto_cd
function chpwd () { ls -aG -F -T 0 }

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

#シェルの再起動
alias restart='exec -l $SHELL'

#ls
alias ls='ls -aG -F -T 0'
