Param(
    [string] $imagename, # Core name of the image
    [string] $suffix, # suffix for the tag
    [switch] $n, # --no-cache mode
    [switch] $test, # Test the image
    [switch] $push, # Pushes the image (must be logged in previously)
    [switch] $rm # Removes/untags image after (for testing purposes)
)

try {
    # Blank
    Write-Host "`n >> Base Image" -ForegroundColor Yellow
    $file = '.\Dockerfile'
    $regex = 'ENTRYPOINT\s.*'
    (Get-Content $file) -replace $regex, 'ENTRYPOINT C:\ps-scripts\entrypoint.ps1 version;' | Set-Content $file

    if($n) {
        Write-Host "docker build --pull --no-cache -t ${imagename}:windows${suffix} -m 4GB ." -ForegroundColor Yellow
        docker build --pull --no-cache -t ${imagename}:windows${suffix} -m 4GB .
    } else {
        Write-Host "docker build --pull -t ${imagename}:windows${suffix} -m 4GB ." -ForegroundColor Yellow
        docker build --pull -t ${imagename}:windows${suffix} -m 4GB .
    }

    if($test) {
        Write-Host "docker run --rm ${imagename}:windows${suffix}" -ForegroundColor Yellow
        docker run --rm ${imagename}:windows${suffix}
    }

    # MSVC
    Write-Host "`n >> MSVC Image" -ForegroundColor Yellow
    $file = '.\Dockerfile'
    $regex = 'ENTRYPOINT\s.*'
    (Get-Content $file) -replace $regex, 'ENTRYPOINT C:\ps-scripts\entrypoint.ps1;' | Set-Content $file

    Write-Host "docker build --pull -t ${imagename}:windows-msvc${suffix} -m 4GB ." -ForegroundColor Yellow
    docker build --pull -t ${imagename}:windows-msvc${suffix} -m 4GB .

    if($test) {
        Write-Host "docker run --rm ${imagename}:windows-msvc${suffix}" -ForegroundColor Yellow
        docker run --rm ${imagename}:windows-msvc${suffix}
    }

    # clang-cl
    Write-Host "`n >> clang-cl Image" -ForegroundColor Yellow
    $file = '.\Dockerfile'
    $regex = 'ENTRYPOINT\s.*'
    (Get-Content $file) -replace $regex, 'ENTRYPOINT C:\ps-scripts\entrypoint.ps1 clang-cl;' | Set-Content $file

    Write-Host "docker build --pull -t ${imagename}:windows-clang-cl${suffix} -m 4GB ." -ForegroundColor Yellow
    docker build --pull -t ${imagename}:windows-clang-cl${suffix} -m 4GB .

    if($test) {
        Write-Host "docker run --rm ${imagename}:windows-clang-cl${suffix}" -ForegroundColor Yellow
        docker run --rm ${imagename}:windows-clang-cl${suffix}
    }

    # clang
    Write-Host "`n >> clang Image" -ForegroundColor Yellow
    $file = '.\Dockerfile'
    $regex = 'ENTRYPOINT\s.*'
    (Get-Content $file) -replace $regex, 'ENTRYPOINT C:\ps-scripts\entrypoint.ps1 clang;' | Set-Content $file

    Write-Host "docker build --pull -t ${imagename}:windows-clang${suffix} -m 4GB ." -ForegroundColor Yellow
    docker build --pull -t ${imagename}:windows-clang${suffix} -m 4GB .

    if($test) {
        Write-Host "docker run --rm ${imagename}:windows-clang${suffix}" -ForegroundColor Yellow
        docker run --rm ${imagename}:windows-clang${suffix}
    }

    if($push) {
        Write-Host "docker push ${imagename}:windows${suffix}" -ForegroundColor Yellow
        docker push ${imagename}:windows${suffix}
        Write-Host "docker push ${imagename}:windows-msvc${suffix}" -ForegroundColor Yellow
        docker push ${imagename}:windows-msvc${suffix}
        Write-Host "docker push ${imagename}:windows-clang-cl${suffix}" -ForegroundColor Yellow
        docker push ${imagename}:windows-clang-cl${suffix}
        Write-Host "docker push ${imagename}:windows-clang${suffix}" -ForegroundColor Yellow
        docker push ${imagename}:windows-clang${suffix}
    }

    if($rm) {
        Write-Host "docker rmi ${imagename}:windows${suffix}" -ForegroundColor Yellow
        docker rmi ${imagename}:windows${suffix}
        Write-Host "docker rmi ${imagename}:windows-msvc${suffix}" -ForegroundColor Yellow
        docker rmi ${imagename}:windows-msvc${suffix}
        Write-Host "docker rmi ${imagename}:windows-clang-cl${suffix}" -ForegroundColor Yellow
        docker rmi ${imagename}:windows-clang-cl${suffix}
        Write-Host "docker rmi ${imagename}:windows-clang${suffix}" -ForegroundColor Yellow
        docker rmi ${imagename}:windows-clang${suffix}
    }

    # Reset
    $file = '.\Dockerfile'
    $regex = 'ENTRYPOINT\s.*'
    (Get-Content $file) -replace $regex, 'ENTRYPOINT C:\ps-scripts\entrypoint.ps1 version;' | Set-Content $file
}
catch
{
    Write-Host " >> Script Failed" -ForegroundColor Red

    # Reset
    $file = '.\Dockerfile'
    $regex = 'ENTRYPOINT\s.*'
    (Get-Content $file) -replace $regex, 'ENTRYPOINT C:\ps-scripts\entrypoint.ps1 version;' | Set-Content $file
    
    exit 1
}
