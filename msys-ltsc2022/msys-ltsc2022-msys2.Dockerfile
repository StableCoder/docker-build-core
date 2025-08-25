# Use the latest Windows Server Core image.
FROM mcr.microsoft.com/windows/servercore:ltsc2022

# Use powershell by default
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; \
  Invoke-WebRequest -UseBasicParsing -uri "https://github.com/msys2/msys2-installer/releases/download/nightly-x86_64/msys2-base-x86_64-latest.sfx.exe" -OutFile msys2.exe; \
  .\msys2.exe -y -oC:\; \
  Remove-Item msys2.exe ; \
  function msys() { C:\msys64\usr\bin\bash.exe @('-lc') + @Args; } \
  msys ' '; \
  msys 'pacman --noconfirm -Syuu'; \
  msys 'pacman --noconfirm -Syuu'; \
  msys 'pacman --noconfirm -Scc';

ENV MSYSTEM="MSYS2"

# Generic
RUN function msys() { C:\msys64\usr\bin\bash.exe @('-lc') + @Args; } \
    msys ' '; \
    msys 'pacman --noconfirm -Syuu'; \
    msys 'pacman --noconfirm -S msys/git msys/subversion cmake ninja python gcc clang'; \
    msys 'pacman --noconfirm -Scc'

# Clang (for GCC-primary environments)
RUN function msys() { C:\msys64\usr\bin\bash.exe @('-lc') + @Args; } \
    msys ' '; \
    msys 'pacman --noconfirm -Syuu'; \
    msys 'pacman --noconfirm -S ${MINGW_PACKAGE_PREFIX}-clang'; \
    msys 'pacman --noconfirm -Scc'

ENTRYPOINT ["C:/msys64/usr/bin/bash.exe", "-lc", "'$@'", "--"]
CMD ["bash"]