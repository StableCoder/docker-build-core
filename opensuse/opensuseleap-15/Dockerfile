FROM opensuse/leap:latest

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
    lcov \
    && zypper clean --all

# Conan
RUN pip3 --no-cache-dir install conan && \
    pip3 --no-cache-dir install -Iv --user six==1.12

# Entrypoint
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh", "-v", "--" ]
CMD [ "bash" ]
