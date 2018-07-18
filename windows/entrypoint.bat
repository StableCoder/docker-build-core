IF %1 == x64 GOTO MSVC64
IF %1 == x86 GOTO MSVC86
IF %1 == gcc GOTO GCC
IF %1 == clang GOTO CLANG
GOTO END

:MSVC64
call "C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\VC\Auxiliary\Build\vcvars64.bat"
set INCLUDE=%INCLUDE%;%CUSTOM_INCLUDE%
set LIB=%LIB%;%CUSTOM_LIB%
GOTO END

:MSVC86
call "C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\VC\Auxiliary\Build\vcvars32.bat"
set INCLUDE=%INCLUDE%;%CUSTOM_INCLUDE%
set LIB=%LIB%;%CUSTOM_LIB%
GOTO END

:GCC
set PATH=C:\msys64\mingw64\bin;%PATH%
set CC=gcc
set CXX=g++
GOTO END

:CLANG
set PATH=C:\msys64\mingw64\bin;%PATH%
set CC=clang
set CXX=clang++
GOTO END

:END