#!/usr/bin/env bash

function switch_kb_layout {
    layouts="$(hyprctl devices -j | grep -iP '"layout"' -m 1)"
    # TODO:
}
