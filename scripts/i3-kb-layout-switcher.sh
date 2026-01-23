#!/usr/bin/env bash

function switch_kb_layout {
    layouts=("us" "us" "ch")
    variants=("" "intl" "")
    lines=${#layouts[@]}
    number=0
    selection=-1

    if [[ ${#layouts[@]} -ne ${#variants[@]} ]]; then
        notify-send "layout-switcher" "#layouts != #variants"
        return 1
    fi

    unset names
    for n in ${!layouts[@]}; do
        if [[ -n "${variants[$n]}" ]]; then
            names+=("${layouts[$n]}:${variants[$n]}")
        else
            names+=("${layouts[$n]}")
        fi
    done

    # ## TODO: use `setxkbmap -print` to get status
    # current="$(echo "${devices}" | grep -ioP '(?<="active_layout_index": ).*(?=,)' -m 1)"

    if $(which rofi &>/dev/null); then
        selection="$(printf "%s\n" "${names[@]}" | rofi -dmenu -format 'i' -fixed-num-lines ${lines} -selected-row ${number} -case-smart)"
    else
        notify-send "layout-switcher" "requires [rofi]"
        return 1
    fi

    if [[ -z "$selection" ]]; then
        return 0
    fi

    if [[ $selection -lt 0 || $selection -ge $lines ]]; then
        notify-send "layout-switcher" "invalid selection"
        return 1
    fi

    # if [[ $selection -ge $lines ]]; then
    #     notify-send "layout-switcher" "invalid selection"
    #     return 1
    # fi
    #
    if [[ -n "${variants[$selection]}" ]]; then
        setxkbmap -layout "${layouts[$selection]}" -variant "${variants[$selection]}"
    else
        setxkbmap -layout "${layouts[$selection]}"
    fi
}

switch_kb_layout
