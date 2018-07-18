Param(
    [string]$Target
)

if($Target.equals("x64") -Or $Target.equals("x86")) {
    # Setup for MSVC
    pushd "C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\VC\Auxiliary\Build\"
    if($Target.equals("msvc-x64")) {
        cmd /c "vcvars64.bat&set" |
        foreach {
            if ($_ -match "=") {
                $v = $_.split("="); set-item -force -path "ENV:\$($v[0])"  -value "$($v[1])"
            }
        }
    } else {
        cmd /c "vcvars32.bat&set" |
        foreach {
            if ($_ -match "=") {
                $v = $_.split("="); set-item -force -path "ENV:\$($v[0])"  -value "$($v[1])"
            }
        }
    }
    popd
    Write-Host "`nVisual Studio 2017 Command Prompt variables set." -ForegroundColor Yellow

    $env:INCLUDE = $env:INCLUDE + ";" + [System.Environment]::GetEnvironmentVariable("CUSTOM_INCLUDE","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("CUSTOM_INCLUDE","User")
    $env:LIB = $env:LIB + ";" + [System.Environment]::GetEnvironmentVariable("CUSTOM_LIB","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("CUSTOM_LIB","User")
} else {
    if($Target.equals("gcc")) {
    # Setup for GCC
    Write-Host "`nSetting up for Win32/GCC`n"
    $env:PATH = "C:\msys64\mingw64\bin;" + $env:PATH
    $env:CC = "gcc"
    $env:CXX = "g++"
    } else {
        if($Target.equals("clang")) {
            # Setup for Clang
            Write-Host "`nSetting up for Win32/Clang`n"
            $env:PATH = "C:\msys64\mingw64\bin;" + $env:PATH
            $env:CC = "clang"
            $env:CXX = "clang++"
        }
    }
}