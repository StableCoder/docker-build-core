FROM debian:9

RUN apt-get update \
    && apt-get upgrade -y \
    && apt install -y \
    # Common
    wget \
    python-pip \
    ninja-build \
    make \
    git \
    subversion \
    # GCC
    gcc \
    g++ \
    gdb \
    # Clang
    clang \
    lldb \
    && apt-get clean

# CMake
ARG CMAKE_MINOR_VER=3.12
ARG CMAKE_VERSION=3.12.3
RUN wget -q https://cmake.org/files/v${CMAKE_MINOR_VER}/cmake-${CMAKE_VERSION}-Linux-x86_64.tar.gz \
    && tar -zxf cmake-${CMAKE_VERSION}-Linux-x86_64.tar.gz \
    && cp -rn cmake-${CMAKE_VERSION}-Linux-x86_64/bin/* /usr/local/bin/ \
    && cp -rn cmake-${CMAKE_VERSION}-Linux-x86_64/doc/* /usr/local/doc/ \
    && cp -rn cmake-${CMAKE_VERSION}-Linux-x86_64/man/* /usr/local/man/ \
    && cp -rn cmake-${CMAKE_VERSION}-Linux-x86_64/share/* /usr/local/share/ \
    && rm -rf cmake-*

# Conan
RUN pip --no-cache-dir install conan

# Entrypoint
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "" ]
CMD [ "bash" ]