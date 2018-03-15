# .bash_aliases

# ------------------- #
# OS-specific Aliases #
# ------------------- #

if [ $(uname) = 'Darwin' ]; then
    # Mac OS
    # uname > /dev/null   # dummy line to make bash stop complaining
    alias ls='ls -G'

elif [ $(uname) = 'Linux' ]; then
    # Linux
    # uname > /dev/null   # dummy line to make bash stop complaining
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
