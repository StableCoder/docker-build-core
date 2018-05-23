FROM centos:6

RUN yum update -y \
    && yum install -y epel-release \
    && yum install -y \
    wget \
    make \
    git \
    subversion \
    unzip \
    zlib-devel \
    openssl-devel \
    # GCC
    gcc \
    gcc-c++ \
    gdb \
    && yum clean all

# Python3
ENV PYTHON_VER=3.6.5
RUN wget -q https://www.python.org/ftp/python/${PYTHON_VER}/Python-${PYTHON_VER}.tgz \
    && tar -zxf Python-${PYTHON_VER}.tgz \
    && cd Python-${PYTHON_VER} \
    && ./configure \
    && make && make install \
    && cd .. \
    && rm -rf Python-*

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

# Conan
RUN pip3 install --upgrade pip \
    && pip3 install conan 

# Entrypoint
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "bash" ]