#!/usr/bin/env bash

# get directory where this script lives
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# source common functions
source "${DIR}/../.common_functions.sh"

# check prereqs
prereqs=()
prereqs+=('python3')
prereqs+=('pip3')
check_prereqs ${prereqs[@]} || exit 1

# init/update submodules
git submodule update --init --remote --force -- ${DIR}

# back up existing files
files=()
files+=("${HOME}/.vimrc")
files+=("${HOME}/.vim/colors/badwolf.vim")
files+=("${HOME}/.vim/bundle/black.vim")
back_up_files ${files[@]}

# attempt to create required directories
directories=()
directories+=("${HOME}/.vim/colors")
directories+=("${HOME}/.vim/bundle")
mkdir -p ${directories[@]} 2>/dev/null

# symlink files into their appropriate places
links=()
links+=("${DIR}/.vimrc" "${HOME}/.vimrc")
links+=("${DIR}/badwolf/colors/badwolf.vim" "${HOME}/.vim/colors/badwolf.vim")
links+=("${DIR}/black/plugin/black.vim" "${HOME}/.vim/bundle/black.vim")
create_links ${links[@]}
