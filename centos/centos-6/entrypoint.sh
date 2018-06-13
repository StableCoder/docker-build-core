#!/bin/bash

gcc() {
    export CC=gcc
    export CXX=g++

    conan profile new --detect default
    printf "Setup GCC\n\n"
}

usage() {
    cat << USAGE >&2
Usage:
    entrypoint.sh [OPTIONS] [-- COMMAND ARGS]
    -g | --gcc                  Start a Conan profile for GCC  
    -- COMMAND ARGS             Execute command with args at the script end
USAGE
    exit 1
}

while [[ $# -gt 0 ]]
do
    case "$1" in
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