# PLATFORMS: linux/amd64 linux/arm64
FROM docker.io/rockylinux:8

RUN dnf update -y \
    # Enable EPEL/CRB repositories
    && dnf install -y dnf-plugins-core epel-release \
    && crb enable \
    # Install packages
    && dnf install -y \
    # Dev Tools
    cmake \
    git \
    git-lfs \
    libffi-devel \
    make \
    ncurses-devel \
    ninja-build \
    openssl-devel \
    python3 \
    readline-devel \
    sqlite-devel \
    subversion \
    unzip \
    wget \
    zlib-devel \
    # Compilers
    clang \
    gcc \
    gcc-c++ \
    llvm-libs \
    && dnf clean all
