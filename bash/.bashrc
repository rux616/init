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
    #uname > /dev/null   # dummy line to make bash stop complaining
    git_prompt_sh_location='/usr/local/etc/bash_completion.d/git-prompt.sh'
elif [ $(uname) = "Linux" ]; then
    # Linux
    #uname > /dev/null   # dummy line to make bash stop complaining
    git_prompt_sh_location='/usr/share/git-core/contrib/completion/git-prompt.sh'
fi



# -------------- #
# Command Prompt #
# -------------- #

# Source the terminal control file to make things easier.
source ~/.terminal-control

# Prepare to include the git prompt.
if [ -r $git_prompt_sh_location ]; then
    # Declare different variables that control what the git-prompt shows
    GIT_PS1_SHOWDIRTYSTATE=true
    GIT_PS1_SHOWSTASHSTATE=true
    GIT_PS1_SHOWUNTRACKEDFILES=true
    GIT_PS1_SHOWUPSTREAM="auto"
    GIT_PS1_HIDE_IF_PWD_IGNORED=true
    GIT_PS1_SHOWCOLORHINTS=true

    # Source the git-prompt helper script
    source $git_prompt_sh_location

    # Ensure the git prompt is defined
    git_prompt='$(__git_ps1 '\''(%s)'\'')'
fi






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

