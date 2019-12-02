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


# ---------------- #
# Global Functions #
# ---------------- #
# get character from character code
#
# syntax: chr <character_code>
function chr() {
    [[ $1 -ge 0 && $1 -le 255 ]] || return 1
    printf "\\$(printf '%03o' "$1")"
}

# get character code from character
#
# syntax: ord <character>
function ord() {
    LC_TYPE=C printf '%d' "'$1"
}



# -------------- #
# Command Prompt #
# -------------- #

# Source the terminal control file to make things easier in terms of colors.
source ~/.terminal-control

# Set color of the \u@\h section of the prompt command based on whether the system is local or not - must be set manually by running 'touch ~/.localsystem'
SYSTEM_COLOR="${Red}"
if [ -e $HOME/.localsystem ]; then
    SYSTEM_COLOR="${Green}"
fi

# Set the custom command prompt variables to be used later.
custom_prompt_part1='${RESET_LINE}${Rst}${IYellow}[$(date +%Y-%m-%d) \t]${Rst} ${Bold}${SYSTEM_COLOR}\u@\h${Rst}:${Bold}${Blue}\w${Rst}'
custom_prompt_part2='\n\$ '

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
    
    # Set the command prompt to execute __git_ps1 with it taking the custom command prompt strings as arguments. 
    export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}__git_ps1 \"${RESET_LINE}${Rst}${IYellow}["'$(date +"%F %T UTC%:::z")'"]${Rst} ${Bold}${SYSTEM_COLOR}\u@\h${Rst}:${Bold}${Blue}\w${Rst}\" \"\n\$ \""
else
    # If the git prompt is not found for whatever reason, go with the basic command prompt.
	export PS1="${RESET_LINE}${Rst}${IYellow}["'$(date +"%F %T UTC%:::z")'"]${Rst} ${Bold}${SYSTEM_COLOR}\u@\h${Rst}:${Bold}${Blue}\w${Rst}\n\$ "
fi

# activate command completion for the AWS CLI if the completer command is installed
aws_completer_command=$(command -v aws_completer) && complete -C "${aws_completer_command}" aws



# ---------------- #
# History Settings #
# ---------------- #

# Set history file to be different than default to avoid accidental overwrites
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE="$HOME/.bash_eternal_history"

# Set timestamp format
export HISTTIMEFORMAT="[%F %T]  "

# Avoid duplicates
export HISTCONTROL=ignoredups:erasedups

# Unlimited history
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTSIZE=
export HISTFILESIZE=

# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend

# After each command, append to the history file and reread it
# http://superuser.com/questions/20900/bash-history-loss
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"



# ------------------ #
# Set Default Editor #
# ------------------ #

export VISUAL=vim
export EDITOR=$VISUAL



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

