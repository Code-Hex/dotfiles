cd $(head -n 1 $HOME/.zdirs)
 
# directory stack
DIRSTACKSIZE=9
DIRSTACKFILE=~/.zdirs
if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
    dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
    [[ -d $dirstack[1] ]] && cd $dirstack[1] && cd $OLDPWD
fi

eval $(gdircolors $HOME/.dircolor) # for ls

# alias ls='ls -aG -F -T'
function chpwd() {
    gls -aGFT 0 --color=auto
    print -l $PWD ${(u)dirstack} > $DIRSTACKFILE
}

eval "$(direnv hook zsh)"

