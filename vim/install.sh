#!/bin/bash

# Get directory where this script lives, because that's where the files will also be
DIR=$(dirname $0)

# Back up existing files
if [ -w ~/.vimrc ]; then
    mv ~/.vimrc ~/.vimrc_old
fi
if [ -w ~/.vim/colors/badwolf ]; then
    mv ~/.vim/colors/badwolf ~/.vim/colors/badwolf_old
fi

# Attempt to create .vim/colors/
mkdir -p ~/.vim/colors 2>/dev/null

# Update badwolf submodule
git submodule update

# Symlink files into their appropriate places
ln -s $DIR/.vimrc ~/.vimrc
ln -s $DIR/vim/badwolf/colors/badwolf.vim ~/.vim/colors/badwolf.vim

