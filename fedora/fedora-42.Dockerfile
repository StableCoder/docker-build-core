# PLATFORMS: linux/amd64 linux/arm64 linux/ppc64le linux/s390x
# ALTERNATE_TAGS: fedora
FROM docker.io/fedora:41

RUN dnf update -y --refresh && \
    dnf install -y \
    # Dev Tools
    cmake \
    git \
    git-lfs \
    make \
    ninja-build \
    python3 \
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
