FROM fedora:26

RUN dnf update -y \
    && dnf install -y \
    # Common
    git \
    subversion \
    make \
    ninja-build \
    cmake \
    # GCC
    gcc \
    gcc-c++ \
    gdb \
    # Clang
    clang \
    lld \
    lldb \
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
    && dnf clean all \
    && pip3 install --upgrade pip \
    && pip3 install conan

# Entrypoint
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "bash" ]