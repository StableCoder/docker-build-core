FROM archlinux:latest

# Updates
RUN pacman -Syu --noconfirm && \
    pacman -Scc --noconfirm

# Base Compilers
RUN pacman -Sy && \
    pacman -S --noconfirm \
    # Compilers
    gcc clang llvm python \
    # Dev Tools
    doxygen cppcheck git git-lfs subversion cmake make ninja && \
    # Cleanup
    pacman -Scc --noconfirm
