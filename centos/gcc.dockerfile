FROM centos:latest

# Change Workdir
RUN mkdir -p /root/workdir
WORKDIR /root/workdir

# Enable the EPEL repository, pip, Conan
RUN yum update -y \
    && yum install -y epel-release \
    && yum install -y python-pip \
    && yum clean all

# Conan
RUN pip install conan

# Tag Specific
RUN yum install -y gcc gcc-c++ \
    && yum clean all