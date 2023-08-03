FROM docker.io/centos:7

RUN yum update -y \
    && yum install -y epel-release \
    && yum install -y \
    # Common
    make \
    cmake3 \
    git \
    git-lfs \
    libffi-devel \
    ncurses-devel \
    ninja-build \
    openssl-devel \
    python3-pip \
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
    && yum clean all
