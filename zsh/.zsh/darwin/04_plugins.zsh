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


# autocompletion
plugins=(github cpanm brew ps vagrant)
if [ -e /usr/local/share/zsh-completions ]; then
    fpath=(/usr/local/share/zsh-completions $fpath)
fi

_zplug_plugin_load
