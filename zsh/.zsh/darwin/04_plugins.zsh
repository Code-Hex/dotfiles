function _plugin_load() {
    # zsh-syntax-highlighting
    ZSH_HIGHLIGHT_FILE=/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    if [ -f "$ZSH_HIGHLIGHT_FILE" ]; then
        export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/usr/local/share/zsh-syntax-highlighting/highlighters
        source $ZSH_HIGHLIGHT_FILE
    else
        echo 'You should run: "brew install zsh-syntax-highlighting"'
    fi

    # zsh-autosuggestions
    ZSH_AUTO_SUGGESTION_FILE=/usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    if [ -f "$ZSH_AUTO_SUGGESTION_FILE" ]; then
        source $ZSH_AUTO_SUGGESTION_FILE
    else
        echo 'You should run: "brew install zsh-autosuggestions"'
    fi
}

source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# autocompletion
fpath=(/Users/codehex/.zsh/darwin/completions $fpath)

plugins=(github cpanm brew ps vagrant)
if [ -e /usr/local/share/zsh-completions ]; then
    fpath=(/usr/local/share/zsh-completions $fpath)
fi

#_zplug_plugin_load
