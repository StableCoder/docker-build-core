FROM centos:7

# Enable the EPEL repository / Common Packages
RUN yum update -y \
    && yum install -y epel-release \
    && yum install -y wget python-pip ninja-build make git subversion \
    && yum clean all \
    && pip install --upgrade pip \
    && pip install conan

# CMake
ARG CMAKE_MINOR_VER=3.11
ARG CMAKE_VERSION=3.11.1
RUN wget https://cmake.org/files/v${CMAKE_MINOR_VER}/cmake-${CMAKE_VERSION}-Linux-x86_64.tar.gz \
    && tar -zxf cmake-${CMAKE_VERSION}-Linux-x86_64.tar.gz \
    && cp -R cmake-${CMAKE_VERSION}-Linux-x86_64/* /usr/local/ \
    && rm -rf cmake-*

# Tag Specific
RUN yum install -y gcc gcc-c++ \
    && yum clean all

CMD ["bash"]