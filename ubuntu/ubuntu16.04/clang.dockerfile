FROM ubuntu:16.04

# Core Packages
RUN apt-get update \
    && apt-get upgrade -y \
    && apt install -y wget python-pip ninja-build make git subversion \
    && pip install conan

# CMake
ARG CMAKE_MINOR_VER=3.11
ARG CMAKE_VERSION=3.11.1
RUN wget -q https://cmake.org/files/v${CMAKE_MINOR_VER}/cmake-${CMAKE_VERSION}-Linux-x86_64.tar.gz \
    && tar -zxf cmake-${CMAKE_VERSION}-Linux-x86_64.tar.gz \
    && cp -rn cmake-${CMAKE_VERSION}-Linux-x86_64/bin/* /usr/local/bin/ \
    && cp -rn cmake-${CMAKE_VERSION}-Linux-x86_64/doc/* /usr/local/doc/ \
    && cp -rn cmake-${CMAKE_VERSION}-Linux-x86_64/man/* /usr/local/man/ \
    && cp -rn cmake-${CMAKE_VERSION}-Linux-x86_64/share/* /usr/local/share/ \
    && rm -rf cmake-*

# Tag Specific
ENV CC=clang \
    CXX=clang++

RUN apt install -y clang \
    && conan profile new --detect default \
    && conan profile update settings.compiler.libcxx=libstdc++11 default

ENV CC=clang \
    CXX=clang++

CMD ["bash"]