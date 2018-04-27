# Use the latest Windows Server Core image.
FROM microsoft/windowsservercore:1709

# Chocolatey
RUN @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" \
    && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
RUN choco install -y 7zip cmake python git ninja \
    setx /m PATH "%PATH%;C:\Program Files\7-Zip;C:\Program Files\CMake\bin;C:\Program Files\Git\bin" 

# Conan
RUN pip install conan

# Tag Specific

#\
#   && conan profile new --detect default \
#   && conan profile update settings.compiler.libcxx=libstdc++11 default