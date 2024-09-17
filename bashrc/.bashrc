#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls -hal --color=auto'
alias list='eza -la -o --no-permissions --group-directories-first -s=ext --color=always'

alias grep='grep --color=auto'
alias rg='rg --no-ignore -i -n -A 1 -B 1 --color=auto -e'

PS1='[\u@\h \W]\$ '

# overwrite $TERM to avoid problems when connecting to devices via ssh
export TERM="xterm-256color"

# setup eza (continuation of exa)
export EZA_COLORS="\
oc=95:\
sn=35:\
uu=32:uR=1;32:un=32:\
da=93:\
fi=37:\
di=1;2;36:\
ex=4;34:\
ln=38;5;17\
pi=31:\
"

# setup starship
eval "$(starship init bash)"

# setup qmk completion
# source /home/scbj/repos/qmk_firmware/util/qmk_tab_complete.sh
