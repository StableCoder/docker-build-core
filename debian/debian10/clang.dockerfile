FROM debian:sid

# Core Packages
RUN apt-get update \
    && apt-get upgrade -y \
    && apt install -y wget python-pip ninja-build make cmake git subversion \
    && pip install conan

# Tag Specific
RUN apt install -y clang

ENV CC=clang \
    CXX=clang++

CMD ["bash"]