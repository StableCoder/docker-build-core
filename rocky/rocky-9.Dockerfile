FROM docker.io/rockylinux:9

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

# Entrypoint
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh", "--" ]
CMD [ "bash" ]