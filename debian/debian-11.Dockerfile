# PLATFORMS: linux/amd64 linux/arm64 linux/ppc64le linux/s390x
FROM docker.io/debian:11

RUN apt-get update \
    && apt-get upgrade -y \
    && apt install -y \
    # Dev Tools
    cmake \
    git \
    make \
    ninja-build \
    pkgconf \
    python3 \
    subversion \
    wget \
    # Compilers
    clang \
    gcc \
    g++ \
    && apt-get clean
