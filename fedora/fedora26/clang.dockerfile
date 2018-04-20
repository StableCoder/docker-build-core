FROM fedora:26

# OS Updates / Common Packages
RUN yum update -y \
    && yum install -y \
    git \
    make \
    ninja-build \
    cmake \
    libasan \
    liblsan \
    libtsan \
    libubsan \
    && yum clean all

# Conan
RUN pip3 install --upgrade pip \
    && pip3 install conan

# Tag Specific
RUN yum install -y \
    clang \
    clang-tools-extra \
    llvm \
    llvm-libs \
    && yum clean all

ENV CC=clang \
    CXX=clang++