FROM docker.io/opensuse/leap:latest

# Lock permissions package which doesn't update correctly
RUN zypper al permissions

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
    # Compilers
    gcc \
    gcc-c++ \
    clang \
    # Analysis
    llvm \
    cppcheck \
    lcov \
    && zypper clean --all

# Entrypoint
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh", "--" ]
CMD [ "bash" ]
