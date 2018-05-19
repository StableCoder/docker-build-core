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
    # Clang
    clang \
    # Analysis
    && zypper clean --all \
    && pip3 install --upgrade pip \
    && pip3 install conan

# Entrypoint
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "./entrypoint.sh" ]