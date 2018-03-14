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



# ------------ #
# Load BASH RC #
# ------------ #
if [ -r ~/.bashrc ]; then
    source ~/.bashrc
fi
