FROM docker.io/opensuse/leap:15

# Lock permissions package which doesn't update correctly
RUN zypper al permissions

RUN zypper update -y \
    && zypper install -y \
    # Dev Tools
    cmake \
    git \
    make \
    ninja \
    python3 \
    python3-pip \
    subversion \
    # Compilers
    clang \
    gcc \
    gcc-c++ \
    && zypper clean --all
