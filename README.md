# Build Core Images

[![pipeline status](https://git.stabletec.com/docker/build-core/badges/master/pipeline.svg)](https://git.stabletec.com/docker/build-core/commits/master)
[![license](https://img.shields.io/badge/license-Apache%202.0-blue.svg)](https://git.stabletec.com/docker/build-core/blob/master/LICENSE)
[![docker pulls](https://img.shields.io/docker/pulls/stabletec/build-core.svg)](https://hub.docker.com/r/stabletec/build-core/)
[![docker stars](https://img.shields.io/docker/stars/stabletec/build-core.svg)](https://hub.docker.com/r/stabletec/build-core/)

This contains a bunch of Dockerfiles for generating images useful as a basis for performing C/C++ development work, including available compilers and base tools. These images are meant to either be used on their own for very basic items, or the base images (ones without the compiler specifier) to be extended with additional required libraries for specific projects.

These images are used to target platforms, not specific tools or compilers, so there is some overlap between them for certain items. All images except for CentOS7 have Conan libcxx set to libstdc++11 instead of libstdc++ by default.

### Supported tags and respective `Dockerfile` links

- [`centos-7` (Dockerfile)](https://git.stabletec.com/docker/build-core/blob/master/centos/centos-7.Dockerfile)
- [`centos`, `centos-8` (Dockerfile)](https://git.stabletec.com/docker/build-core/blob/master/centos/centos.Dockerfile)
- [`debian`, `debian-9`, `debian-10` (Dockerfile)](https://git.stabletec.com/docker/build-core/blob/master/debian/debian.Dockerfile)
- [`fedora`, `fedora-31`, `fedora-32`, `fedora33` (Dockerfile)](https://git.stabletec.com/docker/build-core/blob/master/fedora/fedora.Dockerfile)
- [`opensuse`, `opensuse-15` (Dockerfile)](https://git.stabletec.com/docker/build-core/blob/master/opensuse/opensuse.Dockerfile)
- [`ubuntu`, `ubuntu-18.04`, `ubuntu-20.04` (Dockerfile)](https://git.stabletec.com/docker/build-core/blob/master/ubuntu/ubuntu.Dockerfile)
- [`windows`, `windows-msvc`, `windows-clang-cl`, `windows-clang` (Dockerfile)](https://git.stabletec.com/docker/build-core/blob/master/windows/Dockerfile)

#### Architecture Support

| OS       | amd64 | arm64v8 | arm32v7 |
| -------- | ----- | ------- | ------- |
| Centos   | X     | X       |         |
| Debian   | X     | X       | X       |
| Fedora   | X     | X       |         |
| openSUSE | X     |         |         |
| Ubtuntu  | X     | X       | X       |
| Windows  | X     |         |         |

##### Note: While they may share dockerfiles, during build time the first `FROM` line is replaced with the correct variant, and the `ENTRYPOINT` line is replaced appropriately for auto-loading the tagged compiler.

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
