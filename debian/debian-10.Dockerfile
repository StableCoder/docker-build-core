# PLATFORMS: linux/amd64 linux/arm64
FROM docker.io/debian:10

RUN apt-get update \
    && apt-get upgrade -y \
    && apt install -y \
    # Dev Tools
    git \
    libssl-dev \
    make \
    ninja-build \
    pkgconf \
    python \
    subversion \
    wget \
    # Compilers
    clang \
    gcc \
    g++ \
    && apt-get clean

# CMake
ENV CMAKE_VER=3.31.6
RUN wget -q https://github.com/Kitware/CMake/releases/download/v${CMAKE_VER}/cmake-${CMAKE_VER}.tar.gz \
    && tar -xf cmake-${CMAKE_VER}.tar.gz \
    && cd cmake-${CMAKE_VER} \
    && ./configure \
    && make -j $(nproc --all) \
    && make install \
    && cd .. \
    && rm -rf cmake-${CMAKE_VER}*
