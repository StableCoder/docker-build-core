# Use the latest Windows Server Core image.
FROM microsoft/windowsservercore:1709

# Chocolatey
RUN @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" \
    && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
RUN choco install -y 7zip cmake python git ninja
RUN setx /m PATH "%PATH%;C:\Program Files\7-Zip;C:\Program Files\CMake\bin;C:\Program Files\Git\bin"

# Conan
RUN pip install conan

# MSVC Build Tools 2017
RUN powershell -command "& { iwr https://aka.ms/vs/15/release/vs_buildtools.exe -OutFile vs_buildtools.exe }" \
    && setx /m PATH "%PATH%;C:\Bin" \
    && vs_buildtools.exe --quiet --wait --norestart --nocache --installPath C:\BuildTools \
    --add Microsoft.VisualStudio.Workload.VCTools \
    --add Microsoft.VisualStudio.Component.Windows10SDK.16299.Desktop \
    || IF "%ERRORLEVEL%"=="3010" EXIT 0
RUN del vs_buildtools.exe

# Start developer command prompt with any other commands specified.
ENTRYPOINT C:\BuildTools\Common7\Tools\VsDevCmd.bat && 

# Default to PowerShell if no other command specified.
CMD ["powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass"]