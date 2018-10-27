# Build Core Images

These images are used to target platforms, not specific tools or compilers, so there is some overlap between them for certain items. All images except for CentOS7 have Conan libcxx set to libstdc++11 instead of libstdc++ by default.

## OS Images available

The following also have the 'latest' image available, based on the 'latest' tag of the docker images available.
- Fedora 26/27/28/29
- CentOS 6/7
- Debian 9
- Ubuntu 18.04
- openSUSE Leap 15

As well as these rolling release images:
- Fedora Rawhide
- openSUSE Tumbleweed

And of course, a Windows build:
- Windows 1803

## Tooling Available

These images form the core of other images used for building an assortment of C/C++ projects, and as such include this core software:
- Git
- Subversion
- Make
- Ninja Build
- CMake
- GCC
- GDB
- Clang
- LLD
- LLDB
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

## Chart

An easier to read chart of what has what.

| OS              | GCC | GDB | Clang | LLD | LLDB | Analysis Tools |
|-----------------|-----|-----|-------|-----|------|----------------|
| CentOS 6        | X   | X   |       |     |      |                |
| CentOS 7/Latest | X   | X   | X     |     | X    |                |
| Debian          | X   | X   | X     |     | X    |                |
| Fedora          | X   | X   | X     | X   | X    | X              |
| openSUSE        | X   | X   | X     | X   | X    | X              |
| Ubuntu          | X   | X   | X     | X   | X    |                |