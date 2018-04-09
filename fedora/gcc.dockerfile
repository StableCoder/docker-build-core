FROM fedora:latest

# Change Workdir
RUN mkdir -p /root/workdir
WORKDIR /root/workdir

# OS Updates / Common Packages
RUN yum update -y \
    && yum install -y \
    git \
    ninja-build \
    cmake \
    libasan \
    liblsan \
    libtsan \
    libubsan \
    && yum clean all

# Conan
RUN pip3 install conan

# Tag Specific
RUN yum install -y \
    gcc \
    gcc-c++ \
    && yum clean all