FROM opensuse/tumbleweed:latest

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
    # Analysis
    llvm \
    cppcheck \
    include-what-you-use \
    && zypper clean --all

# Conan
RUN pip3 --no-cache-dir install conan

# Entrypoint
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh", "-v", "--" ]
CMD [ "bash" ]
