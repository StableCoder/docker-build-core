FROM centos:latest

# Change Workdir
RUN mkdir -p /root/workdir
WORKDIR /root/workdir

# Enable the EPEL repository / Common Packages
RUN yum update -y \
    && yum install -y \epel-release \
    && yum install -y python-pip \
    && yum clean all

# Conan
RUN pip install conan

# Tag Specific
RUN yum install -y clang llvm-libs \
    && yum clean all