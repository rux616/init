#!/bin/bash

# Get directory where this script lives, because that's where the files will also be
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Get common functions
source "$DIR/../.common_functions.sh"

# Back up existing files
back_up_file "$HOME/Library/Preferences/com.googlecode.iterm2.plist"

# Symlink files into their appropriate places
ln -s "$DIR/com.googlecode.iterm2.plist" "$HOME/Library/Preferences/com.googlecode.iterm2.plist"

