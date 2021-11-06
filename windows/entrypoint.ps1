# Get VS name and path
$VS_Name=vswhere -latest -products * -property displayName
$VS_Path=vswhere -latest -products * -property installationPath

# Setup for MSVC
pushd "$VS_Path\VC\Auxiliary\Build\"

cmd /c "vcvars64.bat&set" |
foreach {
    if ($_ -match "=") {
        $v = $_.split("="); set-item -force -path "ENV:\$($v[0])"  -value "$($v[1])"
    }
}

popd
Write-Host "`n$VS_Name Command Prompt variables set." -ForegroundColor Yellow

$env:INCLUDE = $env:INCLUDE + ";" + [System.Environment]::GetEnvironmentVariable("CUSTOM_INCLUDE","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("CUSTOM_INCLUDE","User")
$env:LIB = $env:LIB + ";" + [System.Environment]::GetEnvironmentVariable("CUSTOM_LIB","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("CUSTOM_LIB","User")

if($env:CXX -eq "clang") {
    $env:LDFLAGS="-fuse-ld=lld"
}

Write-Host "`n >> MSVC Version" -ForegroundColor Yellow
vswhere -latest -products *
Write-Host "`n >> Clang Version" -ForegroundColor Yellow
clang --version
