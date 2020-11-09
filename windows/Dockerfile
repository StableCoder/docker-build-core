# Use the latest Windows Server Core image.
FROM mcr.microsoft.com/windows/servercore:ltsc2019

# Use powershell by default
SHELL ["powershell.exe", "-ExecutionPolicy", "Bypass", "-Command"]

# Chocolatey
ENV chocolateyUseWindowsCompression=false
RUN iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Applications and setting of path
RUN choco install --yes 7zip cmake git ninja svn vswhere; \
    choco install --yes python3 --params '"/InstallDir:C:\Python3"'
RUN "[Environment]::SetEnvironmentVariable(\"Path\", [System.Environment]::GetEnvironmentVariable(\"Path\",\"Machine\") + \";C:\Program Files\7-Zip;C:\Program Files\CMake\bin;C:\Program Files\Git\bin;C:\Python3;C:\Python3\Scripts\", [System.EnvironmentVariableTarget]::Machine )"

# MSVC Build Tools 2019
RUN "& { iwr https://aka.ms/vs/16/release/vs_buildtools.exe -OutFile vs_buildtools.exe }"; \
    .\vs_buildtools.exe --quiet --wait --norestart --nocache --add Microsoft.VisualStudio.Workload.VCTools --add Microsoft.VisualStudio.Component.Windows10SDK.18362 --add Microsoft.VisualStudio.Component.VC.CoreBuildTools --add Microsoft.VisualStudio.Component.VC.Redist.14.Latest --add Microsoft.VisualStudio.Component.VC.Tools.x86.x64 | Out-Null; \
    Remove-Item -path .\vs_buildtools.exe

# Clang/LLVM
RUN choco install -y llvm

# Start developer command prompt with any other commands specified.
COPY entrypoint.ps1 C:\\ps-scripts\\entrypoint.ps1
ENTRYPOINT C:\ps-scripts\entrypoint.ps1;
