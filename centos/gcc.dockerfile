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
RUN pip install conan \
    && conan remote add stabletec https://conan.stabletec.com/artifactory/api/conan/stabletec

# Tag Specific
RUN yum install -y gcc gcc-c++ \
    && yum clean all