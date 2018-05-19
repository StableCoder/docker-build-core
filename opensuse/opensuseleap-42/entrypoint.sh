#!/bin/sh

clang() {
    export CC=clang
    export CXX=clang++

    conan profile new --detect default
    conan profile update settings.compiler.libcxx=libstdc++11 default
    printf "!! Converted to libstdc++11 !!"

    bash

    exit
}

gcc() {
    export CC=gcc
    export CXX=g++

    conan profile new --detect default
    conan profile update settings.compiler.libcxx=libstdc++11 default
    printf "!! Converted to libstdc++11 !!"

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