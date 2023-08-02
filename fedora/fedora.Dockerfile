FROM docker.io/fedora:latest

RUN dnf update -y --refresh && \
    dnf install -y \
    # Common
    python3-pip \
    git \
    git-lfs \
    subversion \
    make \
    ninja-build \
    cmake \
    # Compilers
    gcc \
    gcc-c++ \
    clang \
    # Analysis
    libasan \
    liblsan \
    libtsan \
    libubsan \
    clang-tools-extra \
    llvm \
    llvm-libs \
    iwyu \
    cppcheck \
    lcov && \
    dnf clean all
