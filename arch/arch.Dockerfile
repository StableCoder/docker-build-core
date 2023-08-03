FROM docker.io/archlinux:latest

# Update default packages
RUN pacman -Syu --noconfirm

# Install main packages
RUN pacman -S --noconfirm \
    # Compilers
    clang gcc llvm python \
    # Dev Tools
    cmake doxygen git git-lfs make ninja pkgconf python-yaml subversion \
    # Analysis
    cppcheck

# AUR
RUN pacman -S --noconfirm devtools

# cmake-format
RUN pacman -S --noconfirm python-setuptools

# Create user to do AUR builds with and switch to it
RUN useradd aur-builder
USER aur-builder
WORKDIR /home/aur-builder

# cmake-format
RUN git clone https://aur.archlinux.org/cmake-format.git
RUN cd cmake-format && makepkg

# include-what-you-use
RUN git clone https://aur.archlinux.org/include-what-you-use.git
RUN cd include-what-you-use && makepkg

# Change back to root install AUR packages
USER root
WORKDIR /

RUN pacman -U --noconfirm /home/aur-builder/cmake-format/cmake-format-*.pkg.tar.zst
RUN pacman -U --noconfirm /home/aur-builder/include-what-you-use/include-what-you-use-*.pkg.tar.zst

# Cleanup AUR stuff
RUN userdel --remove aur-builder
RUN pacman -Rs --noconfirm devtools python-setuptools

# Cleanup package manager data
RUN pacman -Scc --noconfirm
RUN rm -rf /var/cache/pacman/pkg/*