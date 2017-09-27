# If not running interactively, don't do anything.
case $- in
    *i*) ;;
      *) return;
esac

# User specific aliases, bindings, and functions.
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias la='ls -lAFh --color=auto'
alias ll='ls -lFh --color=auto'
alias tmux='tmux -f "$XDG_CONFIG_HOME/tmux/config"'
alias irssi='TERM=screen irssi'

function xsvp() {
    local cmd=$1
    shift && command xsv $cmd -d"|" $@
}

if [ ! -z $MSYSTEM ]; then
    alias cargo='winpty cargo'

    #function cargo() {
    #    local cmd=$1
    #    shift && command cargo $cmd --color always $@
    #}

    bind '"\t":complete'
    bind '"\e[1;5C":forward-word'
    bind '"\e[1;5D":backward-word'
fi

# Disable scroll-lock (Ctrl-s, Ctrl-q).
stty -ixon

# Check the window seize after each command.
shopt -s checkwinsize
shopt -s histappend

# Better handle non-text input files.
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# vim: set ft=sh:
