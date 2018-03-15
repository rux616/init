#!/bin/bash

# Get directory where this script lives, because that's where the bash files will also be
DIR=$(dirname $0)

# Back up existing user bash files
if [ -w ~/.bash_profile ]; then
    mv ~/.bash_profile ~/.bash_profile_old
fi
if [ -w ~/.bashrc ]; then
    mv ~/.bashrc ~/.bashrc_old
fi
if [ -w ~/.bash_aliases ]; then
    mv ~.bash_aliases ~/.bash_aliases_old
fi

# Symlink bash files into their appropriate places
ln -s $DIR/.bash_profile ~/.bash_profile
ln -s $DIR/.bashrc ~/.bashrc
ln -s $DIR/.bash_aliases ~/.bash_aliases

