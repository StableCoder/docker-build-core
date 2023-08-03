FROM docker.io/centos:7

RUN yum update -y \
    # Enable EPEL repository
    && yum install -y epel-release \
    # Install packages
    && yum install -y \
    # Dev Tools
    cmake3 \
    git \
    git-lfs \
    libffi-devel \
    make \
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
