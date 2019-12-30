# .bash_profile

# -------------------- #
# OS-specific Settings #
# -------------------- #

if [[ $(uname) = "Darwin" ]]; then
    # Mac OS
    # uname >/dev/null   # dummy line to make bash stop complaining

    # Add locally installed Python 2.7 pip packages to the path
    if [[ -d ${HOME}/Library/Python/2.7/bin ]]; then
        export PATH=${PATH}:${HOME}/Library/Python/2.7/bin
    fi
elif [[ $(uname) = "Linux" ]]; then
    # Linux
    uname >/dev/null   # dummy line to make bash stop complaining
fi



# ------------ #
# Load BASH RC #
# ------------ #
if [[ -r ${HOME}/.bashrc ]]; then
    source ${HOME}/.bashrc
fi



# ------------- #
# PATH Settings #
# ------------- #

export PATH="/usr/local/sbin:${PATH}:${HOME}/.local/bin:${HOME}/bin"
