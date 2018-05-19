FROM ubuntu:16.04

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
    # Clang
    clang \
    && pip install --upgrade pip \
    && pip install conan

# Entrypoint
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "./entrypoint.sh" ]