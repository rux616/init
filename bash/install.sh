#!/bin/bash

# Get directory where this script lives, because that's where the bash files will also be
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Get common functions
source "$DIR/../.common_functions.sh"

# Back up existing user bash files
back_up_file "~/.bash_profile"
back_up_file " ~/.bashrc"
back_up_file " ~/.bash_aliases"

# Symlink bash files into their appropriate places
ln -s "$DIR/.bash_profile" "~/.bash_profile"
ln -s "$DIR/.bashrc" "~/.bashrc"
ln -s "$DIR/.bash_aliases" "~/.bash_aliases"

