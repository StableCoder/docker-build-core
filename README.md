# Build Core Images

[![pipeline status](https://git.stabletec.com/docker/build-core/badges/main/pipeline.svg)](https://git.stabletec.com/docker/build-core/commits/main)
[![license](https://img.shields.io/badge/license-Apache%202.0-blue.svg)](https://git.stabletec.com/docker/build-core/blob/main/LICENSE)
[![docker pulls](https://img.shields.io/docker/pulls/stabletec/build-core.svg)](https://hub.docker.com/r/stabletec/build-core/)
[![docker stars](https://img.shields.io/docker/stars/stabletec/build-core.svg)](https://hub.docker.com/r/stabletec/build-core/)

This contains a bunch of Dockerfiles for generating images useful as a basis for performing C/C++ development work, including available compilers and base tools. These images are meant to either be used on their own for very basic items, or as base images to be extended with additional required libraries for specific projects.

These images are used to target platforms, not specific tools or compilers, so there is some overlap between them for certain items. All images except for CentOS7 have Conan libcxx set to libstdc++11 instead of libstdc++ by default.

## Supported tags and respective `Dockerfile` links

- [`centos-7` (Dockerfile)](https://git.stabletec.com/docker/build-core/blob/main/centos/centos-7.Dockerfile)
- [`centos`, `centos-8` (Dockerfile)](https://git.stabletec.com/docker/build-core/blob/main/centos/centos.Dockerfile)
- [`debian`, `debian-9`, `debian-10` (Dockerfile)](https://git.stabletec.com/docker/build-core/blob/main/debian/debian.Dockerfile)
- [`fedora`, `fedora-31`, `fedora-32`, `fedora33` (Dockerfile)](https://git.stabletec.com/docker/build-core/blob/main/fedora/fedora.Dockerfile)
- [`opensuse`, `opensuse-15` (Dockerfile)](https://git.stabletec.com/docker/build-core/blob/main/opensuse/opensuse.Dockerfile)
- [`ubuntu`, `ubuntu-18.04`, `ubuntu-20.04` (Dockerfile)](https://git.stabletec.com/docker/build-core/blob/main/ubuntu/ubuntu.Dockerfile)
- [`windows` (Dockerfile)](https://git.stabletec.com/docker/build-core/blob/main/windows/Dockerfile)

## Architecture Support

| OS       | amd64 | arm64v8 | arm32v7 |
| -------- | ----- | ------- | ------- |
| Centos   | X     | X       |         |
| Debian   | X     | X       | X       |
| Fedora   | X     | X       |         |
| openSUSE | X     |         |         |
| Ubtuntu  | X     | X       | X       |
| Windows  | X     |         |         |

Images *without* an OS_VERSION, ex. `debian` or `centos`, are based off the 'latest' tag of the OS, which often means it also shares the same image layers as the OS_VERSION's as well. Ex. `debian` are the same layers as `debian-10` and `centos` shares the same layers as `centos-8`.

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

The Linux images default to gcc/g++ compiler. To use the clang/clang++ compilers, simply define the CC/CXX environment variables when starting the container, for example:
```sh
# Starts the fedora container, setting up with the clang/clang++ compilers
docker run -e CC=clang -e CXX=clang++ stabletec/build-core:fedora
```

### Windows

The SDK based images contain two compilers with three options available, and the basic toolset:
- Chocolatey
- Git
- Subversion
- Ninja Build
- CMake
- MSVC
- Clang/Clang-cl
- Conan
- Python 3

The Windows images default to the MSVC compiler. To use the clang/clang-cl compilers, simply define the CC/CXX environment variables when starting the container, for example:
```powershell
# Starts the Windows container, setting up with the clang-cl compiler
docker run -e CC=clang-cl -e CXX=clang-cl stabletec/build-core:windows
```

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
