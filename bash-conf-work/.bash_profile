#
# ~/.bash_profile
#

# KEEP THIS!
# important for window manager and menu app (fuzzel, rofi, ..)
# to find scripts and utilities

export_paths=("${HOME}/dotfiles/scripts")
export_paths+=("$HOME/tools/Xilinx/Vivado/2021.1/bin")
export_paths+=("$HOME/tools/jlink")

for entry in ${export_paths[@]}; do
    if ! [[ -d "${entry}" ]]; then
        continue
    fi
    if [[ "$PATH" == *"${entry}"* ]]; then
        continue
    fi
    export PATH="${PATH}:${entry}"
done

unset export_paths

# vivado license
export XILINXD_LICENSE_FILE=26140@aberdeen.zhaw.ch
