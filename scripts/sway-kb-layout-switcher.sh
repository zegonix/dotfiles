#!/usr/bin/env bash

function switch_kb_layout {
    layouts="$(echo -e "$(swaymsg -t get_config)" | grep -ioP "(?<=xkb_layout ).*$")"
    layouts="${layouts//\"/}"
    layouts="${layouts//\\/}"

    IFS=","
    layouts=(${layouts})
    unset IFS

    if [[ -z "${layouts[@]}" ]] || ((${#layouts[@]} <= 0)); then
        return 1
    fi

    unset number
    if ((${#layouts[@]} > 16)); then
        number=16
    else
        number=${#layouts[@]}
    fi

    selection="$(printf "%s\n" "${layouts[@]}" | fuzzel --lines ${number} --dmenu)"

    if [[ -z "${selection}" ]]; then
        return 1
    fi

    swaymsg input type:keyboard xkb_layout "${selection}"
}

switch_kb_layout
