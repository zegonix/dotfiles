#!/usr/bin/env bash

__call_navigate() {
    arg_pid=" --pid $$ "
    eval "$(navigate ${arg_pid} $@)"
}

push() {
    __call_navigate "push $@"
}

pop() {
    __call_navigate "pop $@"
}

stack() {
    __call_navigate "stack $@"
}

book() {
    __call_navigate "bookmark $@"
}
