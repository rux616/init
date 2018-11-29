#!/bin/bash

# Get directory where this script lives, because that's where the git config will also be
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Get common functions
source "$DIR/../.common_functions.sh"

# Back up existing git config
back_up_file "$HOME/.gitconfig"

# Symlink git config into its appropriate place
ln -s "$DIR/.gitconfig" "$HOME/.gitconfig"
