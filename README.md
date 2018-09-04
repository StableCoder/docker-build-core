# Build Core Images

These images are used to target platforms, not specific tools or compilers, so there is some overlap between them for certain items. All images except for CentOS7 have Conan libcxx set to libstdc++11 instead of libstdc++ by default.

## OS Images available

- Fedora
- CentOS
- Debian
- Ubuntu
- openSUSE
- Windows

## Tooling Available

These images form the core of other images used for building an assortment of C/C++ projects, and as such include this core infrastructure:
- Git
- Subversion
- Make
- Ninja Build
- CMake
- GCC
- GDB
- Clang
- LLD (except CentOS 7/Debian 9)
- LLDB
- Conan

## Analysis Tools

On these OS's:
- Fedora
- openSUSE Tumbleweed

These OS images also have analysis tools used for code analysis available:
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
| openSUSE Leap   | X   | X   | X     | X   | X    | X              |
| Ubuntu          | X   | X   | X     | X   | X    |                |