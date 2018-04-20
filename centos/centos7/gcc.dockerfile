FROM centos:7

# Enable the EPEL repository, pip, Conan
RUN yum update -y \
    && yum install -y epel-release \
    && yum install -y python-pip ninja-build make cmake \
    && yum clean all

# Conan
RUN pip install --upgrade pip \
    && pip install conan

# Tag Specific
RUN yum install -y gcc gcc-c++ \
    && yum clean all