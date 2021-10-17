FROM docker.io/debian:9

RUN apt-get update \
    && apt-get upgrade -y \
    && apt install -y \
    # Common
    libssl-dev \
    wget \
    python-pip \
    ninja-build \
    make \
    git \
    subversion \
    # Compilers
    gcc \
    g++ \
    clang \
    && apt-get clean

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

# Entrypoint
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh", "--" ]
CMD [ "bash" ]