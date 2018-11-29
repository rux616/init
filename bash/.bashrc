# .bashrc

# -------------------- #
# Load Global Settings #
# -------------------- #

if [ -f /etc/bashrc ]; then
    source /etc/bashrc
fi



# -------------------- #
# OS-specific Settings #
# -------------------- #

if [ $(uname) = "Darwin" ]; then
    # Mac OS
    uname > /dev/null   # dummy line to make bash stop complaining
elif [ $(uname) = "Linux" ]; then
    # Linux
    uname > /dev/null   # dummy line to make bash stop complaining
fi



# ------ #
# Colors #
# ------ #





# ---------------- #
# History Settings #
# ---------------- #

# Set timestamp format
export HISTTIMEFORMAT="%F %T  "

# Avoid duplicates
export HISTCONTROL=ignoredups:erasedups

# Big history
export HISTSIZE=100000
export HISTFILESIZE=100000

# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend

# After each command, append to the history file and reread it
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"



# ------------------------ #
# Load Local BASH Settings #
# ------------------------ #

if [ -r ~/.bash_local ]; then
    source ~/.bash_local
fi



# ----------------- #
# Load BASH Aliases #
# ----------------- #

if [ -r ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

