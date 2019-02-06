#!/bin/bash

function back_up_file()
{
    FILENAME="$1"

    if [ -L "${FILENAME}" ]; then
        rm "${FILENAME}"
    elif [ -e "${FILENAME}" ]; then
        mv "${FILENAME}" "${FILENAME}_old"
    fi
}

function get_platform()
{
    unamestr=$(uname)

    shell_nocasematch=$(shopt -p nocasematch)
    shopt -s nocasematch
    case $unamestr in
        *bsd)       platform='bsd'      ;;
        cygwin*)    platform='windows'  ;;
        darwin)     platform='mac'      ;;
        linux)      platform='linux'    ;;
        ming*)      platform='windows'  ;;
        minix)      platform='minix'    ;;
        msys*)      platform='windows'  ;;
        sunos)      platform='solaris'  ;;
        windows*)   platform='windows'  ;;
        *)          platform='unknown'  ;;
    esac
    $shell_nocasematch
    
    echo $platform
}
