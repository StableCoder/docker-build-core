Param(
    [string] $imagename="stabletec/build-core", # Core name of the image
    [switch] $n, # --no-cache mode
    [switch] $test, # Test the image
    [switch] $push, # Pushes the image (must be logged in previously)
    [switch] $rm # Removes/untags image after (for testing purposes)
)

if($n) {
    $NO_CACHE="--no-cache"
} else {
    $NO_CACHE=""
}

try {
    # Determine variants
    $VARIANTS=$(ls *.Dockerfile)

    foreach($VARIANT in $VARIANTS) {
        $TAG=(Get-Item $VARIANT).BaseName
        $FILE="$TAG.Dockerfile"

        Write-Host ">> Working on ${imagename}:${TAG} <<"

        Write-Host "docker build --pull $NO_CACHE -t ${imagename}:${TAG} -f ${FILE} ." -ForegroundColor Yellow
        docker build --pull $NO_CACHE -t ${imagename}:${TAG} -f ${FILE} .

        if($test) {
            Write-Host "docker run --rm ${imagename}:${TAG}" -ForegroundColor Yellow
            docker run --rm ${imagename}:${TAG}
        }

        if($push) {
            Write-Host "docker push ${imagename}:${TAG}" -ForegroundColor Yellow
            docker push ${imagename}:${TAG}
        }

        if($rm) {
            Write-Host "docker rmi ${imagename}:${TAG}" -ForegroundColor Yellow
            docker rmi ${imagename}:${TAG}
        }
    }
}
catch
{
    Write-Host " >> Script Failed" -ForegroundColor Red
    exit 1
}
