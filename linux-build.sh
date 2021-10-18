#!/usr/bin/bash
set -e

NO_CACHE=
TAG=
PUSH=

while [[ $# -gt 0 ]]; do
    key="$1"

    case $key in
    -n | --no-cache)
        NO_CACHE="--no-cache"
        shift
        ;;
    -t | --tag)
        TAG="$2"
        shift # past argument
        shift # past value
        ;;
    -p | --push)
        PUSH="--push"
        shift # past argument
        ;;
    esac
done

for FILE in $OS/*.Dockerfile; do
    FILE="$(basename -- $FILE)"

    # Remove any previous manifest
    echo "> Attempting to remove any previous manifest for localhost/$TAG:${FILE%.*}"
    if podman manifest rm localhost/$TAG:${FILE%.*}; then
        echo "> Removed old manifest for localhost/$TAG:${FILE%.*}"
    fi

    # Go through each platform and build the image for it, adding to the common manifest tag
    IFS=','
    for PLATFORM in $(cat $OS/${FILE%.*}.cfg); do
        echo "> Running: podman build --pull --layers $NO_CACHE --platform $PLATFORM --file $OS/$FILE --manifest localhost/$TAG:${FILE%.*} --tag localhost/$TAG:${FILE%.*}-$(cut -d '/' -f2 <<<$PLATFORM) ."
        podman build --pull --layers $NO_CACHE --platform $PLATFORM --file $OS/$FILE --manifest localhost/$TAG:${FILE%.*} --tag localhost/$TAG:${FILE%.*}-$(cut -d '/' -f2 <<<$PLATFORM) .
    done

    # If selected, login and push the manifest tag and associated images
    if [ ! -z $PUSH ]; then
        podman login -u $DOCKER_USER -p $DOCKER_PASSWORD docker.io
        # Using the v2s2 format to 
        echo "> Running: podman manifest push --all --format v2s2 localhost/${TAG}:${FILE%.*} docker://$TAG:${FILE%.*}"
        podman manifest push --all -f v2s2 localhost/$TAG:${FILE%.*} docker://$TAG:${FILE%.*}
    fi

    # Cleanup any manifest
    echo "> Remove image localhost/$TAG:${FILE%.*}"
    podman manifest rm localhost/$TAG:${FILE%.*}
done
