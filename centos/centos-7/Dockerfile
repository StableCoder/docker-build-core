FROM centos:7

RUN yum update -y \
    && yum install -y epel-release \
    && yum install -y \
    # Common
    wget \
    python-pip \
    make \
    git \
    subversion \
    unzip \
    # GCC
    gcc \
    gcc-c++ \
    # Clang
    clang \
    llvm-libs \
    && yum clean all \
    && pip install --upgrade pip \
    && pip install conan

# CMake
ENV CMAKE_MINOR_VER=3.11 \
    CMAKE_VERSION=3.11.1
RUN wget -q https://cmake.org/files/v${CMAKE_MINOR_VER}/cmake-${CMAKE_VERSION}-Linux-x86_64.tar.gz \
    && tar -zxf cmake-${CMAKE_VERSION}-Linux-x86_64.tar.gz \
    && cp -R cmake-${CMAKE_VERSION}-Linux-x86_64/* /usr/local/ \
    && rm -rf cmake-*

# Ninja
ENV NINJA_VER=1.8.2
RUN wget -q https://github.com/ninja-build/ninja/releases/download/v${NINJA_VER}/ninja-linux.zip \
    && unzip ninja-linux.zip \
    && mv ninja /usr/local/bin \
    && rm ninja-linux.zip

# Entrypoint
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "./entrypoint.sh" ]