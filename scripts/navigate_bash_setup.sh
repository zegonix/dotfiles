#!/usr/bin/env bash

if ! $(which navigate &>/dev/null); then
    return 1
fi

function __call_navigate {
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

function navconfig {
    __call_navigate "configuration $@"
}

# completion function for `book`
function _book {
    CURRENT_WORD=${COMP_WORDS[COMP_CWORD]}
    if [[ COMP_CWORD -eq 1 ]]; then
        BOOKMARKS="add remove clean $(__call_navigate bookmark completions)"
        COMPREPLY=($(compgen -W "${BOOKMARKS}" -- $CURRENT_WORD))
    elif [[ COMP_CWORD -eq 2 ]]; then
        if [[ "${COMP_WORDS[1]}" = "clean" ]]; then
            unset COMPREPLY
        elif [[ "${COMP_WORDS[1]}" = "remove" ]]; then
            BOOKMARKS="$(__call_navigate bookmark completions)"
            COMPREPLY=($(compgen -W "${BOOKMARKS}" -- $CURRENT_WORD))
        fi
    elif [[ COMP_CWORD -eq 3 ]]; then
        if [[ "${COMP_WORDS[1]}" = "add" ]]; then
            COMPREPLY=($(compgen -o dirnames -- $CURRENT_WORD))
        fi
    fi
}

# completion function for `pop`
function _pop {
    CURRENT_WORD=${COMP_WORDS[COMP_CWORD]}
    if [[ COMP_CWORD -eq 1 ]]; then
        COMPREPLY=($(compgen -W "all <number>"))
    fi
}

complete -o dirnames push
complete -F _pop pop
complete -F _book book
