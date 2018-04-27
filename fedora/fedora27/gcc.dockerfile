FROM fedora:27

# OS Updates / Common Packages
RUN yum update -y \
    && yum install -y \
    git \
    subversion \
    make \
    ninja-build \
    cmake \
    libasan \
    liblsan \
    libtsan \
    libubsan \
    && yum clean all \
    && pip3 install --upgrade pip \
    && pip3 install conan

# Tag Specific
RUN yum install -y \
    gcc \
    gcc-c++ \
    && yum clean all \
    && conan profile new --detect default \
    && conan profile update settings.compiler.libcxx=libstdc++11 default

CMD ["bash"]