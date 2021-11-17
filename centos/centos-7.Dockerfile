FROM docker.io/centos:7

RUN yum update -y \
    && yum install -y epel-release \
    && yum install -y \
    # Common
    wget \
    python3-pip \
    make \
    cmake3 \
    ninja-build \
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
    # Compilers
    gcc \
    gcc-c++ \
    clang \
    llvm-libs \
    && yum clean all

# Entrypoint
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh", "--" ]
CMD [ "bash" ]