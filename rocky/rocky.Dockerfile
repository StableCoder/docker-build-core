FROM docker.io/rockylinux:latest

RUN dnf update -y \
    && dnf install -y epel-release dnf-plugins-core \
    && dnf update -y \
    && /usr/bin/crb enable \
    && dnf clean all
RUN dnf update -y \
    && dnf install -y \
    # Common
    wget \
    python3-pip \
    make \
    git \
    git-lfs \
    subversion \
    unzip \
    zlib-devel \
    openssl-devel \
    sqlite-devel \
    libffi-devel \
    readline-devel \
    ncurses-devel \
    cmake \
    ninja-build \
    # Compilers
    gcc \
    gcc-c++ \
    clang \
    llvm-libs \
    && dnf clean all

# Ninja
ENV NINJA_VER=1.10.2
RUN wget -q https://github.com/ninja-build/ninja/archive/refs/tags/v${NINJA_VER}.tar.gz \
    && tar -zxf v${NINJA_VER}.tar.gz \
    && cd ninja-${NINJA_VER} \
    && cmake -Bbuild-cmake -H. \
    && cmake --build build-cmake \
    && cmake --install build-cmake \
    && cd .. \
    && rm -rf ninja-${NINJA_VER} v${NINJA_VER}.tar.gz

# Entrypoint
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh", "--" ]
CMD [ "bash" ]