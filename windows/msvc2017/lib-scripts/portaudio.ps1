.\setup_msvc2017_x64.ps1
& { iwr http://www.portaudio.com/archives/pa_stable_v190600_20161030.tgz -OutFile pa-src.tgz }
7z x pa-src.tgz
7z x pa-src.tar
Remove-Item -path .\pa-src.tgz
Remove-Item -path .\pa-src.tar
cd portaudio
mkdir cbuild
cd cbuild
cmake .. -GNinja -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=C:/portaudio
ninja
# Install bin/lib
mkdir C:\portaudio\bin
mkdir C:\portaudio\lib
Copy-Item -Path portaudio_x64.dll -Destination C:\portaudio\bin
Copy-Item -Path portaudio_x64.lib -Destination C:\portaudio\lib
cd ..
Copy-Item -Path include* -Destination C:\portaudio
Get-ChildItem -Path include\ -Recurse | Copy-Item -Destination C:\portaudio\include
cd ..
Remove-Item -path portaudio -Recurse -ErrorAction SilentlyContinue

[Environment]::SetEnvironmentVariable( "PATH", [System.Environment]::GetEnvironmentVariable("PATH","Machine") + ";C:\portaudio\bin", [System.EnvironmentVariableTarget]::Machine )
[Environment]::SetEnvironmentVariable( "CUSTOM_INCLUDE", [System.Environment]::GetEnvironmentVariable("CUSTOM_INCLUDE","Machine") + ";C:\portaudio\include", [System.EnvironmentVariableTarget]::Machine )
[Environment]::SetEnvironmentVariable( "CUSTOM_LIB", [System.Environment]::GetEnvironmentVariable("CUSTOM_LIB","Machine") + ";C:\portaudio\lib", [System.EnvironmentVariableTarget]::Machine )