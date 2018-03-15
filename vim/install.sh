#!/bin/bash

# Get directory where this script lives, because that's where the files will also be
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Get common functions
source "$DIR/../.common_functions.sh"

# Back up existing files
back_up_file "$HOME/.vimrc"
back_up_file "$HOME/.vim/colors/badwolf.vim"

# Attempt to create .vim/colors/
mkdir -p "$HOME/.vim/colors" 2>/dev/null

# Update or init badwolf submodule
if [ -n $(ls "$DIR/badwolf/") ]; then
    git submodule update --remote
else
    git submodule update --init
fi

# Symlink files into their appropriate places
ln -s "$DIR/.vimrc" "$HOME/.vimrc"
ln -s "$DIR/badwolf/colors/badwolf.vim" "$HOME/.vim/colors/badwolf.vim"

