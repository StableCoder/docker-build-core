#!/usr/bin/env bash
set -e

NO_CACHE=
TAG=
PUSH=
RM=
LAYERS="--layers"

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
    -r | --rm)
        RM=1
        shift
        ;;
    --no-layers)
        LAYERS=
        shift
        ;;
    esac
done

for FILE in $OS/*.Dockerfile; do
    # Get platforms for the image
    PLATFORMS=$(grep -e '^# PLATFORMS: ' $FILE | head -n 1)
    PLATFORMS=${PLATFORMS:13}

    if [[ -z $PLATFORMS ]]; then
        echo "ERROR: No platforms specified for: $FILE"
        exit 1
    fi

    FILE="$(basename -- $FILE)"

    # Remove any previous manifest
    if podman manifest exists localhost/$TAG:${FILE%.*}; then
        echo "> Removing manifest: localhost/$TAG:${FILE%.*}"
        podman manifest rm localhost/$TAG:${FILE%.*}
    fi

    # Go through each platform and build the image for it, adding to the common manifest tag
    for PLATFORM in $PLATFORMS; do
        if [[ "${FILE%.*}" == *"-"* ]]; then
            echo "> Running: podman build --pull $LAYERS $NO_CACHE --platform $PLATFORM --file $OS/$FILE --manifest localhost/$TAG:${FILE%.*} --tag localhost/$TAG:${FILE%.*}-$(cut -d '/' -f2 <<<$PLATFORM) ."
            BUILDAH_LAYERS=false podman build --pull $LAYERS $NO_CACHE --platform $PLATFORM --file $OS/$FILE --manifest localhost/$TAG:${FILE%.*} --tag localhost/$TAG:${FILE%.*}-$(cut -d '/' -f2 <<<$PLATFORM) .
        else
            if podman image exists localhost/$TAG:${FILE%.*}-$(cut -d '/' -f2 <<<$PLATFORM); then
                podman rmi localhost/$TAG:${FILE%.*}-$(cut -d '/' -f2 <<<$PLATFORM)
            fi
            echo "> Running: podman build --pull $LAYERS --platform $PLATFORM --file $OS/$FILE --manifest localhost/$TAG:${FILE%.*} --tag localhost/$TAG:${FILE%.*}-$(cut -d '/' -f2 <<<$PLATFORM) ."
            BUILDAH_LAYERS=false podman build --pull $LAYERS --platform $PLATFORM --file $OS/$FILE --manifest localhost/$TAG:${FILE%.*} --tag localhost/$TAG:${FILE%.*}-$(cut -d '/' -f2 <<<$PLATFORM) .
        fi
    done

    # If selected, push the manifest tag and associated images
    if [ ! -z $PUSH ]; then
        # Using the v2s2 format to 
        echo "> Running: podman manifest push --all --format v2s2 localhost/${TAG}:${FILE%.*} docker://$TAG:${FILE%.*}"
        podman manifest push --all -f v2s2 localhost/$TAG:${FILE%.*} docker://$TAG:${FILE%.*}
    fi

    # Cleanup any manifest
    echo "> Removing manifest: localhost/$TAG:${FILE%.*}"
    podman manifest rm localhost/$TAG:${FILE%.*}
done


if [ ! -z $RM ]; then
    for FILE in $OS/*.Dockerfile; do
        FILE="$(basename -- $FILE)"
        IFS=','
        for PLATFORM in $(cat $OS/${FILE%.*}.cfg); do
           if podman untag localhost/$TAG:${FILE%.*}-$(cut -d '/' -f2 <<<$PLATFORM); then
                echo "> Untagged image: localhost/$TAG:${FILE%.*}-$(cut -d '/' -f2 <<<$PLATFORM)"
           fi
        done
    done
fi