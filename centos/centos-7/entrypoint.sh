#!/bin/sh

clang() {
    export CC=clang
    export CXX=clang++
    
    printf "Setup Clang\n\n"

    bash

    exit
}

gcc() {
    export CC=gcc
    export CXX=g++

    printf "Setup GCC\n\n"

    bash

    exit
}

# Only if there's a single argument
while getopts 'cg' flag; do
    case "${flag}" in
        c)
            clang
            ;;
        g)
            gcc
            ;;
    esac
done

bash