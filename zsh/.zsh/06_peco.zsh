if which peco >/dev/null; then
    function prkill() {
        # ps aux | peco | awk '{print $2}' | xargs kill -15
        ps aux | peco | awk '{print $2}' | xargs kill -9
    }
    function prterm() {
        ps aux | peco | awk '{print $2}' | xargs kill -15
    }
    function exec_peco_history() {
        BUFFER=$(history -n 1 | tail -r | awk '!a[$0]++' | peco)
        CURSOR=$#BUFFER
        zle reset-prompt
    }
    zle -N exec_peco_history
    bindkey '^r' exec_peco_history

    # use ghq
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
fi
