#
# ~/.bashrc
#

# configure behaviour of command history
## disable duplicates in command history
export HISTCONTROL=ignoreboth:erasedups
## increase history size
history_size=2000
export HISTSIZE=${history_size}
export HISTFILESIZE=${history_size}

# configure pagers
export PAGER='less --use-color -R'

if $(which nvim &>/dev/null); then
    export MANPAGER='nvim +Man!'
fi

# If not running interactively, don't do anything
# [[ $- != *i* ]] && return

# unbind shortcuts with ctrl+vim-bindings for navigation in tmux
#bind -r "\C-h"
#bind -r "\C-j"
#bind -r "\C-k"
#bind -r "\C-l"

# define aliases
alias ls='ls -hal --color=auto'
if $(which eza &>/dev/null); then
    alias list='eza -lao --no-permissions --group-directories-first -s=ext --color=always --time-style long-iso'
else
    alias list='ls -hal --color=auto'
fi

if $(which rg &>/dev/null); then
    alias rg='rg --color=always -n'
    alias rgi='rg -i -n -A 1 -B 1 --color=always'
else
    alias grep='grep --color=always'
fi

alias bdiff='diff --color=always'

alias bashsource='source ~/.bashrc'

# for convenient opening of pdfs..
alias firefox='librewolf'

# short forms for tmux commands
## run script to setup default tmux session and then attach the session
## attaching the session needs to be done from the calling shell, otherwise
## the setup script will only terminate after detaching or killing the session
alias dmux='bash default-tmux-session.sh && tmux attach'

alias tks='tmux kill-session'
alias tma='tmux attach'
alias tmd='tmux detach -P'

alias trs='tmux rename-session'
alias trw='tmux rename-window'
alias tns='tmux new-session -d'
alias tnw='tmux new-window -c "#{pane_current_path}"'

# promt config, is overwritten by starship
PS1='[\u@\h \W]\$ '

# overwrite $TERM to avoid problems when connecting to devices via ssh
export TERM="xterm-256color"

# extend PATH variable
# export PATH=$PATH:~/path/to/add
if [[ "$PATH" != *"dotfiles/scripts/"* ]]; then
    export PATH=$PATH:$HOME/dotfiles/scripts/
fi

# setup `starship`
if $(which starship &>/dev/null); then
    eval "$(starship init bash)"
fi

## source alias file
source ~/.bash_alias

## source custom functions for specific purposes
script_path=${HOME}/dotfiles/scripts/
source_list=()
source_list+=("${script_path}/navigate_bash_setup.sh")
source_list+=("${script_path}/fzf-bash-history.sh")
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

if [[ -t 0 && $- = *i* ]]; then
    stty -ixon
fi
