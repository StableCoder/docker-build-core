FROM docker.io/archlinux:latest

# Update default packages
RUN pacman -Syu --noconfirm \
    && pacman -S --noconfirm \
    # Compilers
    clang gcc llvm \
    # Dev Tools
    cmake git git-lfs make ninja pkgconf python subversion \
    # Cleanup package manager data
    && pacman -Scc --noconfirm \
    && rm -rf /var/cache/pacman/pkg/*
