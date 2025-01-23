#!/usr/bin/env bash

# reset dunst and send notification to Test dUNST config
tunst() {
    killall -9 dunst

    if [[ -z $1 ]]; then
        notify-send "Henlo" "fren of fren of very fren";
    else
        for n in $(seq 1 $1); do
            notify-send "Henlo(${n})" "fren of fren of fren number ${n}";
        done
    fi
}

