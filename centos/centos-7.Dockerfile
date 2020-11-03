FROM centos:7

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
ENV PYTHON_VER=3.8.5
RUN wget -q https://www.python.org/ftp/python/${PYTHON_VER}/Python-${PYTHON_VER}.tgz \
    && tar -zxf Python-${PYTHON_VER}.tgz \
    && cd Python-${PYTHON_VER} \
    && ./configure \
    && make -j $(nproc) && make install \
    && cd .. \
    && rm -rf Python-*

# CMake
ENV CMAKE_MINOR_VER=3.18 \
    CMAKE_VERSION=3.18.1
RUN wget -q https://cmake.org/files/v${CMAKE_MINOR_VER}/cmake-${CMAKE_VERSION}-Linux-x86_64.tar.gz \
    && tar -zxf cmake-${CMAKE_VERSION}-Linux-x86_64.tar.gz \
    && cp -R cmake-${CMAKE_VERSION}-Linux-x86_64/* /usr/local/ \
    && rm -rf cmake-*

# Ninja
ENV NINJA_VER=1.10.1
RUN wget -q https://github.com/ninja-build/ninja/releases/download/v${NINJA_VER}/ninja-linux.zip \
    && unzip ninja-linux.zip \
    && mv ninja /usr/local/bin \
    && rm ninja-linux.zip

# Conan
RUN pip3 --no-cache-dir install conan && \
    pip3 --no-cache-dir install -Iv --user six==1.12

# Entrypoint
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh", "--" ]
CMD [ "bash" ]