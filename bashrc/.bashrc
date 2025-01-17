#
# ~/.bashrc
#

# disable duplicates in command history
export HISTCONTROL=ignoreboth:erasedups

# If not running interactively, don't do anything
# [[ $- != *i* ]] && return

# unbind shortcuts with ctrl+vim-bindings for navigation in tmux
#bind -r "\C-h"
#bind -r "\C-j"
#bind -r "\C-k"
#bind -r "\C-l"

# define aliases
alias ls='ls -hal --color=auto'
alias list='eza -lao --no-permissions --group-directories-first -s=ext --color=always --time-style long-iso'

alias grep='grep --color=auto'
alias rg='rg --no-ignore -i -n -A 1 -B 1 --color=auto -e'

alias nano='nano -l'

alias dirs='dirs -v'

alias diff='diff --color=always'

alias bashsource='source ~/.bashrc'

# short forms for tmux commands

## run script to setup default tmux session and then attach the session
## attaching the session needs to be done from the calling shell, otherwise
## the setup script will only terminate after detaching or killing the session
alias dmux='default-tmux-session && tmux attach'

alias tma='tmux attach'
alias tmd='tmux detach -P'

alias trs='tmux rename-session'
alias trw='tmux rename-window'
alias tnw='tmux new-window -c "#{pane_current_path}"'

# promt config, is overwritten by starship
PS1='[\u@\h \W]\$ '

# overwrite $TERM to avoid problems when connecting to devices via ssh
export TERM="xterm-256color"

# extend PATH variable
# export PATH=$PATH:~/path/to/add
if [[ "$PATH" != *"dotfiles/misc/scripts/"* ]]; then
    export PATH=$PATH:$HOME/dotfiles/misc/scripts/
fi

# setup starship
eval "$(starship init bash)"

# source shell scripts
source_list=()

## source alias file
source ~/.bash_alias

## source custom functions for specific purposes
script_path=${HOME}/dotfiles/misc/scripts/
source_list=()
source_list+=("${script_path}/navigate_bash_setup.sh")
source_list+=("${script_path}/colors.sh")
source_list+=("${script_path}/dunst.sh")

## source qmk setup script
# source /home/scbj/repos/qmk_firmware/util/qmk_tab_complete.sh

## source cargo setup script
source_list+=("$HOME/.cargo/env")

for script in ${source_list[@]}; do
    if [[ -f ${script} ]]; then
        source ${script}
    fi
done
