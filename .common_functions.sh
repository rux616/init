#!/bin/bash

back_up_file()
{
    FILENAME=$1

    if [ -w $FILENAME ]; then
        if [ -L $FILENAME ];
            rm $FILENAME
        else
            mv $FILENAME $FILENAME"_old"
        fi
    fi
}

