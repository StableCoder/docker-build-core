# Use the latest Windows Server Core image.
FROM microsoft/windowsservercore:1803

# Chocolatey
RUN powershell -command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"

# Applications and setting of path
RUN powershell -command "choco install -y 7zip cmake python git ninja svn" && \
    powershell -command "[Environment]::SetEnvironmentVariable( \"Path\", [System.Environment]::GetEnvironmentVariable(\"Path\",\"Machine\") + \";C:\Program Files\7-Zip;C:\Program Files\CMake\bin;C:\Program Files\Git\bin;C:\Python37;C:\Python37\Scripts\", [System.EnvironmentVariableTarget]::Machine )"

# Conan
RUN pip --no-cache-dir install conan

# Entrypoints
COPY entrypoint.bat entrypoint.bat
COPY entrypoint.ps1 entrypoint.ps1

# MSVC Build Tools 2017
RUN powershell -command "& { iwr https://aka.ms/vs/15/release/vs_buildtools.exe -OutFile vs_buildtools.exe }" && \
    powershell -command ".\vs_buildtools.exe --quiet --wait --norestart --nocache --add Microsoft.VisualStudio.Workload.VCTools --add Microsoft.VisualStudio.Component.Windows10SDK.17134.Desktop | Out-Null" && \
    powershell -command "Remove-Item -path .\vs_buildtools.exe"

# Start developer command prompt with any other commands specified.
ENTRYPOINT call C:\entrypoint.bat x64 &&

# Default to PowerShell if no other command specified.
CMD ["powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass"]