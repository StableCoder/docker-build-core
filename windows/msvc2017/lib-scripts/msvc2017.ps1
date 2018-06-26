# Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install popular programs
choco install -y 7zip cmake python git ninja svn

# Add new tools to machine path
[Environment]::SetEnvironmentVariable( "Path", [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";C:\Program Files\7-Zip;C:\Program Files\CMake\bin;C:\Program Files\Git\bin;C:\Python36;C:\Python36\Scripts", [System.EnvironmentVariableTarget]::Machine )
# Refresh path
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# Conan
pip install --user conan

# Install VS 2017
& { iwr https://aka.ms/vs/15/release/vs_buildtools.exe -OutFile vs_buildtools.exe }
.\vs_buildtools.exe --quiet --wait --norestart --nocache --installPath C:\BuildTools --add Microsoft.VisualStudio.Workload.VCTools --add Microsoft.VisualStudio.Component.Windows10SDK.16299.Desktop | Out-Null
rm .\vs_buildtools.exe