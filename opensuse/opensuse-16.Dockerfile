# PLATFORMS: linux/amd64 linux/arm64 linux/ppc64le
# ALTERNATE_TAGS: opensuse
FROM docker.io/opensuse/leap:16.0

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
    subversion \
    # Compilers
    clang \
    gcc \
    gcc-c++ \
    && zypper clean --all
