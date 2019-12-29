# .bash_aliases

# ------------------- #
# OS-specific Aliases #
# ------------------- #

if [ $(uname) = 'Darwin' ]; then
    # Mac OS
    # uname >/dev/null   # dummy line to make bash stop complaining
    alias ls='ls -G'

elif [ $(uname) = 'Linux' ]; then
    # Linux
    # uname >/dev/null   # dummy line to make bash stop complaining
    if [ -e /var/log/syslog ]; then
        SYSTEMLOG="/var/log/syslog"
    else
        SYSTEMLOG="/var/log/messages"
    fi
    alias taillog="sudo tail -f -n 20 $SYSTEMLOG"
    alias ls='ls --color=auto --time-style=long-iso'
elif [ $(uname) = 'FreeBSD' ]; then
    # FreeBSD
    # uname >/dev/null   # dummy line to make bash stop complaining
    alias ls='ls -G'
fi



# --------------- #
# General Aliases #
# --------------- #

alias l1='ls -1'
alias la='ls -al'
alias ll='ls -l'
alias vi='vim'
alias :q='exit'
alias l='ll'



# --------- #
# Functions #
# --------- #

# enable live grepping; useful for grepping things like "tail -f /var/log/messages"
# usage: just pipe into it
# example: tail -f /var/log/messages | livegrep -i " <server_name> "
livegrep() {
    grep --line-buffered $* | cat
}
