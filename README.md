# Build Core Images

[![pipeline status](http://git.stabletec.com/docker/build-core/badges/master/pipeline.svg)](http://git.stabletec.com/docker/build-core/commits/master)
[![license](https://img.shields.io/badge/license-Apache%202.0-blue.svg)](https://git.stabletec.com/docker/build-core/blob/master/LICENSE)
[![docker pulls](https://img.shields.io/docker/pulls/stabletec/build-core.svg)](https://hub.docker.com/r/stabletec/build-core/)
[![docker stars](https://img.shields.io/docker/stars/stabletec/build-core.svg)](https://hub.docker.com/r/stabletec/build-core/)

This contains a bunch of Dockerfiles for generating images useful as a basis for performing C/C++ development work, including available compilers and base tools. These images are meant to either be used on their own for very basic items, or the base images (ones without the compiler specifier) to be extended with additional required libraries for specific projects.

These images are used to target platforms, not specific tools or compilers, so there is some overlap between them for certain items. All images except for CentOS7 have Conan libcxx set to libstdc++11 instead of libstdc++ by default.

### Supported tags and respective `Dockerfile` links

- [`centos6`, `centos6-gcc` (x86_64/Dockerfile)](https://git.stabletec.com/docker/build-core/blob/master/centos/centos-6/Dockerfile)
- [`centos7`, `centos7-gcc`, `centos7-clang` , `centos`, `centos-gcc`, `centos-clang` (x86_64/Dockerfile)](https://git.stabletec.com/docker/build-core/blob/master/centos/centos-7/Dockerfile)
- [`debian9`, `debian9-gcc`, `debian9-clang`, `debian`, `debian-gcc`, `debian-clang` (x86_64/Dockerfile)](https://git.stabletec.com/docker/build-core/blob/master/debian/debian-9/Dockerfile)
- [`fedora26`, `fedora26-gcc`, `fedora26-clang` , `fedora27`, `fedora27-gcc`, `fedora27-clang` , `fedora28`, `fedora28-gcc`, `fedora28-clang` , `fedora29`, `fedora29-gcc`, `fedora29-clang` , `fedora`, `fedora-gcc`, `fedora-clang` (x86_64/Dockerfile)](https://git.stabletec.com/docker/build-core/blob/master/fedora/fedora-26/Dockerfile)
- [`opensuse15`, `opensuse15-gcc`, `opensuse15-clang`, `opensuse`, `opensuse-gcc`, `opensuse-clang` (x86_64/Dockerfile)](https://git.stabletec.com/docker/build-core/blob/master/opensuse/opensuseleap-15/Dockerfile)
- [`ubuntu18.04`, `ubuntu18.04-gcc`, `ubuntu18.04-clang`, `ubuntu18.10`, `ubuntu18.10-gcc`, `ubuntu18.10-clang`, `ubuntu`, `ubuntu-gcc`, `ubuntu-clang` (x86_64/Dockerfile)](https://git.stabletec.com/docker/build-core/blob/master/ubuntu/ubuntu-18.04/Dockerfile)
- [`fedora-rawhide`, `fedora-rawhide-gcc`, `fedora-rawhide-clang` (x86_64/Dockerfile)](https://git.stabletec.com/docker/build-core/blob/master/rolling/fedora/Dockerfile)
- [`opensuse-tumbleweed`, `opensuse-tumbleweed-gcc`, `opensuse-tumbleweed-clang` (x86_64/Dockerfile)](https://git.stabletec.com/docker/build-core/blob/master/rolling/opensuse/Dockerfile)
- [`windows`, `windows-msvc`, `windows-clang-cl`, `windows-clang` (x86_64/Dockerfile)](https://git.stabletec.com/docker/build-core/blob/master/windows/Dockerfile)

##### Note: While they may share dockerfiles, during build time the first `FROM` line is replaced with the correct variant, and the `ENTRYPOINT` line is replaced appropriately for auto-loading the tagged compiler.

### Tagging Scheme

Images are tagged based on the OS and the compilers automatically active when entering the container:
```
# Base Image
stabletec/build-core:${OS}${OS_VERSION}

# Compiler Image
stabletec/build-core:${OS}${OS_VERSION}-${COMPILER}
```

Images of the same OS/OS_VERSION are completely the same *except* for the `ENTRYPOINT`, where for the base image the entrypoint lists all compiler versions, and for a compiler image, automatically sets up the tagged compiler as default. Thus many image families share 99% of the same layers.

Images *without* an OS_VERSION, ex. `fedora` or `centos`, are based off the 'latest' tag of the OS, which often means it also shares the same image layers as the OS_VERSION's as well. Ex. `fedora` is the same layers as `fedora29` and `centos` shares the same layers as `centos7`.

## Tooling Available

### Linux

These images form the core of other images used for building an assortment of C/C++ projects, and as such include this core software:
- Git
- Subversion
- Make
- Ninja Build
- CMake
- Conan
- Python 3
- GCC
- GDB
- Clang
- LLD
- LLDB

### Windows

The SDK based images contain two compilers with three options available, and the basic toolset:
- Chocolatey
- Git
- Subversion
- Ninja Build
- CMake
- MSVC
- Clang-cl
- Clang
- Conan
- Python 3

## Analysis Tools

The Fedora and openSUSE images also have analysis tools used for code analysis available:
- AddressSanitizer
- LeakSanitizer
- ThreadSanitizer
- UndefinedBehaviourSanitizer
- clang-tidy
- clang-format
- cppcheck
- include what you use
- llvm

## Software Chart

An easier to read chart of what has what.

| OS              | GCC | GDB | Clang | LLD | LLDB | Analysis Tools |
|-----------------|-----|-----|-------|-----|------|----------------|
| CentOS 6        | X   | X   |       |     |      |                |
| CentOS 7/Latest | X   | X   | X     |     | X    |                |
| Debian          | X   | X   | X     |     | X    |                |
| Fedora          | X   | X   | X     | X   | X    | X              |
| openSUSE        | X   | X   | X     | X   | X    | X              |
| Ubuntu          | X   | X   | X     | X   | X    |                |