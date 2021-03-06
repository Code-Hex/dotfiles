export LESS='-g -i -M -R -S -W'
export PATH=$HOME/.rakudobrew/bin:$PATH # rakudobrew

# plenv
export PATH="$HOME/.plenv/bin:$PATH"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"

# XDG
export XDG_CONFIG_HOME=$HOME/.config

# vim
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/init.vim" | source $MYVIMRC'

