#
# ~/.bash_profile
#

# extend paths
scripts="${HOME}/dotfiles/scripts"
if [[ -d "${scripts}" ]]; then
    export PATH="${PATH}:${scripts}"
fi
unset scripts

export PATH="$PATH:$HOME/tools/Xilinx/Vivado/2021.1/bin"
export PATH="$PATH:$HOME/tools/jlink_linux"

# vivado license
export XILINXD_LICENSE_FILE=26140@aberdeen.zhaw.ch
