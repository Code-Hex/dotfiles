is-at-least 4.3.12 && __() {
    ZSH=$DOTZSH
    MARKPATH=$ZSH/run/marks

    _bookmark_directory_name() {
        emulate -L zsh
        setopt extendedglob
        case $1 in
            d)
                # Turn the directory into a shortest name using
                # bookmarks. We need to sort them by length of solved
                # path.
                local link slink
                local -A links
                local cache=$ZSH/run/bookmarks-$HOST-$UID
                if [[ -f $cache ]] && [[ $MARKPATH -ot $cache ]]; then
                    . $cache
                else
                    for link ($MARKPATH/*(N@)) links[${#link:A}$'\0'${link:A}]=${link:t}
                    print -r "links=( ${(kv@)^^links} )" > $cache
                fi
                for slink (${(@On)${(k)links}}) {
                    link=${slink#*$'\0'}
                    if [[ $2 = (#b)(${link})(|/*) ]]; then
                        typeset -ga reply
                        reply=("@"${links[$slink]} $(( ${#match[1]} )) )
                        return 0
                    fi
                }
                return 1
                ;;
            n)
                # Turn the name into a directory
                [[ $2 != (#b)"@"(?*) ]] && return 1
                typeset -ga reply
                reply=(${${:-$MARKPATH/$match[1]}:A})
                return 0
                ;;
            c)
                # Completion
                local expl
                local -a dirs
                dirs=($MARKPATH/*(N@:t))
                dirs=("@"${^dirs})
                vbe-remove-slash-after-bookmark () {
                    case $KEYS in
                        '/'|' '|$'\n'|$'\r')
                            LBUFFER="${LBUFFER[0,-2]}"
                            ;;
                    esac
                }
                _wanted dynamic-dirs expl 'bookmarked directory' compadd -S\]/ -R vbe-remove-slash-after-bookmark -a dirs
                return
                ;;
            *)
                return 1
                ;;
        esac
        return 0
    }

    add-zsh-hook zsh_directory_name _bookmark_directory_name

    vbe-insert-bookmark() {
        emulate -L zsh
        LBUFFER=${LBUFFER}"~[@"
    }
    zle -N vbe-insert-bookmark
    bindkey '@@' vbe-insert-bookmark

    # Manage bookmarks
    bookmark() {
        [[ -d $MARKPATH ]] || mkdir -p $MARKPATH
        if (( $# == 0 )); then
            # When no arguments are provided, just display existing
            # bookmarks
            for link in $MARKPATH/*(N@); do
                local markname="$fg[green]${link:t}$reset_color"
                local markpath="$fg[blue]${link:A}$reset_color"
                printf "%-24s -> %s\n" $markname $markpath
            done
        else
            # Otherwise, we may want to add a bookmark or delete an
            # existing one.
            local -a delete
            zparseopts -D d=delete
            if (( $+delete[1] )); then
                # With `-d`, we delete an existing bookmark
                command rm $MARKPATH/$1
            else
                # Otherwise, add a bookmark to the current
                # directory. The first argument is the bookmark
                # name. `.` is special and means the bookmark should
                # be named after the current directory.
                local name=$1
                [[ $name == "." ]] && name=${PWD:t}
                ln -s $PWD $MARKPATH/$name
            fi
            # Clean up the cache
            command rm $ZSH/run/bookmarks-$HOST-$UID
        fi
    }
} && __
