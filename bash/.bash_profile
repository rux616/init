# -------------------- #
# OS-specific Settings #
# -------------------- #

if [ $(uname) = "Darwin" ]; then
    # Mac OS
elif [ $(uname) = "Linux" ]; then
    # Linux
fi



# ------------ #
# Load BASH RC #
# ------------ #
if [ -r ~/.bashrc ]; then
    source ~/.bashrc
fi
