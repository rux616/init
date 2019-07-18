#!/usr/bin/env bash

# get directory where this script lives
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# source common functions
source "${DIR}/../.common_functions.sh"

# back up existing files
files=()
files=+("${HOME}/.gitconfig")
back_up_files ${files[@]}

# symlink files into their appropriate places
links=()
links+=("${DIR}/.gitconfig" "${HOME}/.gitconfig")
create_links ${links[@]}
