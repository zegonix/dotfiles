#!/usr/bin/env bash

function __search-history {
    current_line="${READLINE_LINE}"
    command=($(fc -lnr 1 | fzf --scheme=history --tmux --expect=tab,right -q "${current_line}"))

    # restore readline on `escape`
    if [[ -z "${command}" ]]; then
        READLINE_LINE="${current_line}"
        READLINE_POINT=$((0 + ${#current_line}))
        return 0
    fi

    # print command to terminal for editting
    if [[ ${command[0]} = "tab" || ${command[0]} = "right" ]]; then
        edit="true"
        command=(${command[@]:1:${#command[@]}})
    fi

    # strip white space
    command="${command[@]}"
    READLINE_LINE="${command}"
    READLINE_POINT=$((0 + ${#command}))
}

if command -v fzf 2>&1 >/dev/null; then
    bind -r "\C-r"
    bind -x '"\C-r": __search-history'
fi
