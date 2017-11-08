function confirm() {
    local answer
    echo -ne "zsh: sure you want to run '$fg[yellow]$*$reset_color' [yN]? "
    read -q answer
        echo
    if [[ "${answer}" =~ ^[Yy]$ ]]; then
        command "${@}"
    else
        return 1
    fi
}

function confirm_wrapper() {
    if [ "$1" = '--root' ]; then
        local as_root='true'
        shift
    fi

    local prefix=''

    if [ "${as_root}" = 'true' ] && [ "${USER}" != 'root' ]; then
        prefix="sudo"
    fi
    confirm ${prefix} "$@"
}

reboot() { confirm_wrapper --root $0 "$@"; }
poweroff() { confirm_wrapper --root $0 "$@"; }

function run_under_tmux() {
    # Example usage:
    #   torrent() { run_under_tmux 'rtorrent' '/usr/local/rtorrent-git/bin/rtorrent'; }
    #   mutt() { run_under_tmux 'mutt'; }
    #   irc() { run_under_tmux 'irssi' "TERM='screen' command irssi"; }

    # There is a bug in linux's libevent...
    # export EVENT_NOEPOLL=1
    if [ $TMUX = "" ]; then
		echo "Error: cannot start command with new window from without tmux"
		exit
	fi

    if [ -z "$1" ]; then return 1; fi
    
    local name="$1"
    if [ -n "$2" ]; then
        local execute="$2"
    else
        local execute="command ${name}"
    fi

    if tmux has-session -t "${name}" 2>/dev/null; then
        tmux attach -d -t "${name}"
    else
        tmux new-window -n "${name}" "${execute}"
    fi
}

irc() { run_under_tmux "irssi"; }
