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

    if($n) {
        Write-Host "docker build --pull --no-cache -t ${imagename}:windows${suffix} ." -ForegroundColor Yellow
        docker build --pull --no-cache -t ${imagename}:windows${suffix} .
    } else {
        Write-Host "docker build --pull -t ${imagename}:windows${suffix} ." -ForegroundColor Yellow
        docker build --pull -t ${imagename}:windows${suffix} .
    }

    if($test) {
        Write-Host "docker run --rm ${imagename}:windows${suffix}" -ForegroundColor Yellow
        docker run --rm ${imagename}:windows${suffix}
    }

    if($push) {
        Write-Host "docker push ${imagename}:windows${suffix}" -ForegroundColor Yellow
        docker push ${imagename}:windows${suffix}
    }

    if($rm) {
        Write-Host "docker rmi ${imagename}:windows${suffix}" -ForegroundColor Yellow
        docker rmi ${imagename}:windows${suffix}
    }
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
