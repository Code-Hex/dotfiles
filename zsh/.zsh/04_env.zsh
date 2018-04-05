function exists() {
    type $1 > /dev/null
    [ $? = 0 ]
}

# plenv
if exists plenv; then
    eval "$(plenv init -)"
fi

# pyenv
if exists pyenv; then
    eval "$(pyenv init -)"
    if which pyenv-virtualenv-init > /dev/null; then
        eval "$(pyenv virtualenv-init -)"
    fi
    export PYENV_VIRTUALENV_DISABLE_PROMPT=1
fi

# rbenv
if exists rbenv; then
    eval "$(rbenv init -)"
fi

# phpenv
if exists phpenv; then
    eval "$(phpenv init -)"
fi


