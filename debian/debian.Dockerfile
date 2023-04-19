FROM docker.io/debian:latest

RUN apt-get update \
    && apt-get upgrade -y \
    && apt install -y \
    # Common
    wget \
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
