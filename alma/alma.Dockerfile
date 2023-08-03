FROM docker.io/almalinux:latest

# Enable EPEL/CRB repositories
RUN dnf update -y \
    && dnf install -y dnf-plugins-core epel-release \
    && dnf update -y \
    && /usr/bin/crb enable \
    && dnf clean all

# Install Packages
RUN dnf update -y \
    && dnf install -y \
    # Common
    cmake \
    git \
    git-lfs \
    libffi-devel \
    make \
    ncurses-devel \
    ninja-build \
    openssl-devel \
    python3 \
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
    && dnf clean all
