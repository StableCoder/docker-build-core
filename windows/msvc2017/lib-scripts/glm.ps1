.\setup_msvc2017_x64.ps1
#& { iwr https://github.com/g-truc/glm/releases/download/0.9.8.5/glm-0.9.8.5.zip -OutFile glm.zip }
7z x glm.zip
Remove-Item -path glm.zip -Recurse -ErrorAction SilentlyContinue
cd glm
mkdir build
cd build
cmake .. -GNinja -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=C:\glm
ninja
ninja install
cd ../..
Remove-Item -path glm -Recurse -ErrorAction SilentlyContinue

[Environment]::SetEnvironmentVariable( "CUSTOM_INCLUDE", [System.Environment]::GetEnvironmentVariable("CUSTOM_INCLUDE","Machine") + ";C:\glm\include", [System.EnvironmentVariableTarget]::Machine )
[Environment]::SetEnvironmentVariable( "CUSTOM_LIB", [System.Environment]::GetEnvironmentVariable("CUSTOM_LIB","Machine") + ";C:\glm\include", [System.EnvironmentVariableTarget]::Machine )