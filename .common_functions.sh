#!/bin/bash

back_up_file()
{
    FILENAME=$1

    if [ -L $FILENAME ]; then
        rm $FILENAME
    elif [ -e $FILENAME ]; then
        mv $FILENAME $FILENAME"_old"
    fi
}

