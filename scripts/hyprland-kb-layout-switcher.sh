#!/usr/bin/env bash

function switch_kb_layout {
    devices="$(hyprctl devices -j)"
    languages="$(echo "${devices}" | grep -ioP '(?<="layout": ").*(?=")' -m 1)"
    variants="$(echo "${devices}" | grep -ioP '(?<="variant": ").*(?=")' -m 1)"
    current="$(echo "${devices}" | grep -ioP '(?<="active_layout_index": ).*(?=,)' -m 1)"

    languages=(${languages})
    variants=(${variants})

    number=$((${#languages[@]} - 1))
    for n in $(seq 0 $number); do
        layouts+=("${languages[$n]//,/} - ${variants[$n]//,/}")
    done

    if $(which fuzzel &>/dev/null); then
        selection="$(printf "%s\n" "${layouts[@]}" | fuzzel --lines ${#layouts[@]} --dmenu --select-index ${current})"
    else
        notify-send "layout-switcher" "requires [fuzzel]"
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

switch_kb_layout
