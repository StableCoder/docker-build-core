#!/bin/bash

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

usage() {
    cat << USAGE >&2
Usage:
    entrypoint.sh [OPTIONS] [-- COMMAND ARGS]
    -g | --gcc                  Start a Conan profile for GCC
    -c | --clang                Start a Conan profile for Clang     
    -- COMMAND ARGS             Execute command with args at the script end
USAGE
    exit 1
}

while [[ $# -gt 0 ]]
do
    case "$1" in
        -c | --clang)
            clang
            shift 1
            ;;
        -g | --gcc)
            gcc
            shift 1
            ;;
        --)
            shift
            CMD=("$@")
            break
            ;;
        -h | --help)
            usage
            ;;
    esac
done

if [[ $CMD != "" ]]; then
    exec "${CMD[@]}"
fi