# Build Core Images

These images form the core of other images used for building an assortment of C/C++ projects, and as such include this core infrastructure:
- Git
- Subversion
- Make
- Ninja Build
- CMake
- Compiler (GCC, Clang or MSVC)
- Conan

Analysis images are used for code analysis and have several useful tools for performing them. They use the Clang compiler and have these extra tools:
- AddressSanitizer
- LeakSanitizer
- ThreadSanitizer
- UndefinedBehaviourSanitizer
- clang-tidy
- clang-format
- include what you use

On these OS's:
- Fedora
- CentOS
- Debian
- Ubuntu
- Windows

These images are used to target platforms, not specific tools or compilers, so there is some overlap between them for certain items. All images except for CentOS7 have Conan libcxx set to libstdc++11 instead of libstdc++ by default.