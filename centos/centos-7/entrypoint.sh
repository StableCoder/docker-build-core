#!/bin/sh

clang() {
    export CC=clang
    export CXX=clang++

    bash

    exit
}

gcc() {
    export CC=gcc
    export CXX=g++

    bash

    exit
}

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

# Fallback to bash
bash