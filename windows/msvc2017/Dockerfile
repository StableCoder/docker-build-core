# Use the latest Windows Server Core image.
FROM microsoft/windowsservercore:1803

# Chocolatey
RUN powershell -command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"

# Applications and setting of path
RUN powershell -command "choco install -y 7zip cmake python git ninja svn"
RUN powershell -command "[Environment]::SetEnvironmentVariable( \"Path\", [System.Environment]::GetEnvironmentVariable(\"Path\",\"Machine\") + \";C:\Program Files\7-Zip;C:\Program Files\CMake\bin;C:\Program Files\Git\bin;C:\Python37;C:\Python37\Scripts\", [System.EnvironmentVariableTarget]::Machine )"

# Conan
RUN pip install conan

# MSVC Build Tools 2017
RUN powershell -command "& { iwr https://aka.ms/vs/15/release/vs_buildtools.exe -OutFile vs_buildtools.exe }" && \
    powershell -command ".\vs_buildtools.exe --quiet --wait --norestart --nocache --installPath C:\BuildTools --add Microsoft.VisualStudio.Workload.VCTools --add Microsoft.VisualStudio.Component.Windows10SDK.16299.Desktop | Out-Null" && \
    powershell -command "Remove-Item -path .\vs_buildtools.exe"
COPY setup_msvc2017_x64.bat C:\\setup_msvc2017_x64.bat
COPY setup_msvc2017_x64.ps1 C:\\setup_msvc2017_x64.ps1

# Start developer command prompt with any other commands specified.
ENTRYPOINT C:\setup_msvc2017_x64.bat &&

# Default to PowerShell if no other command specified.
CMD ["powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass"]