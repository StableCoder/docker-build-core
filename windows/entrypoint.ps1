# Setup for MSVC
pushd "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\VC\Auxiliary\Build\"

cmd /c "vcvars64.bat&set" |
foreach {
    if ($_ -match "=") {
        $v = $_.split("="); set-item -force -path "ENV:\$($v[0])"  -value "$($v[1])"
    }
}

popd
Write-Host "`nVisual Studio 2019 Command Prompt variables set." -ForegroundColor Yellow

$env:INCLUDE = $env:INCLUDE + ";" + [System.Environment]::GetEnvironmentVariable("CUSTOM_INCLUDE","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("CUSTOM_INCLUDE","User")
$env:LIB = $env:LIB + ";" + [System.Environment]::GetEnvironmentVariable("CUSTOM_LIB","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("CUSTOM_LIB","User")

if($env:CXX -eq "clang") {
    $env:LDFLAGS="-fuse-ld=lld"
}

conan profile new --detect default

Write-Host "`n >> Conan Version" -ForegroundColor Yellow
conan --version
Write-Host "`n >> MSVC Version" -ForegroundColor Yellow
vswhere -latest -products *
Write-Host "`n >> Clang Version" -ForegroundColor Yellow
clang --version
