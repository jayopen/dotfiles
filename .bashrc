# BASH RUN COMMANDS FILE
# ----------------------
[ -z "$PS1" ] && return

HISTCONTROL=ignoreboth
HISTSIZE=100000
HISTFILESIZE=200000
shopt -s checkwinsize
set -o vi

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

color_prompt=yes
# Set the default shell prompt
PS1="\n\[\e[00;32m\]\A\[\e[0m\]\[\e[00;37m\] \[\e[0m\]\[\e[01;32m\]\h[\j]\[\e[0m\]\[\e[00;37m\] \[\e[0m\]\[\e[00;33m\]\w\[\e[0m\]\[\e[00;37m\] \[\e[0m\]\[\e[00;32m\]\n\\$\[\e[0m\]\[\e[00;37m\] \[\e[0m\]" 
PROMPT_DIRTRIM=4

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# GOPATH is required for tools to discover the go binary properly.
export GOARCH=arm
export GOOS=linux
export GOPATH=/home/jay/go
export PATH=$PATH:$GOPATH/bin

# Set up 256 color support
case "$TERM" in
    xterm) TERM=xterm-256color;;
    screen) TERM=screen-256color;;
esac

# Read only if we're using X
if [ $XAUTHORITY ]; then
    xset r rate 280 40
fi

## Seach history backward when using up arrow
bind '"\e[A": history-search-backward'

# Load Custom Alias Files
# Order matters here - most specific alias file is loaded last
. ~/.bash/.bash_aliases_base    # Basic Bash Aliases used at home and work
. ~/.bash/.bash_aliases_local   # Aliases only required on local machine
