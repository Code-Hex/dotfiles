alias l='gls -GFT 0 --color=auto'
alias ls='gls -aGFT 0 --color=auto'
alias ll='ls -al'
alias objdump='gobjdump' # objdump
alias man="env LANG=C man" # man
alias readelf='greadelf' # readelf
alias gti='git'
alias kubectl='kubectl.1.17'
alias k='kubectl'

if which lld >/dev/null; then
    alias ld=lld
fi

alias subl='reattach-to-user-namespace subl' # subl for tmux
alias code='reattach-to-user-namespace /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code' # code for tmux

# suffix aliases
alias -s {pdf,png,jpg,bmp,PDF,PNG,JPG,BMP}='open -a Preview' # like ./filename.pdf
alias -s html='open -a Google\ Chrome' # like ./page.html

function _send_json_to_vim() {
    if (( $# == 0 )) then
        echo 'need a json as an argument'
        return
    fi
    local json=$1
    if ! jq -e . > /dev/null 2>&1 <<<"$json"; then
        echo 'must specify json string'
        return
    fi
    echo -e "\x1b]51;$json\x07"
}

function _vim() {
    if [[ "$VIM_TERMINAL" ]] then
        local args=$@
        local paths=("$PWD" "${args[@]}")
        local tapi_args=$(echo "$paths" | perl -pe 's/(.*?)\s+/"$1",/g' | perl -pe 's/,\z//')
        _send_json_to_vim "[\"call\",\"Tapi_open\",[$tapi_args]]"
        return
    fi
    /usr/local/bin/vim $@
}

alias vi='_vim'
alias vim='_vim'
