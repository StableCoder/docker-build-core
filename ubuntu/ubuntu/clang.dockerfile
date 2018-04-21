FROM ubuntu:latest

RUN apt-get update \
    && apt-get upgrade -y \
    && apt install -y python-pip ninja-build make git cmake subversion \
    && pip install conan

# Tag Specific
RUN apt install -y clang

ENV CC=clang \
    CXX=clang++