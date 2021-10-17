FROM docker.io/archlinux:latest

RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm \
    # Compilers
    gcc clang llvm python \
    # Dev Tools
    doxygen cppcheck git git-lfs subversion cmake make ninja python-pip && \
    # Cleanup
    pacman -Scc --noconfirm

RUN pip install cmake-format