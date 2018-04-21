FROM centos:latest

# Enable the EPEL repository / Common Packages
RUN yum update -y \
    && yum install -y epel-release \
    && yum install -y python-pip ninja-build make cmake git subversion \
    && yum clean all \
    && pip install --upgrade pip \
    && pip install conan

# Tag Specific
RUN yum install -y clang llvm-libs \
    && yum clean all

ENV CC=clang \
    CXX=clang++

CMD ["bash"]