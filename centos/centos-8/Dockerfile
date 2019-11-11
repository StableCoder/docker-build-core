FROM centos:8

RUN yum update -y \
    && yum install -y epel-release \
    && curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.rpm.sh | bash \
    && yum install -y \
    # Common
    wget \
    python3-pip \
    make \
    git \
    git-lfs \
    subversion \
    unzip \
    zlib-devel \
    openssl-devel \
    sqlite-devel \
    libffi-devel \
    readline-devel \
    ncurses-devel \
    cmake \
    # GCC
    gcc \
    gcc-c++ \
    gdb \
    # Clang
    clang \
    llvm-libs \
    lldb \
    && yum clean all

# Ninja
ENV NINJA_VER=1.8.2
RUN wget -q https://github.com/ninja-build/ninja/releases/download/v${NINJA_VER}/ninja-linux.zip \
    && unzip ninja-linux.zip \
    && mv ninja /usr/local/bin \
    && rm ninja-linux.zip

# Conan
RUN pip3 --no-cache-dir install conan && \
    pip3 --no-cache-dir install -Iv --user six==1.12

# Entrypoint
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh", "-v", "--" ]
CMD [ "bash" ]