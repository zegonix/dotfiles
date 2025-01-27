#
# ~/.bash_profile
#

if [[ -n "$USER" ]]; then
    source "/home/$USER/.bashrc"
fi

export PATH="$PATH:$HOME/repos/jlink"
