#!/usr/bin/env bash

# get directory where this script lives
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# source common functions
source "${DIR}/../.common_functions.sh"

# back up existing files
files=()
files+=("${HOME}/.bash_profile")
files+=("${HOME}/.bashrc")
files+=("${HOME}/.bash_aliases")
files+=("${HOME}/.inputrc")
files+=("${HOME}/.terminal-control")
back_up_files ${files[@]}

# symlink files into their appropriate places
links=()
links+=("${DIR}/.bash_profile" "${HOME}/.bash_profile")
links+=("${DIR}/.bashrc" "${HOME}/.bashrc")
links+=("${DIR}/.bash_aliases" "${HOME}/.bash_aliases")
links+=("${DIR}/.inputrc" "${HOME}/.inputrc")
links+=("${DIR}/.terminal-control" "${HOME}/.terminal-control")
create_links ${links[@]}
