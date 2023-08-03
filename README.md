# Build Core Images

[![pipeline status](https://git.stabletec.com/docker/build-core/badges/main/pipeline.svg)](https://git.stabletec.com/docker/build-core/commits/main)
[![license](https://img.shields.io/badge/license-Apache%202.0-blue.svg)](https://git.stabletec.com/docker/build-core/blob/main/LICENSE)
[![docker pulls](https://img.shields.io/docker/pulls/stabletec/build-core.svg)](https://hub.docker.com/r/stabletec/build-core/)
[![docker stars](https://img.shields.io/docker/stars/stabletec/build-core.svg)](https://hub.docker.com/r/stabletec/build-core/)

This contains a bunch of Dockerfiles for generating images useful as a basis for performing C/C++ development work, including available compilers and base tools. These images are meant to either be used on their own for very basic items, or as base images to be extended with additional required libraries for specific projects.

These images are used to target platforms/distributions, not specific tools or compilers, so there is some overlap between them for certain items.

## Supported tags and respective `Dockerfile` links

- [`alma`, `alma-8`, `alma-9` (Dockerfile)](https://git.stabletec.com/docker/build-core/blob/main/alma/)
- [`arch` (Dockerfile)](https://git.stabletec.com/docker/build-core/blob/main/arch/)
- [`centos-7` (Dockerfile)](https://git.stabletec.com/docker/build-core/blob/main/centos/)
- [`debian`, `debian-10`, `debian-11`, `debian-12` (Dockerfile)](https://git.stabletec.com/docker/build-core/blob/main/debian/)
- [`fedora`, `fedora-37`, `fedora-38` (Dockerfile)](https://git.stabletec.com/docker/build-core/blob/main/fedora/)
- [`opensuse`, `opensuse-15` (Dockerfile)](https://git.stabletec.com/docker/build-core/blob/main/opensuse/)
- [`rocky-8`, `rocky-9` (Dockerfile)](https://git.stabletec.com/docker/build-core/blob/main/rocky/)
- [`ubuntu`, `ubuntu-18.04`, `ubuntu-20.04`, `ubuntu-22.04` (Dockerfile)](https://git.stabletec.com/docker/build-core/blob/main/ubuntu/)
- [`windows`, `windows-2019`, `windows-2022` (Dockerfile)](https://git.stabletec.com/docker/build-core/blob/main/windows/)

## Architecture Support

| OS             | amd64 | arm64 | ppc64le | riscv64 |
| -------------- | ----- | ----- | ------- | ------- |
| Alma           | X     | X     | X       |         |
| Arch (SteamOS) | X     |       |         |         |
| Centos         | X     | X     |         |         |
| Debian         | X     | X     | X       |         |
| Fedora         | X     | X     | X       |         |
| openSUSE       | X     | X     | X       |         |
| Rocky          | X     | X     |         |         |
| Ubtuntu        | X     | X     | X       |         |
| Windows        | X     |       |         |         |

Images *without* an OS_VERSION, ex. `debian` or `centos`, are based off the 'latest' tag of the OS, which often means it also shares the same image layers as the OS_VERSION's as well. Ex. `debian` uses the same layers as `debian-11` and `rocky` shares the same layers as `rocky-8`.

## Tooling Available

### Linux

These images form the core of other images used for building an assortment of C/C++ projects, and as such include this core software:
- CMake
- Clang
- GCC
- Git
- Make
- Ninja Build
- pkgconf
- Python 3
- Subversion

The Linux images default to gcc/g++ compiler. To use the clang/clang++ compilers, simply define the CC/CXX environment variables when starting the container, for example:
```sh
# Starts the fedora container, setting up with the clang/clang++ compilers
docker run -e CC=clang -e CXX=clang++ stabletec/build-core:fedora
```

### Windows

The SDK based images contain two compilers with three options available, and the basic toolset:
- Chocolatey
- Clang/Clang-cl
- CMake
- Git
- Ninja Build
- Python 3
- Subversion
- Visual Studio Build Tools (MSVC)

The build tools installed matches the year of the Windows image version.

The Windows images default to the MSVC compiler. To use the clang/clang-cl compilers, simply define the CC/CXX environment variables when starting the container, for example:
```powershell
# Starts the Windows container, setting up with the clang-cl compiler
docker run -e CC=clang-cl -e CXX=clang-cl stabletec/build-core:windows

# Starts the Windows container, setting up with the clang compiler
docker run -e CC=clang -e CXX=clang stabletec/build-core:windows
```

## Analysis Tools

The Arch and Fedora images also have analysis tools used for code analysis available:
- AddressSanitizer
- LeakSanitizer
- ThreadSanitizer
- UndefinedBehaviourSanitizer
- clang-tidy
- clang-format
- cppcheck
- llvm
- include-what-you-use (iwyu)
