FROM ubuntu:18.04

RUN apt update \
    && apt upgrade -y \
    && apt install -y \
    # Common
    python3-pip \
    ninja-build \
    make \
    git \
    git-lfs \
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
    && apt clean all

# Conan
RUN pip3 --no-cache-dir install conan && \
    pip3 --no-cache-dir install -U --user six

# Entrypoint
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh", "-v", "--" ]
CMD [ "bash" ]