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
    alias vim='nvim'
fi

# If not running interactively, don't do anything
# [[ $- != *i* ]] && return

# unbind shortcuts with ctrl+vim-bindings for navigation in tmux
#bind -r "\C-h"
#bind -r "\C-j"
#bind -r "\C-k"
#bind -r "\C-l"

# define aliases
if ! $(which navigate &>/dev/null); then
    alias push='pushd'
    alias pop='popd'
    alias stack='dirs -v'
fi

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

alias bdiff='diff -uw --color=always'

alias sbash='source ~/.bashrc'

if $(which ip &>/dev/null); then
    alias ip='ip -c'
fi

# because `libreWolf` is ambiguous for tab completion
if $(which librewolf &>/dev/null); then
    alias firefox='librewolf'
fi

# short forms for tmux commands
## run script to setup default tmux session and then attach the session
## attaching the session needs to be done from the calling shell, otherwise
## the setup script will only terminate after detaching or killing the session
if $(which tmux &>/dev/null); then
    alias dmux='bash default-tmux-session.sh && tmux attach'

    alias tks='tmux kill-session'
    alias tma='tmux attach'
    alias tmd='tmux detach -P'

    alias trs='tmux rename-session'
    alias trw='tmux rename-window'
    alias tns='tmux new-session -d'
    alias tnw='tmux new-window -c "#{pane_current_path}"'
fi

# promt config, is overwritten by starship
PS1='[\u@\h \W]\$ '

# overwrite $TERM to avoid problems when connecting to devices via ssh
export TERM="xterm-256color"

# setup `starship`
if $(which starship &>/dev/null); then
    eval "$(starship init bash)"
fi

# extend PATH variable
# export PATH=$PATH:~/path/to/add
if [[ "$PATH" != *"dotfiles/scripts/"* ]]; then
    export PATH=$PATH:$HOME/dotfiles/scripts/
fi

## source various scripts
personal_scripts=${HOME}/dotfiles/scripts/
source_list=()
source_list+=("$HOME/.bash_paths")
source_list+=("$HOME/.bash_alias")
source_list+=("${personal_scripts}/navigate_bash_setup.sh")
source_list+=("${personal_scripts}/fzf-bash-history.sh")
source_list+=("${personal_scripts}/colors.sh")
source_list+=("${personal_scripts}/dunst.sh")
source_list+=("$HOME/.cargo/env")

for script in ${source_list[@]}; do
    if [[ -f ${script} ]]; then
        source ${script}
    fi
done

# disable terminal flow control (XON/XOFF) -> disable `C-s/C-q` keybindings
# this way the keybindings can be used for other purposes
if [[ -t 0 && $- = *i* ]]; then
    stty -ixon
fi
