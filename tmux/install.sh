#!/bin/bash

declare -a to_install
if [[ $(which xclip &>/dev/null; echo $?) -ne 0 ]]; then
    to_install+=('xclip')
fi
if [[ $(which iostat &>/dev/null; echo $?) -ne 0 ]]; then
    to_install+=('iostat')
fi
if [[ $(which sar &>/dev/null; echo $?) -ne 0 ]]; then
    to_install+=('sar')
fi
if [[ ${#to_install[@]} -ne 0 ]]; then
    echo 'Please make sure that the following are installed prior to using this script:'
    echo "    ${to_install[@]}"
    exit 1
fi

# Get directory where this script lives, because that's where the files will also be
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Get common functions
source "$DIR/../.common_functions.sh"

# Update or init submodules
cd $DIR
git submodule update --init -- .
git submodule update --remote -- .

# Back up existing files
back_up_file "$HOME/.tmux.conf"
back_up_file "$HOME/.tmux/plugins/tpm"

# Attempt to create .tmux/plugins/
mkdir -p "$HOME/.tmux/plugins" 2>/dev/null

# Symlink files into their appropriate places
ln -s "$DIR/.tmux.conf" "$HOME/.tmux.conf"
ln -s "$DIR/tpm" "$HOME/.tmux/plugins/tpm"

