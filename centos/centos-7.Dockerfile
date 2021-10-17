FROM docker.io/centos:7

RUN yum update -y \
    && yum install -y epel-release \
    && yum install -y \
    # Common
    wget \
    python-pip \
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
    # Compilers
    gcc \
    gcc-c++ \
    clang \
    llvm-libs \
    && yum clean all

# Python3
ENV PYTHON_VER=3.9.6
RUN wget -q https://www.python.org/ftp/python/${PYTHON_VER}/Python-${PYTHON_VER}.tgz \
    && tar -zxf Python-${PYTHON_VER}.tgz \
    && cd Python-${PYTHON_VER} \
    && ./configure \
    && make -j $(nproc) && make install \
    && cd .. \
    && rm -rf Python-*

# CMake
ENV CMAKE_VER=3.21.1
RUN wget -q https://github.com/Kitware/CMake/releases/download/v${CMAKE_VER}/cmake-${CMAKE_VER}.tar.gz \
    && tar -zxf cmake-${CMAKE_VER}.tar.gz \
    && cd cmake-${CMAKE_VER} \
    && ./configure \
    && make -j $(nproc --all) \
    && make install \
    && cd .. \
    && rm -rf cmake-*

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