#!/usr/bin/env bash

select_audio_sink() {
    sinks="$(pactl list sinks)"

    IFS=$(echo -en "\n\b")
    devices=($(echo "${sinks}" | grep -ioP "(?<=name: ).*$"))
    ids=($(echo "${sinks}" | grep -ioP "(?<=object.serial = ).*$"))
    names=($(echo "${sinks}" | grep -ioP "(?<=device\.description = ).*$"))
    unset IFS

    if [[ "${#ids[@]}" != "${#names[@]}" ]] || [[ "${#ids[@]}" != "${#devices[@]}" ]]; then
        echo "ERROR: #ids (${#ids[@]}) != #names (${#names[@]})"
        return 1
    fi

    unset number
    for n in ${!devices[@]}; do
        if [[ "${devices[$n]}" == "$(pactl get-default-sink)" ]]; then
            number=$n
            break
        fi
    done
    if [[ -z "${number}" ]]; then
        return 1
    fi

    if ((${#ids[@]} > 16)); then
        lines=16
    else
        lines=${#ids[@]}
    fi

    if $(which rofi &>/dev/null); then
        selection="$(printf "%s\n" "${names[@]//\"/}" | rofi -dmenu -fixed-num-lines ${lines} -selected-row ${number} -case-smart)"
    elif $(which fuzzel &>/dev/null); then
        selection="$(printf "%s\n" "${names[@]//\"/}" | fuzzel --lines ${lines} --dmenu --select-index ${number})"
    else
        return 1
    fi

    if [[ -z "${selection}" ]]; then
        return 1
    fi

    unset number
    for n in ${!names[@]}; do
        if [[ "${names[$n]}" == *"${selection}"* ]]; then
            number=$n
            break
        fi
    done

    if [[ -z "${number}" ]]; then
        echo "something went wrong.."
        return 1
    fi

    pactl set-default-sink ${ids[$number]//\"/}
}

select_audio_sink
