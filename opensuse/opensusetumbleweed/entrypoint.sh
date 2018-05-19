#!/bin/sh

clang() {
    export CC=clang
    export CXX=clang++

    conan profile new --detect default
    conan profile update settings.compiler.libcxx=libstdc++11 default
    printf "!! Converted to libstdc++11 !!\n"
    printf "Setup Clang\n\n"
}

gcc() {
    export CC=gcc
    export CXX=g++

    conan profile new --detect default
    conan profile update settings.compiler.libcxx=libstdc++11 default
    printf "!! Converted to libstdc++11 !!\n"
    printf "Setup GCC\n\n"
}

if [ $# = 1 ]; then
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
elif [ $# > 1 ]; then
    printf "Error: Called entrypoint with more than one argument\n"
fi

# Fallback to bash
bash