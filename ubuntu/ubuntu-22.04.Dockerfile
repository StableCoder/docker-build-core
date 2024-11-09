# PLATFORMS: linux/amd64 linux/arm64 linux/ppc64le linux/s390x linux/riscv64
FROM docker.io/ubuntu:22.04

# Set for tzdata to noninteractive mode
RUN ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime
ENV DEBIAN_FRONTEND=noninteractive

# Install packages
RUN apt update \
    && apt upgrade -y \
    && apt install -y \
    # Dev Tools
    cmake \
    cmake-curses-gui \
    git \
    git-lfs \
    make \
    ninja-build \
    pkgconf \
    python3 \
    subversion \
    # Compilers
    clang \
    gcc \
    g++ \
    && apt clean all
