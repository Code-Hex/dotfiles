if which fzf >/dev/null; then
    function prkill() {
        # ps aux | peco | awk '{print $2}' | xargs kill -15
        ps aux | fzf | awk '{print $2}' | xargs kill -9
    }
    function prterm() {
        ps aux | fzf | awk '{print $2}' | xargs kill -15
    }
    function exec_fzf_history() {
        BUFFER=$(history -n 1 | awk '!a[$0]++' | fzf +s --tac)
        CURSOR=$#BUFFER
        zle reset-prompt
    }
    zle -N exec_fzf_history
    bindkey '^r' exec_fzf_history

    # use ghq
    if which ghq >/dev/null; then
        function peco-ghq() {
            local selected=$(ghq list -p | fzf)
            if [ -n "$selected" ]; then
                BUFFER="cd ${selected}"
                zle accept-line
            fi
        }
        zle -N peco-ghq
        bindkey '^]' peco-ghq
    fi
fi
