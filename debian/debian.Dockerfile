FROM docker.io/debian:latest

RUN apt-get update \
    && apt-get upgrade -y \
    && apt install -y \
    # Common
    cmake \
    git \
    make \
    ninja-build \
    pkgconf \
    python3 \
    python3-pip \
    subversion \
    wget \
    # Compilers
    clang \
    gcc \
    g++ \
    && apt-get clean
