#!/bin/bash

if [[ $(which xclip &>/dev/null; echo $?) -eq 1 ]]; then
    echo "Please make sure that 'xclip' is installed before installing."
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

