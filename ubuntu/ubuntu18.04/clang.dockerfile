FROM ubuntu:18.04

# Core Packages
RUN apt update \
    && apt upgrade -y \
    && apt install -y python3-pip ninja-build make git cmake subversion \
    && pip3 install conan

# Tag Specific
RUN apt install -y clang \
    && conan profile new --detect default \
    && conan profile update settings.compiler.libcxx=libstdc++11 default

ENV CC=clang \
    CXX=clang++

CMD ["bash"]