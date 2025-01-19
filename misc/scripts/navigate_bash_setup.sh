#!/usr/bin/env bash

__call_navigate() {
    arg_pid=" --pid $$ "
    eval "$(navigate ${arg_pid} $@)"
}

function push {
    __call_navigate "push $@"
}

function pop {
    __call_navigate "pop $@"
}

function stack {
    __call_navigate "stack $@"
}

function book {
    __call_navigate "bookmark $@"
}

# completion for `push`
function _push {
    CURRENT_WORD=${COMP_WORDS[COMP_CWORD]}
    DIRS="$(find . -maxdepth 1 -type d | grep -vx "." | grep -vx ".." | sed s^"./"^^)"
    COMPREPLY=($(compgen -W "${DIRS}" -- $CURRENT_WORD))
}

# completion for `book`
function _book {
    CURRENT_WORD=${COMP_WORDS[COMP_CWORD]}
    BOOKMARKS="$(__call_navigate bookmark names)"
    COMPREPLY=($(compgen -W "${BOOKMARKS}" -- $CURRENT_WORD))
}

complete -F _push push
complete -F _book book
