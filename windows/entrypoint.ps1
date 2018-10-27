Param(
    [string]$Target
)

# Setup for MSVC
pushd "C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\VC\Auxiliary\Build\"

cmd /c "vcvars64.bat&set" |
foreach {
    if ($_ -match "=") {
        $v = $_.split("="); set-item -force -path "ENV:\$($v[0])"  -value "$($v[1])"
    }
}

popd
Write-Host "`nVisual Studio 2017 Command Prompt variables set." -ForegroundColor Yellow

Write-Host "`n >> Conan Version" -ForegroundColor Yellow
conan --version

Write-Host "`n >> MSVC Version" -ForegroundColor Yellow
vswhere -latest -products *

$env:INCLUDE = $env:INCLUDE + ";" + [System.Environment]::GetEnvironmentVariable("CUSTOM_INCLUDE","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("CUSTOM_INCLUDE","User")
$env:LIB = $env:LIB + ";" + [System.Environment]::GetEnvironmentVariable("CUSTOM_LIB","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("CUSTOM_LIB","User")

if($Target.equals("clang-cl")) {
    $env:CC="clang-cl"
    $env:CXX="clang-cl"

    Write-Host "`n >> Clang Version" -ForegroundColor Yellow
    clang --version
}
if($Target.equals("clang")) {
    $env:CC="clang"
    $env:CXX="clang"
    $env:LDFLAGS="-fuse-ld=lld"

    Write-Host "`n >> Clang Version" -ForegroundColor Yellow
    clang --version
}
if($Target.equals("version")) {
    Write-Host "`n >> Clang Version" -ForegroundColor Yellow
    clang --version
}