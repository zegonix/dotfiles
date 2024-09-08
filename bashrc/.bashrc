#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls -hal --color=auto'
alias list='eza -la --group-directories-first -s=ext --color=always'

alias grep='grep --color=auto'
alias rg='rg --no-ignore -i -n -A 1 -B 1 --color=auto -e'

PS1='[\u@\h \W]\$ '


# setup eza (continuation of exa)
export EZA_CONFIG_DIR="~/.config/eza/"

# setup starship
eval "$(starship init bash)"

# setup qmk completion
# source /home/scbj/repos/qmk_firmware/util/qmk_tab_complete.sh
