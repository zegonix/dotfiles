#!/usr/bin/env bash

DEFAULT_SESSION='quak'
DUMMY_SESSION='dummy'

function create_default_session {
    if [[ -n "$TMUX" ]]; then
        echo "already attached to a session. don't nest tmux sessions"
        # return failure so the external attach command is not run
        return 1
    fi

    # check if the default session exists
    # redirect stderr to /dev/null because `session not found` is
    # not a relevant error in this case
    if $(tmux has-session -t ${DEFAULT_SESSION} 2>/dev/null); then
        # return success so the external attach command is run
        return 0
    fi

    # start dummy session to avoid error messages on `has-session`
    tmux new-session -d -s "$DUMMY_SESSION"

    # dont forget the '-d' option, otherwise the session is closed
    # before the rest of the commands are executed
    tmux new-session -d -s "$DEFAULT_SESSION" -n "temp" -c "$HOME" # create dummy window to set default path for new windows
    tmux new-window -t "$DEFAULT_SESSION" -n "dotfiles" -c "$HOME/dotfiles"
    tmux new-window -t "$DEFAULT_SESSION" -n "docs" -c "$HOME/collection"
    tmux new-window -t "$DEFAULT_SESSION" -n "stuff" -c "$HOME"
    tmux kill-window -t "temp"

    # this causes the script to exit only, when the session is ended or detached
    # it also causes tmux's detach command with hang up signal to fail
    # therefore the following line is commented out
    # an `alias` is created in `.bashrc` which calls this script and runs
    # `tmux attach` on successful execution

    #tmux attach -t "$DEFAULT_SESSION"

    tmux kill-session -t "$DUMMY_SESSION"
}

create_default_session
