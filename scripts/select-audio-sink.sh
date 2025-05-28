#!/usr/bin/env bash

select_audio_sink() {
    sinks="$(pactl list sinks | grep -iozP "(?s)(?<=Properties:).*?(?=Ports:)" | tr -d '\0')"

    IFS=$(echo -en "\n\b")
    ids=($(echo "${sinks}" | grep -io -P "(?<=object.serial = ).*$"))
    names=($(echo "${sinks}" | grep -ioP "(?<=device\.description = ).*$"))
    unset IFS

    if [[ "${#ids[@]}" != "${#names[@]}" ]]; then
        echo "ERROR: #ids (${#ids[@]}) != #names (${#names[@]})"
        return 0
    fi

    selection="$(printf "%s\n" "${names[@]//\"/}" | rofi -dmenu)"

    unset number
    for n in ${!names[@]}; do
        if [[ "${names[$n]}" == *"${selection}"* ]]; then
            number=$n
        fi
    done

    if [[ -z "${number}" ]]; then
        echo "something went wrong.."
        return 0
    fi

    pactl set-default-sink ${ids[$number]//\"/}
}

select_audio_sink
