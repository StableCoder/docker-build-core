#!/bin/sh

gcc() {
    export CC=gcc
    export CXX=g++

    printf "Setup GCC\n\n"

    bash

    exit
}

# Only if there's a single argument
while getopts 'g' flag; do
    case "${flag}" in
        g)
            gcc
            ;;
    esac
done

bash