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

# Update or init badwolf submodule
if [ -n $(ls $DIR/badwolf/) ]; then
    git submodule update --remote
else
    git submodule update --init
fi

# Symlink files into their appropriate places
ln -s $DIR/.vimrc ~/.vimrc
ln -s $DIR/badwolf/colors/badwolf.vim ~/.vim/colors/badwolf.vim

