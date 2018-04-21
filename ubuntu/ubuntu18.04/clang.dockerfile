FROM ubuntu:18.04

RUN apt update \
    && apt upgrade -y \
    && apt install -y python3-pip ninja-build make git cmake subversion \
    && pip3 install conan

# Tag Specific
RUN apt install -y clang

ENV CC=clang \
    CXX=clang++