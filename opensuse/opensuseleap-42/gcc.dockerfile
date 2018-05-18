FROM opensuse/leap:42

# OS Updates / Common Packages
RUN zypper update -y \
    && zypper install -y \
    git \
    subversion \
    make \
    ninja \
    cmake \
    python3 \
    python3-pip \
    && zypper clean --all \
    && pip3 install --upgrade pip \
    && pip3 install conan

# Tag Specific
RUN zypper install -y \
    gcc \
    gcc-c++ \
    && zypper clean --all \
    && conan profile new --detect default \
    && conan profile update settings.compiler.libcxx=libstdc++11 default

CMD ["bash"]