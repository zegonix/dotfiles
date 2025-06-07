#!/usr/bin/env bash

get_process_status() {
    if (($# != 1)); then
        echo "get_process_status() takes exactly ONE argument"
        return 1
    fi
    if ! status="$(systemctl status "$*")"; then
        echo "could not find a process named [$*]"
        return 1
    fi
    if ! status="$(echo "${status}" | grep -P "Active:")"; then
        echo "failed to find line"
        return 1
    fi
    if ! status="$(echo "${status}" | grep -oP "(?<=\()\w+(?=\))")"; then
        echo "failed to find status"
        return 1
    fi
    echo "${status}"
    return 0
}

check_process_status() {
    if (($# != 1)) && [[ -z "${stdin}" ]]; then
        echo "check_process_status() takes exactly ONE argument != #$#"
        return 1
    fi
    if [[ "$1" == "-" ]]; then
        input="$(cat)"
    else
        input="$1"
    fi
    if [[ "${input}" != "running" ]]; then
        return 1
    fi
    return 0
}

is_process_running() {
    get_process_status "$*" | check_process_status - >/dev/null 2>&1
}
