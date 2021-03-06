FROM ubuntu:20.04

# Set for tzdata to noninteractive mode
RUN ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime
ENV DEBIAN_FRONTEND=noninteractive

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
    cmake-curses-gui \
    subversion \
    # Compilers
    gcc \
    g++ \
    clang \
    && apt clean all

# Entrypoint
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh", "--" ]
CMD [ "bash" ]