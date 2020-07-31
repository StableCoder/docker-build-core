#!/usr/bin/env bash

set -e

setup_clang() {
    export CC=clang
    export CXX=clang++
}

setup_gcc() {
    export CC=gcc
    export CXX=g++
}

version_info() {
    printf "\n >>> Conan Version\n"
    conan --version
    printf "\n >>> GCC Version\n"
    gcc --version
    printf " >>> Clang Version\n"
    clang --version
    printf "\n"
}

usage() {
    cat <<USAGE >&2
Usage:
    entrypoint.sh [OPTIONS] [-- COMMAND ARGS]
    -g | --gcc           Set environment to use GCC
    -c | --clang         Set environment to use Clang
    -v | --version       Prints out conan/compiler versions available
    -- COMMAND ARGS      Execute command with args at the script end
USAGE
    exit 1
}

while [[ $# -gt 0 ]]; do
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
        VERSION=1
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

if [[ $VERSION -ne 1 ]]; then
    conan profile new --detect default
    conan profile update settings.compiler.libcxx=libstdc++11 default
    printf " >>> Converted to libstdc++11 !!\n"
    printf "\n >>> Conan Version\n"
    conan --version
    printf "\n >>> $CC Version\n"
    $CC --version
fi

if [[ $CMD != "" ]]; then
    exec "${CMD[@]}"
fi
