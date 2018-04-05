FROM fedora:latest

# OS Updates
RUN yum update -y && \
    yum clean all

# Conan
RUN pip3 install --upgrade pip && \
    pip3 install conan && \
    conan remote add stabletec https://conan.stabletec.com/artifactory/api/conan/stabletec

# Tag Specific
RUN yum install -y git ninja-build cmake libasan liblsan libtsan libubsan gcc gcc-c++ && \
    yum clean all