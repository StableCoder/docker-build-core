FROM fedora:28

# OS Updates / Common Packages
RUN yum update -y \
    && yum install -y \
    git \
    subversion \
    make \
    ninja-build \
    cmake \
    && yum clean all \
    && pip3 install --upgrade pip \
    && pip3 install conan

# Tag Specific
ENV CC=clang \
    CXX=clang++

RUN yum install -y clang \
    && yum clean all \
    && conan profile new --detect default \
    && conan profile update settings.compiler.libcxx=libstdc++11 default

CMD ["bash"]

# Analysis Tools
RUN yum install -y \
    libasan \
    liblsan \
    libtsan \
    libubsan \
    clang-tools-extra \
    llvm \
    llvm-libs \
    iwyu \
    cppcheck \
    && yum clean all