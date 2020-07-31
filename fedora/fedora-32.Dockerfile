FROM fedora:32

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

# Conan
RUN pip --no-cache-dir install conan && \
    pip --no-cache-dir install -Iv --user six==1.12

# Entrypoint
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh", "--" ]
CMD [ "bash" ]
