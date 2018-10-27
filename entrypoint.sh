#!/bin/bash

setup_clang() {
    if ! clang_loc="$(type -p "clang")" || [[ -z $clang_loc ]]; then
        exit 1
    fi
    export CC=clang
    export CXX=clang++

    conan profile new --detect default
    conan profile update settings.compiler.libcxx=libstdc++11 default
    printf " >>> Converted to libstdc++11 !!\n"
    printf "\n >>> Conan Version\n"
    conan --version
    printf "\n >>> Clang Version\n"
    clang --version
}

setup_gcc() {
    export CC=gcc
    export CXX=g++

    conan profile new --detect default
    conan profile update settings.compiler.libcxx=libstdc++11 default
    printf " >>> Converted to libstdc++11 !!\n"
    printf "\n >>> Conan Version\n"
    conan --version
    printf "\n >>> GCC Version\n"
    gcc --version
}

version_info() {
    printf "\n >>> Conan Version\n"
    conan --version
    printf "\n >>> GCC Version\n"
    gcc --version
    if ! clang_loc="$(type -p "clang")" || [[ -z $clang_loc ]]; then
        printf ""
    else
        printf " >>> Clang Version\n"
        clang --version
    fi
    printf "\n"
}

usage() {
    cat << USAGE >&2
Usage:
    entrypoint.sh [OPTIONS] [-- COMMAND ARGS]
    -g | --gcc           Start a Conan profile for GCC
    -c | --clang         Start a Conan profile for Clang
    -v | --version       Prints out conan/compiler versions available
    -- COMMAND ARGS      Execute command with args at the script end
USAGE
    exit 1
}

while [[ $# -gt 0 ]]
do
    case "$1" in
        -c | --clang)
            setup_clang
            shift 1
            ;;
        -g | --gcc)
            setup_gcc
            shift 1
            ;;
        -v | --version)
            version_info
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