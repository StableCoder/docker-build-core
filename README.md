# Build Core Images

[![pipeline status](https://git.stabletec.com/docker/build-core/badges/master/pipeline.svg)](https://git.stabletec.com/docker/build-core/commits/master)
[![license](https://img.shields.io/badge/license-Apache%202.0-blue.svg)](https://git.stabletec.com/docker/build-core/blob/master/LICENSE)
[![docker pulls](https://img.shields.io/docker/pulls/stabletec/build-core.svg)](https://hub.docker.com/r/stabletec/build-core/)
[![docker stars](https://img.shields.io/docker/stars/stabletec/build-core.svg)](https://hub.docker.com/r/stabletec/build-core/)

This contains a bunch of Dockerfiles for generating images useful as a basis for performing C/C++ development work, including available compilers and base tools. These images are meant to either be used on their own for very basic items, or the base images (ones without the compiler specifier) to be extended with additional required libraries for specific projects.

These images are used to target platforms, not specific tools or compilers, so there is some overlap between them for certain items. All images except for CentOS7 have Conan libcxx set to libstdc++11 instead of libstdc++ by default.

### Supported tags and respective `Dockerfile` links

- [`centos7`, `centos7-gcc`, `centos7-clang` (Dockerfile)](https://git.stabletec.com/docker/build-core/blob/master/centos/centos-7/Dockerfile)
- [`centos8`, `centos8-gcc`, `centos8-clang`, `centos`, `centos-gcc`, `centos-clang` (Dockerfile)](https://git.stabletec.com/docker/build-core/blob/master/centos/centos-8/Dockerfile)
- [`debian9`, `debian9-gcc`, `debian9-clang`, `debian10`, `debian10-gcc`, `debian10-clang`, `debian`, `debian-gcc`, `debian-clang` (Dockerfile)](https://git.stabletec.com/docker/build-core/blob/master/debian/debian-9/Dockerfile)
- [`fedora31`, `fedora31-gcc`, `fedora31-clang`, `fedora32`, `fedora32-gcc`, `fedora32-clang`, `fedora33`, `fedora33-gcc`, `fedora33-clang`, `fedora`, `fedora-gcc`, `fedora-clang` (Dockerfile)](https://git.stabletec.com/docker/build-core/blob/master/fedora/fedora-31/Dockerfile)
- [`opensuse15`, `opensuse15-gcc`, `opensuse15-clang`, `opensuse`, `opensuse-gcc`, `opensuse-clang` (Dockerfile)](https://git.stabletec.com/docker/build-core/blob/master/opensuse/opensuseleap-15/Dockerfile)
- [`ubuntu18.04`, `ubuntu18.04-gcc`, `ubuntu18.04-clang`, `ubuntu20.04`, `ubuntu20.04-gcc`, `ubuntu20.04-clang`, `ubuntu`, `ubuntu-gcc`, `ubuntu-clang` (Dockerfile)](https://git.stabletec.com/docker/build-core/blob/master/ubuntu/ubuntu-18.04/Dockerfile)
- [`windows`, `windows-msvc`, `windows-clang-cl`, `windows-clang` (Dockerfile)](https://git.stabletec.com/docker/build-core/blob/master/windows/Dockerfile)

#### Architecture Support

| OS       | amd64 | arm64v8 | arm32v7 |
| -------- | ----- | ------- | ------- |
| Centos   | X     | X       | X       |
| Debian   | X     | X       | X       |
| Fedora   | X     | X       |         |
| openSUSE | X     |         |         |
| Ubtuntu  | X     | X       | X       |
| Windows  | X     |         |         |

##### Note: While they may share dockerfiles, during build time the first `FROM` line is replaced with the correct variant, and the `ENTRYPOINT` line is replaced appropriately for auto-loading the tagged compiler.

### Tagging Scheme

Images are tagged based on the OS and the compilers automatically active when entering the container:
```
# Base Image
stabletec/build-core:${OS}${OS_VERSION}

# Compiler Image
stabletec/build-core:${OS}${OS_VERSION}-${COMPILER}
```

Images of the same OS/OS_VERSION are completely the same *except* for the `ENTRYPOINT`, where for the base image the entrypoint lists all compiler versions, and for a compiler image, automatically sets up the tagged compiler as default. Thus many image families share all but a single layer.

Images *without* an OS_VERSION, ex. `debian` or `centos`, are based off the 'latest' tag of the OS, which often means it also shares the same image layers as the OS_VERSION's as well. Ex. `debian` are the same layers as `debian10` and `centos` shares the same layers as `centos8`.

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
- Clang

### Windows

The SDK based images contain two compilers with three options available, and the basic toolset:
- Chocolatey
- Git
- Subversion
- Ninja Build
- CMake
- MSVC
- Clang
- Clang-cl
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
- llvm
