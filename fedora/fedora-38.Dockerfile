FROM docker.io/fedora:38

RUN dnf update -y --refresh && \
    dnf install -y \
    # Dev Tools
    cmake \
    git \
    git-lfs \
    make \
    ninja-build \
    python3-pip \
    subversion \
    # Compilers
    clang \
    gcc \
    gcc-c++ \
    # Analysis
    clang-tools-extra \
    cppcheck \
    lcov \
    libasan \
    liblsan \
    libtsan \
    libubsan \
    llvm \
    llvm-libs \
    iwyu && \
    dnf clean all
