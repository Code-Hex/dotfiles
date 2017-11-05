# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000


# 色を使用出来るようにする
autoload -Uz colors
colors

setopt extended_glob
setopt no_beep
setopt no_flow_control
setopt interactive_comments
setopt auto_cd
setopt auto_pushd pushdtohome
setopt pushd_ignore_dups
setopt magic_equal_subst
setopt share_history
setopt hist_ignore_all_dups
setopt hist_save_nodups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt auto_menu

function _zplug_plugin_load() {
        export ZPLUG_HOME=/usr/local/opt/zplug
        source $ZPLUG_HOME/init.zsh

        zplug "b4b4r07/enhancd", use:init.sh
        if zplug check "b4b4r07/enhancd"; then
            export ENHANCD_FILTER=fzy
            export ENHANCD_DOT_SHOW_FULLPATH=1
            export ENHANCD_DOT_ARG=...
        fi

        zplug "zsh-users/zsh-autosuggestions"
        zplug "zsh-users/zsh-syntax-highlighting", defer:2


        # Install plugins if there are plugins that have not been installed
        if ! zplug check --verbose; then
            printf "Install? [y/N]: "
            if read -q; then
                echo; zplug install
            fi
        fi

        zplug load
}

case ${OSTYPE} in
    darwin*)
        autoload -Uz vcs_info
        setopt prompt_subst
        zstyle ':vcs_info:*' formats "[%s:%b]"
        zstyle ':vcs_info:*' actionformats '[%s:%b|%a]'
        precmd () { vcs_info }


        cd $(head -n 1 $HOME/.zdirs)

        # For Mac
        export LANG=ja_JP.UTF-8
        export PATH=$HOME/bin:$PATH
        
        # go
        export GOROOT=/usr/local/opt/go/libexec
        export GOPATH=$HOME/Desktop/go
        export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
 
        # NeoCowsay using fortune
        fortune -s -n 100 | cowsay --rainbow --bold --random
        # (afplay start_up.mp3&)

        PROMPT='%n@%m %F{cyan}%~%f %F{green}${vcs_info_msg_0_}%f
%F{$((RANDOM % 7 + 1))}❯%f '
        #PROMPT="%n@%m%  %F{red}[%f%~%F{red}]%f %# "
        # directory stack
        DIRSTACKSIZE=9
        DIRSTACKFILE=~/.zdirs
        if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
            dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
            [[ -d $dirstack[1] ]] && cd $dirstack[1] && cd $OLDPWD
        fi

        eval $(gdircolors ~/dircolors.256dark) # for ls

        # alias ls='ls -aG -F -T'
        alias l='gls -GFT 0 --color=auto'
        alias ls='gls -aGFT 0 --color=auto'
        function chpwd () {
            gls -aGFT 0 --color=auto
            print -l $PWD ${(u)dirstack} > $DIRSTACKFILE
        }
        alias ll='ls -al'
        # 補間
        plugins=(github cpanm brew ps vagrant)
        if [ -e /usr/local/share/zsh-completions ]; then
            fpath=(/usr/local/share/zsh-completions $fpath)
        fi

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

        # homebrew
        export HOMEBREW_NO_AUTO_UPDATE=1

        # nodebrew
        export NODEBREW_ROOT=/usr/local/var/nodebrew
        export PATH=$HOME/.nodebrew/current/bin:$PATH

        export EDITOR=vim
        eval "$(direnv hook zsh)"

        _zplug_plugin_load
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

autoload -U compinit
compinit

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



