#!/usr/bin/env bash

function switch_kb_layout {
    layouts=("us" "us" "ch")
    variants=("" "intl" "")
    lines=${#layouts[@]}
    index=0
    selection=-1

    if [[ ${#layouts[@]} -ne ${#variants[@]} ]]; then
        notify-send "layout-switcher" "#layouts != #variants"
        return 1
    fi

    unset names
    for n in ${!layouts[@]}; do
        if [[ -n "${variants[$n]}" ]]; then
            names+=("${layouts[$n]}(${variants[$n]})")
        else
            names+=("${layouts[$n]}")
        fi
    done

    current="$(setxkbmap -print | sed -n '/xkb_symbols/p' | sed -E 's/.*pc\+([^+]+)\+.*/\1/')"
    for n in ${!layouts[@]}; do
        if [[ "${current}" == "${layouts[$n]}(${variants[$n]})" ]]; then
            index=${n}
            break
        fi
    done

    if $(which rofi &>/dev/null); then
        selection="$(printf "%s\n" "${names[@]}" | rofi -dmenu -format 'i' -theme-str "#listview { lines: ${lines}; }" -selected-row ${index} -case-smart)"
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
    setxkbmap "${layouts[$selection]}" "${variants[$selection]}"
    if [[ $? -ne 0 ]]; then
        notify-send "layout-switcher" "failed to set layout\n[${layouts[$selection]}:${variants[$selection]}]"
    fi
}

switch_kb_layout
