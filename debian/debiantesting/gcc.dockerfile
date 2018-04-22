FROM debian:testing

# Core Packages
RUN apt-get update \
    && apt-get upgrade -y \
    && apt install -y wget python-pip ninja-build make cmake git subversion \
    && pip install conan

# Tag Specific
RUN apt install -y gcc g++

CMD ["bash"]