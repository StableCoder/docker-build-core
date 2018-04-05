FROM centos:latest

# Enable the EPEL repository, pip, Conan
RUN yum update -y && \
    yum install -y epel-release && \
    yum install -y python-pip && \
    yum clean all && \
    pip install conan && \
    conan remote add stabletec https://conan.stabletec.com/artifactory/api/conan/stabletec

# Tag Specific
RUN yum install -y clang llvm-libs libasan libtsan && \
    yum clean all