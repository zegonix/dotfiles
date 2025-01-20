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

# completion for `book`
function _book {
    CURRENT_WORD=${COMP_WORDS[COMP_CWORD]}
    BOOKMARKS="$(__call_navigate bookmark names)"
    COMPREPLY=($(compgen -W "${BOOKMARKS}" -- $CURRENT_WORD))
}

complete -o dirnames push
complete -F _book book
