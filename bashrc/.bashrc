#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls -hal --color=auto'
alias list='eza -lao --no-permissions --group-directories-first -s=ext --color=always --time-style long-iso'
# alias list='lsd -lA'

alias grep='grep --color=auto'
alias rg='rg --no-ignore -i -n -A 1 -B 1 --color=auto -e'

alias nano='nano -l'

alias dirs='dirs -v'

PS1='[\u@\h \W]\$ '

# overwrite $TERM to avoid problems when connecting to devices via ssh
export TERM="xterm-256color"

# extend PATH variable
# export PATH=$PATH:~/path/to/add

# setup starship
eval "$(starship init bash)"

# setup qmk completion
# source /home/scbj/repos/qmk_firmware/util/qmk_tab_complete.sh

# custom functions for specific purposes
source ~/collection/commands/colors.sh
source ~/collection/commands/dunst.sh

# source alias file
source ~/.bash_alias