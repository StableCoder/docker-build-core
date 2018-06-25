.\setup_msvc2017_x64.ps1
& { iwr https://download.qt.io/archive/qt/4.8/4.8.7/qt-everywhere-opensource-src-4.8.7.tar.gz -OutFile qt-src.tar.gz }
7z x qt-src.tar.gz
Remove-Item -path qt-src.tar.gz -Recurse -ErrorAction SilentlyContinue
7z x qt-src.tar
Remove-Item -path qt-src.tar -Recurse -ErrorAction SilentlyContinue

cd qt-everywhere-opensource-src-4.8.7
git apply .\qt4-2017.patch
configure -release -make nmake -platform win32-msvc2017 -prefix c:\Qt-4.8.7 -opensource -confirm-license -opengl desktop -nomake examples -nomake tests -no-webkit
nmake
nmake install

