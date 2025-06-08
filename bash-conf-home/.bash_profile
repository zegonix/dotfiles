#
# ~/.bash_profile
#

scripts="${HOME}/dotfiles/scripts"
if [[ -d "${scripts}" ]]; then
    export PATH="${PATH}:${scripts}"
fi
unset scripts

export PATH="$PATH:$HOME/repos/jlink"
