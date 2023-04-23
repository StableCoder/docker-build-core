FROM docker.io/debian:11

RUN apt-get update \
    && apt-get upgrade -y \
    && apt install -y \
    # Common
    wget \
    pkgconf \
    python3 \
    python3-pip \
    cmake \
    ninja-build \
    make \
    git \
    subversion \
    # Compilers
    gcc \
    g++ \
    clang \
    && apt-get clean
