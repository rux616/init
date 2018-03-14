# ------------------- #
# OS-specific Aliases #
# ------------------- #

if [ $(uname) = 'Darwin' ]; then
    # Mac OS
    alias ls='ls -G'

elif [ $(uname) = 'Linux' ]; then
    # Linux
    if [ -e /var/log/syslog ]; then
        SYSTEMLOG="/var/log/syslog"
    else
        SYSTEMLOG="/var/log/messages"
    fi
    alias taillog="sudo tail -f -n 20 $SYSTEMLOG"
fi



# --------------- #
# General Aliases #
# --------------- #

alias ll='ls -al'
alias vi='vim'
