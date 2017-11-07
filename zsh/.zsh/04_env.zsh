# plenv
if which plenv >/dev/null; then
    eval "$(plenv init -)"
fi

# pyenv
if which pyenv >/dev/null; then
    eval "$(pyenv init -)"
    if which pyenv-virtualenv-init > /dev/null; then
        eval "$(pyenv virtualenv-init -)"
    fi
    export PYENV_VIRTUALENV_DISABLE_PROMPT=1
fi

# rbenv
if which rbenv >/dev/null; then
    eval "$(rbenv init -)"
fi

