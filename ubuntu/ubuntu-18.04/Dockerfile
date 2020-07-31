FROM ubuntu:18.04

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
    subversion \
    # Compilers
    gcc \
    g++ \
    clang \
    && apt clean all

# Conan
RUN pip3 --no-cache-dir install conan && \
    pip3 --no-cache-dir install -Iv --user six==1.12

# Entrypoint
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh", "-v", "--" ]
CMD [ "bash" ]