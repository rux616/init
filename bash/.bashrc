# .bashrc

# -------------------- #
# Load Global Settings #
# -------------------- #

if [[ -f /etc/bashrc ]]; then
    source /etc/bashrc
fi



# -------------------- #
# OS-specific Settings #
# -------------------- #

if [[ $(uname) = "Darwin" ]]; then
    # Mac OS
    # uname >/dev/null   # dummy line to make bash stop complaining
    git_prompt_sh_location='/usr/local/etc/bash_completion.d/git-prompt.sh'
elif [[ $(uname) = "Linux" ]]; then
    # Linux
    # uname >/dev/null   # dummy line to make bash stop complaining

    # Determine what flavor of Linux is installed
    flavor="$(awk -F '=' '$1=="ID" { print $2 ;}' /etc/os-release | sed -e 's/"//g')"
    case ${flavor} in
        rhel | centos | fedora | amzn )
            git_prompt_sh_location='/usr/share/git-core/contrib/completion/git-prompt.sh'
            ;;
        debian | ubuntu )
            git_prompt_sh_location='/usr/lib/git-core/git-sh-prompt'
            ;;
        *)
            git_prompt_sh_location='/dev/null/git-prompt.sh'
            ;;
    esac
elif [[ $(uname) = "FreeBSD" ]]; then
    # FreeBSD
    # uname >/dev/null   # dummy line to make bash stop complaining
    git_prompt_sh_location='/usr/local/share/git-core/contrib/completion/git-prompt.sh'
fi



# ----------------------- #
# Cloud-specific Settings #
# ----------------------- #

# Check to see if this is running on any cloud instances. If it is, there may be some one-time initializations to perform.
if nslookup metadata.google.internal &>/dev/null; then
    # GCP
    # Get the ID of the current instance, and the previous (or same) one if there.
    current_id="$(curl -s 'https://metadata.google.internal/computeMetadata/v1/instance/id' -H 'Metadata-Flavor: Google')"
    stored_id="$(cat "${HOME}/.gce_id" 2>/dev/null)"

    # If the IDs are different, perform any of the one-time steps.
    if [[ "${current_id}" != "${stored_id}" ]]; then
        echo "${current_id}" > "${HOME}/.gce_id"
    fi
fi



# ---------------- #
# Global Functions #
# ---------------- #

tz_trimmed() {
    # Trim the basic date "%z" timezone string because FreeBSD doesn't have the "%:::z" format string
    tz=$(date +%z)
    if [[ ${tz:3} = '00' ]]; then
        echo ${tz:0:3}
    else
        echo ${tz}
    fi
}

tf_enable() {
    # Remove ".disabled" suffix from passed terraform files (*.tf, *.tfvars)
    for file in $@; do
        [[ "${file}" =~ ^.*\.tf.disabled$ || "${file}" =~ ^.*\.tfvars.disabled$ ]] || continue
        mv -i "${file}" "${file/%.disabled/}"
    done
}

tf_disable() {
    # Add ".disabled" suffix to passed terraform files (*.tf, *.tfvars)
    for file in $@; do
        [[ "${file}" =~ ^.*\.tf$ || "${file}" =~ ^.*\.tfvars$ ]] || continue
        mv -i "${file}" "${file}.disabled"
    done
}



# -------------- #
# Command Prompt #
# -------------- #

# Source the terminal control file to make things easier in terms of colors.
source ${HOME}/.terminal-control

# Set color of the \u@\h section of the prompt command based on whether the system is local or not - must be set manually by running 'touch ~/.localsystem'
SYSTEM_COLOR="${Red}"
if [[ -e ${HOME}/.localsystem ]]; then
    SYSTEM_COLOR="${Green}"
fi

# Set the custom command prompt variables to be used later.
custom_prompt_part1='${RESET_LINE}${Rst}${IYellow}[$(date +%Y-%m-%d) \t]${Rst} ${Bold}${SYSTEM_COLOR}\u@\h${Rst}:${Bold}${Blue}\w${Rst}'
custom_prompt_part2='\n\$ '

# Prepare to include the git prompt.
if [[ -r ${git_prompt_sh_location} ]]; then
    # Declare different variables that control what the git-prompt shows
    GIT_PS1_SHOWDIRTYSTATE=true
    GIT_PS1_SHOWSTASHSTATE=true
    GIT_PS1_SHOWUNTRACKEDFILES=true
    GIT_PS1_SHOWUPSTREAM="auto"
    GIT_PS1_HIDE_IF_PWD_IGNORED=true
    GIT_PS1_SHOWCOLORHINTS=true

    # Source the git-prompt helper script
    source ${git_prompt_sh_location}
    
    # Set the command prompt to execute __git_ps1 with it taking the custom command prompt strings as arguments. 
    export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}__git_ps1 \"${RESET_LINE}${Rst}${IYellow}["'$(date +"%F %T") UTC$(tz_trimmed)'"]${Rst} ${Bold}${SYSTEM_COLOR}\u@\h${Rst}:${Bold}${Blue}\w${Rst}\" \"\n\$ \""
else
    # If the git prompt is not found for whatever reason, go with the basic command prompt.
    export PS1="${RESET_LINE}${Rst}${IYellow}["'$(date +"%F %T") UTC$(tz_trimmed)'"]${Rst} ${Bold}${SYSTEM_COLOR}\u@\h${Rst}:${Bold}${Blue}\w${Rst}\n\$ "
fi

# activate command completion for the AWS CLI if the completer command is installed
aws_completer_command=$(command -v aws_completer) && complete -C "${aws_completer_command}" aws

# enable system-level bash-completion
if [[ -f /usr/share/bash-completion/bash-completion ]]; then
    . /usr/share/bash-completion/bash_completion
elif [[ -f /etc/bash-completion ]]; then
    . /etc/bash_completion
fi



# ---------------- #
# History Settings #
# ---------------- #

# Set history file to be different than default to avoid accidental overwrites
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE="${HOME}/.bash_eternal_history"

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

if [[ -r ${HOME}/.bash_local ]]; then
    source ${HOME}/.bash_local
fi



# ----------------- #
# Load BASH Aliases #
# ----------------- #

if [[ -r ${HOME}/.bash_aliases ]]; then
    source ${HOME}/.bash_aliases
fi

