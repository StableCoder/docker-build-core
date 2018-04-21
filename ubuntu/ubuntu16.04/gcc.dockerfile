FROM ubuntu:16.04

RUN apt-get update \
    && apt-get upgrade -y \
    && apt install -y python-pip ninja-build make git cmake subversion \
    && pip install conan

# Tag Specific
RUN apt install gcc g++