#!/usr/bin/env bash

source process-status.sh

set_reminder() {
    message_reminder=$(
        cat <<'EOF'
enter reminder message to display when the timer rings
EOF
    )
    message_time="$(
        cat <<'EOF'
enter reminder time in one of the following formats:
    `18:00`
    `<time> + 5 minutes` - time can be `now`
EOF
    )"

    if ! is_process_running "atd.service"; then
        notify-send "ERROR" "[atd.service] is not running"
    fi

    reminder="$(rofi -dmenu -theme ~/.config/rofi/themes/command-runner-blue.rasi -mesg "${message_reminder}")"
    if [[ -z "${reminder}" ]]; then return 1; fi

    time="$(rofi -dmenu -theme ~/.config/rofi/themes/command-runner-blue.rasi -mesg "${message_time}")"
    if [[ -z "${time}" ]]; then return 1; fi

    if ! $(echo "notify-send '${reminder}'" | at "${time}"); then
        notify-send "failed to set reminder"
        return
    fi

    notify-send "set reminder at ${time}"
}

set_reminder
