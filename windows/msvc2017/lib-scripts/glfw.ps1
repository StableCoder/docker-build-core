.\setup_msvc2017_x64.ps1
# & { iwr https://github.com/glfw/glfw/releases/download/3.2.1/glfw-3.2.1.zip -OutFile glfw.zip }
7z x glfw.zip
Remove-Item -path glfw.zip -Recurse -ErrorAction SilentlyContinue
cd glfw-3.2.1
mkdir build
cd build
cmake .. -GNinja -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=C:/glfw
ninja
ninja install
cd ../..
Remove-Item -path glfw-3.2.1 -Recurse -ErrorAction SilentlyContinue

[Environment]::SetEnvironmentVariable( "PATH", [System.Environment]::GetEnvironmentVariable("PATH","Machine") + ";C:\glfw\bin", [System.EnvironmentVariableTarget]::Machine )
[Environment]::SetEnvironmentVariable( "CUSTOM_INCLUDE", [System.Environment]::GetEnvironmentVariable("CUSTOM_INCLUDE","Machine") + ";C:\glfw\include", [System.EnvironmentVariableTarget]::Machine )
[Environment]::SetEnvironmentVariable( "CUSTOM_LIB", [System.Environment]::GetEnvironmentVariable("CUSTOM_LIB","Machine") + ";C:\glfw\lib", [System.EnvironmentVariableTarget]::Machine )