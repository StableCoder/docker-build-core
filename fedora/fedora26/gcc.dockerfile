FROM fedora:26

# OS Updates / Common Packages
RUN dnf update -y \
    && dnf install -y \
    git \
    subversion \
    make \
    ninja-build \
    cmake \
    && dnf clean all \
    && pip3 install --upgrade pip \
    && pip3 install conan

# Tag Specific
RUN dnf install -y \
    gcc \
    gcc-c++ \
    && dnf clean all \
    && conan profile new --detect default \
    && conan profile update settings.compiler.libcxx=libstdc++11 default

CMD ["bash"]