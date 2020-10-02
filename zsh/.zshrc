
function loadlib() {
        lib=$1
        [[ -f $lib ]] && . $lib || echo "Could not load $lib"
}

export DOTZSH=$HOME/.zsh

function _main() {
    # loads common zsh files
    for zsh in $DOTZSH/*.zsh; do
        loadlib $zsh
    done
    
    # loads zsh files for only os
    local OS=$(echo $OSTYPE | perl -pne 's/([a-zA-Z]+).*/$1/g')
    for zsh in $DOTZSH/$OS/*.zsh; do
        loadlib $zsh
    done
}

_main

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/codehex/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/codehex/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/codehex/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/codehex/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
