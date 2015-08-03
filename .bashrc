# ~/.bashrc
PATH=$HOME/.local/bin:$PATH
export LANG=en_US.UTF-8

# History
HISTSIZE=50000
HISTFILESIZE=50000
HISTCONTROL=ignoredups:ignorespace
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

Color_Off='\e[0m'       # Text Reset
Black='\e[0;30m'        # Black
White='\e[0;37m'        # White
On_Black='\e[40m'       # Black
On_White='\e[47m'       # White

# prevent Ctrl-S from being a little bitch
stty -ixon

alias vim='nvim'
alias ls='ls --color=auto'
alias ll='ls -alF'
alias up='cd ../'
alias grep='grep --color=auto'

alias update='sudo apt-get update && sudo apt-get upgrade && sudo apt-get dist-upgrade && sudo apt-get -f install && sudo apt-get autoremove && sudo apt-get autoclean'

# Work
alias extrahop='/home/ansel/.ansel/extrahop/extrahop.sh'

# TMUX
alias tmux='TERM=screen-256color-bce tmux -2 -u'
alias ta='tmux attach -d -t'
alias fzf='fzf-tmux'
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /usr/local/lib/python2.7/dist-packages/powerline/bindings/bash/powerline.sh
source ~/.ansel/tmuxinator.bash
if [[ -z "$TMUX" ]] ;then
    ID="`tmux ls | grep -vm1 attached | cut -d: -f1`" # get the id of a deattached session
    if [[ -z "$ID" ]] ;then # if not available create a new one
        tmux new-session
    else
        tmux attach-session -d -t "$ID" # if available attach to it
    fi
fi

# Editor
export EDITOR='vim'
if [ -e /usr/bin/vimx ]; then alias vim='/usr/bin/vimx'; fi

# Prompt
PS1="\[$Black$On_White\]\W \$\[$Color_Off\] "
PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#I_#P") "$PWD")'

# Source scripts
source ~/.ansel/cdhist.sh

# Source local
source ~/.bashrc_local

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

export FZF_DEFAULT_COMMAND='
 (git ls-files $(git rev-parse --show-toplevel) --cached --exclude-standard --others ||
  find * -name ".*" -prune -o -type f -print -o -type l -print) 2> /dev/null'
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
