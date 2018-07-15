FROM opensuse/leap:42

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
    lld4 \
    lldb \
    && zypper clean --all

# Conan
RUN pip3 --no-cache-dir install conan

# Entrypoint
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "" ]
CMD [ "bash" ]