FROM centos:latest

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
    # Compilers
    gcc \
    gcc-c++ \
    clang \
    llvm-libs \
    && yum clean all

# Ninja
ENV NINJA_VER=1.10.0
RUN wget -q https://github.com/ninja-build/ninja/releases/download/v${NINJA_VER}/ninja-linux.zip \
    && unzip ninja-linux.zip \
    && mv ninja /usr/local/bin \
    && rm ninja-linux.zip

# Conan
RUN pip3 --no-cache-dir install conan && \
    pip3 --no-cache-dir install -Iv --user six==1.12

# Entrypoint
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh", "--" ]
CMD [ "bash" ]