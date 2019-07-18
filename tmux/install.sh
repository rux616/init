#!/usr/bin/env bash

# get directory where this script lives
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# source common functions
source "${DIR}/../.common_functions.sh"

# check prerequisites
prereqs=()
prereqs+=('xclip')
prepres+=('iostat')
prereqs+=('sar')
check_prereqs ${prereqs[@]} || exit 1

# update or init submodules
git submodule update --init --remote --force -- ${DIR}

# back up existing files
files+=()
files+=("${HOME}/.tmux.conf")
files+=("${HOME}/.tmux/plugins/tpm")
back_up_files ${files[@]}

# attempt to create required directories
directories=()
directories+=("${HOME}/.tmux/plugins")
mkdir -p ${directories[@]} 2>/dev/null

# symlink files into their appropriate places
links=()
links+=("${DIR}/.tmux.conf" "${HOME}/.tmux.conf")
links+=("${DIR}/tpm" "${HOME}/.tmux/plugins/tpm")
create_links ${links[@]}
