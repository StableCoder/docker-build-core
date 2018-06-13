FROM opensuse/leap:15

RUN zypper update -y \
    && zypper install -y \
    # Common
    git \
    subversion \
    make \
    ninja \
    cmake \
    python3 \
    python3-pip \
    # GCC
    gcc \
    gcc-c++ \
    gdb \
    # Clang
    clang \
    lld \
    lldb \
    && zypper clean --all \
    && pip3 install --upgrade pip \
    && pip3 install conan

# Entrypoint
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "" ]
CMD [ "bash" ]