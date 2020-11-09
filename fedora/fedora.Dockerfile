FROM fedora:latest

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
    cppcheck \
    lcov && \
    dnf clean all

# Entrypoint
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh", "--" ]
CMD [ "bash" ]
