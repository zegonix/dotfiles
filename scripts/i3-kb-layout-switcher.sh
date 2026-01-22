#!/usr/bin/env bash

function switch_kb_layout {
    layouts=("us", "us")
    variants=("default, intl")
    languages="$(echo "${devices}" | grep -ioP '(?<="layout": ").*(?=")' -m 1)"
    variants="$(echo "${devices}" | grep -ioP '(?<="variant": ").*(?=")' -m 1)"

    ## TODO: use `setxkbmap -print` to get status
    current="$(echo "${devices}" | grep -ioP '(?<="active_layout_index": ).*(?=,)' -m 1)"

    languages=(${languages})
    variants=(${variants})

    number=$((${#languages[@]} - 1))
    for n in $(seq 0 $number); do
        layouts+=("${languages[$n]//,/} - ${variants[$n]//,/}")
    done

    if $(which rofi &>/dev/null); then
        # selection="$(printf "%s\n" "${layouts[@]}" | fuzzel --lines ${#layouts[@]} --dmenu --select-index ${current})"
        return 1
    else
        notify-send "layout-switcher" "requires [rofi]"
        return 1
    fi

    for n in $(seq 0 $number); do
        if [[ "${layouts[$n]}" == "${selection}" ]]; then
            index=$n
            break
        fi
    done
    if [[ -z "${index}" ]]; then
        return 1
    fi

    hyprctl switchxkblayout all "${index}" >/dev/null
}

# switch_kb_layout

function choose_layout_us {
    setxkbmap -layout us
}

function choose_layout_int {
    setxkbmap -layout us -variant intl
}
