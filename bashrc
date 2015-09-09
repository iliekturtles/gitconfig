# .bashrc
source /usr/share/git-core/contrib/completion/git-prompt.sh

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=
export EDITOR=vim
export PS1="\[\e[00;32m\]\u@\h \[\e[00;33m\]\w\$(__git_ps1 ' \[\e[00;36m\](%s)')\[\e[0m\]\$ "
export GIT_PS1_SHOWDIRTYSTATE=*
export GIT_PS1_SHOWSTASHSTATE=$
export RUST_SRC_PATH="/home/mike/Source/rust/src"
#export LD_LIBRARY_PATH=/usr/local/lib

# User specific aliases, bindings, and functions
alias la='ls -lAh --color=auto'
alias ll='ls -lh --color=auto'
#alias grep='grep --color=auto'
#alias cargo='winpty cargo'

#function cargo() {
#    local cmd=$1
#    shift && command cargo $cmd --color always $@
#}

#bind '"\t":complete'

# Mouse settings to disable acceleration.
# xinput set-prop 10 262 7
# xset m 15/2 0

# Disable scroll-lock (Ctrl-s, Ctrl-q)
stty -ixon

