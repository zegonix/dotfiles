#!/usr/bin/env bash

select_audio_sink() {
    sinks="$(pactl list sinks)"

    IFS=$(echo -en "\n\b")
    ids=($(echo "${sinks}" | grep -ioP "(?<=object.serial = ).*$"))
    names=($(echo "${sinks}" | grep -ioP "(?<=device\.description = ).*$"))
    unset IFS

    if [[ "${#ids[@]}" != "${#names[@]}" ]]; then
        echo "ERROR: #ids (${#ids[@]}) != #names (${#names[@]})"
        return 1
    fi

    selection="$(printf "%s\n" "${names[@]//\"/}" | fuzzel --dmenu)"

    unset number
    for n in ${!names[@]}; do
        if [[ "${names[$n]}" == *"${selection}"* ]]; then
            number=$n
        fi
    done

    if [[ -z "${number}" ]]; then
        echo "something went wrong.."
        return 1
    fi

    pactl set-default-sink ${ids[$number]//\"/}
}

select_audio_sink
