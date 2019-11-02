FROM fedora:26

RUN dnf update -y \
    && dnf install -y \
    # Common
    git \
    git-lfs \
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
    cppcheck \
    lcov \
    && dnf clean all

# Conan
RUN pip3 --no-cache-dir install conan && \
    pip3 --no-cache-dir install -U --user six

# Entrypoint
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh", "-v", "--" ]
CMD [ "bash" ]