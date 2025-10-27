# Build Core Images

[![pipeline status](https://git.stabletec.com/docker/build-core/badges/main/pipeline.svg)](https://git.stabletec.com/docker/build-core/commits/main)
[![license](https://img.shields.io/badge/license-Apache%202.0-blue.svg)](LICENSE)
[![docker pulls](https://img.shields.io/docker/pulls/stabletec/build-core.svg)](https://hub.docker.com/r/stabletec/build-core/)
[![docker stars](https://img.shields.io/docker/stars/stabletec/build-core.svg)](https://hub.docker.com/r/stabletec/build-core/)

This contains a bunch of Dockerfiles for generating images useful as a basis for performing C/C++ development work, including available compilers and base tools. These images are meant to either be used on their own for very basic items, or as base images to be extended with additional required libraries for specific projects.

These images are used to target platforms/distributions, not specific tools or compilers, so there is some overlap between them for certain items.

## Current tags and respective `Dockerfile` links

- [`alma-8` (Dockerfile)](https://github.com/StableCoder/docker-build-core/tree/main/alma/alma-8.Dockerfile)
- [`alma-9` (Dockerfile)](https://github.com/StableCoder/docker-build-core/tree/main/alma/alma-9.Dockerfile)
- [`alma-10`, `alma` (Dockerfile)](https://github.com/StableCoder/docker-build-core/tree/main/alma/alma-10.Dockerfile)
- [`arch` (Dockerfile)](https://github.com/StableCoder/docker-build-core/tree/main/arch/arch.Dockerfile)
- [`debian-11` (Dockerfile)](https://github.com/StableCoder/docker-build-core/tree/main/debian/debian-11.Dockerfile)
- [`debian-12` (Dockerfile)](https://github.com/StableCoder/docker-build-core/tree/main/debian/debian-12.Dockerfile)
- [`debian13`, `debian` (Dockerfile)](https://github.com/StableCoder/docker-build-core/tree/main/debian/debian-13.Dockerfile)
- [`fedora-42` (Dockerfile)](https://github.com/StableCoder/docker-build-core/tree/main/fedora/fedora-42.Dockerfile)
- [`fedora-43`, `fedora` (Dockerfile)](https://github.com/StableCoder/docker-build-core/tree/main/fedora/fedora-43.Dockerfile)
- [`msys-ltsc2019-clang64` (Dockerfile)](https://github.com/StableCoder/docker-build-core/tree/main/msys-ltsc2019/msys-ltsc2019-clang64.Dockerfile)
- [`msys-ltsc2019-mingw64` (Dockerfile)](https://github.com/StableCoder/docker-build-core/tree/main/msys-ltsc2019/msys-ltsc2019-mingw64.Dockerfile)
- [`msys-ltsc2019-msys2` (Dockerfile)](https://github.com/StableCoder/docker-build-core/tree/main/msys-ltsc2019/msys-ltsc2019-msys2.Dockerfile)
- [`msys-ltsc2019-ucrt64` (Dockerfile)](https://github.com/StableCoder/docker-build-core/tree/main/msys-ltsc2019/msys-ltsc2019-ucrt64.Dockerfile)
- [`msys-ltsc2022-clang64` (Dockerfile)](https://github.com/StableCoder/docker-build-core/tree/main/msys-ltsc2022/msys-ltsc2022-clang64.Dockerfile)
- [`msys-ltsc2022-mingw64` (Dockerfile)](https://github.com/StableCoder/docker-build-core/tree/main/msys-ltsc2022/msys-ltsc2022-mingw64.Dockerfile)
- [`msys-ltsc2022-msys2` (Dockerfile)](https://github.com/StableCoder/docker-build-core/tree/main/msys-ltsc2022/msys-ltsc2022-msys2.Dockerfile)
- [`msys-ltsc2022-ucrt64` (Dockerfile)](https://github.com/StableCoder/docker-build-core/tree/main/msys-ltsc2022/msys-ltsc2022-ucrt64.Dockerfile)
- [`msys-ltsc2025-clang64` (Dockerfile)](https://github.com/StableCoder/docker-build-core/tree/main/msys-ltsc2025/msys-ltsc2025-clang64.Dockerfile)
- [`msys-ltsc2025-mingw64` (Dockerfile)](https://github.com/StableCoder/docker-build-core/tree/main/msys-ltsc2025/msys-ltsc2025-mingw64.Dockerfile)
- [`msys-ltsc2025-msys2` (Dockerfile)](https://github.com/StableCoder/docker-build-core/tree/main/msys-ltsc2025/msys-ltsc2025-msys2.Dockerfile)
- [`msys-ltsc2025-ucrt64` (Dockerfile)](https://github.com/StableCoder/docker-build-core/tree/main/msys-ltsc2025/msys-ltsc2025-ucrt64.Dockerfile)
- [`opensuse-15` (Dockerfile)](https://github.com/StableCoder/docker-build-core/tree/main/opensuse/opensuse-15.Dockerfile)
- [`opensuse-16`, `opensuse` (Dockerfile)](https://github.com/StableCoder/docker-build-core/tree/main/opensuse/opensuse-16.Dockerfile)
- [`rocky-8` (Dockerfile)](https://github.com/StableCoder/docker-build-core/tree/main/rocky/rocky-8.Dockerfile)
- [`rocky-9`(Dockerfile)](https://github.com/StableCoder/docker-build-core/tree/main/rocky/rocky-9.Dockerfile)
- [`rocky-10`, `rocky` (Dockerfile)](https://github.com/StableCoder/docker-build-core/tree/main/rocky/rocky-10.Dockerfile)
- [`ubuntu-20.04` (Dockerfile)](https://github.com/StableCoder/docker-build-core/tree/main/ubuntu/ubuntu-20.04.Dockerfile)
- [`ubuntu-22.04` (Dockerfile)](https://github.com/StableCoder/docker-build-core/tree/main/ubuntu/ubuntu-22.04.Dockerfile)
- [`ubuntu-24.04`, `ubuntu` (Dockerfile)](https://github.com/StableCoder/docker-build-core/tree/main/ubuntu/ubuntu-24.04.Dockerfile)
- [`windows-ltsc2019-vs2019` (Dockerfile)](https://github.com/StableCoder/docker-build-core/tree/main/windows-ltsc2019/windows-ltsc2019-vs2019.Dockerfile)
- [`windows-ltsc2019-vs2022`, `windows-ltsc2019` (Dockerfile)](https://github.com/StableCoder/docker-build-core/tree/main/windows-ltsc2019/windows-ltsc2019-vs2022.Dockerfile)
- [`windows-ltsc2022-vs2019` (Dockerfile)](https://github.com/StableCoder/docker-build-core/tree/main/windows-ltsc2022/windows-ltsc2022-vs2019.Dockerfile)
- [`windows-ltsc2022-vs2022`, `windows-ltsc2022` (Dockerfile)](https://github.com/StableCoder/docker-build-core/tree/main/windows-ltsc2022/windows-ltsc2022-vs2022.Dockerfile)
- [`windows-ltsc2025-vs2019` (Dockerfile)](https://github.com/StableCoder/docker-build-core/tree/main/windows-ltsc2025/windows-ltsc2025-vs2019.Dockerfile)
- [`windows-ltsc2025-vs2022`, `windows-ltsc2025`, `windows` (Dockerfile)](https://github.com/StableCoder/docker-build-core/tree/main/windows-ltsc2025/windows-ltsc2025-vs2022.Dockerfile)

## Architecture Support

| OS             | amd64 | arm64 | ppc64le | s390x | riscv64 |
| -------------- | ----- | ----- | ------- | ----- | ------- |
| Alma           | X     | X     | X       | X     |         |
| Arch (SteamOS) | X     |       |         |       |         |
| Debian 11      | X     | X     |         |       |         |
| Debian 12      | X     | X     | X       | X     |         |
| Debian 13      | X     | X     | X       | X     | X       |
| Fedora         | X     | X     | X       | X     |         |
| openSUSE 15    | X     | X     | X       | X     |         |
| openSUSE 16    | X     | X     | X       |       |         |
| Rocky 8        | X     | X     |         |       |         |
| Rocky 9/10     | X     | X     | X       | X     |         |
| Ubtuntu        | X     | X     | X       | X     | X       |
| Windows        | X     |       |         |       |         |
| MSYS/MinGW     | X     |       |         |       |         |

Images *without* an OS_VERSION, ex. `debian` or `rocky`, are based off the 'latest' tag of the base image, which often means it also shares the same image layers as the OS_VERSION's as well. Ex. `debian` uses the same layers as `debian-12` and `rocky` shares the same layers as `rocky-9`.

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
- clang/clang-cl
- CMake
- Git
- Ninja Build
- Python 3
- Subversion
- Visual Studio Build Tools (MSVC) (with Address Sanitizer)

Due to lack of forward-compatability for Windows images, they are split based on the Long-Term-Server-Core (LTSC) version, and split again on the Visual Studio versions on each base.

The Windows images default to the MSVC compiler. To use the clang/clang-cl compilers, simply define the CC/CXX environment variables when starting the container, for example:
```powershell
# Starts the Windows container, setting up with the clang-cl compiler
docker run -e CC=clang-cl -e CXX=clang-cl stabletec/build-core:windows-ltsc2022

# Starts the Windows container, setting up with the clang compiler
docker run -e CC=clang -e CXX=clang stabletec/build-core:windows-ltsc2022
```

### MSYS/MinGW

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

There are several variants on MinGW environments available, as described [here](https://www.msys2.org/docs/environments/).

Currently, only the amd64 based environments are available:
- ucrt64
- mingw64
- clang64

Due to lack of forward-compatability for Windows images, they are split based on the Long-Term-Server-Core (LTSC) version, and again on the MinGW environments.

## Analysis Tools

Fedora images also have analysis tools useful for code instrumentation and analysis:
- AddressSanitizer
- LeakSanitizer
- ThreadSanitizer
- UndefinedBehaviourSanitizer
- clang-tidy
- clang-format
- cppcheck
- llvm
- include-what-you-use (iwyu)
