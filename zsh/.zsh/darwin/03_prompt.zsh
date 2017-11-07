

function _make_prompt() {
    local _newline=$'\n'
    local _separator=$'\ue0b0'
    local _sub_separator=$'\ue0b1'

    local rand=${RANDOM}
    local colors=($(($rand % 7 + 1)), $((($rand + 1) % 7 + 1)), $((($rand + 2) % 7 + 1)))
    local top="%n@%m %F{red}[%f%~%F{red}]%f ${vcs_info_msg_0_}"
    local bottom="%F{$colors[1]}❯%f%F{$colors[2]}❯%f%F{$colors[3]}❯%f "
    eval "$1='${top}${_newline}${bottom}'"
}

autoload -Uz vcs_info
local branch=$'\ue0a0'
zstyle ':vcs_info:*' formats "%F{cyan}$branch %b %f"
zstyle ':vcs_info:*' actionformats "%F{cyan}$branch %b|%a %f"
precmd() {
    vcs_info
    _make_prompt PROMPT
    # PROMPT="%n@%m%  %F{red}[%f%~%F{red}]%f %# "
}


# NeoCowsay using fortune
fortune -s -n 100 | cowsay --rainbow --bold --random
# (afplay start_up.mp3&)


