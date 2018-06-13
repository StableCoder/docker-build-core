FROM ubuntu:latest

RUN apt update \
    && apt upgrade -y \
    && apt install -y \
    # Common
    python3-pip \
    ninja-build \
    make \
    git \
    cmake \
    subversion \
    # GCC
    gcc \
    g++ \
    gdb \
    # Clang
    clang \
    lld \
    lldb \
    && apt clean all \
    && python3 -m  pip install --upgrade pip \
    && pip3 install conan

# Entrypoint
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "" ]
CMD [ "bash" ]