function clr() {
    for x in {0..8}; do 
        for i in {30..37}; do 
            for a in {40..47}; do 
                echo -ne "\e[$x;$i;$a""m\\\e[$x;$i;$a""m\e[0;38;40m "
            done
            echo
        done
    done
    echo

    for c in {000..255}; do
        echo -n "\e[38;5;${c}m $c"
        [ $(($c%16)) -eq 15 ] && echo
    done
    echo
}
